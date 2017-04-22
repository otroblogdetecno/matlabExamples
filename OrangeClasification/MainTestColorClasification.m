%% Pruebas del clasificador de machine learning
% Es el archivo que realizará los test y la eficacia del clasificador
% A partir de un archivo con el conjunto completo clasificado, se procede a 
% realizar los test de eficacia. Estos test pueden ayudar a saber si el
% clasificador realiza correctamente su trabajo.
% Al final muestra una matriz de resultados segú la clasificación del
% experto y del software.

%% Ajuste de parámetros iniciales
clc; clear all; close all;

 pathPrincipal='/home/usuario/ml/'; 
 pathResultados=strcat(pathPrincipal,'output/');

 
% * Leer el archivo principal.
% * Leer los valores de proporcion de los conjuntos.
% * Leer tabla del archivo conjunto principal.
% * Tomando el set principal, crear en forma aleatoria las filas del test, seleccionando 
% los valores.
% * Tomando el set principal, crear el set de training.
% Con ambos conjuntos, realizar un ciclo que clasifique y luego anote las
% buenas clasificaciones y las malas clasificaicones, con el fin de conocer
% la eficacia
 
 %% Parametros de entrada en fomato .csv
 nombreArchivoColorM='resultadomColorM.csv';
 nombreArchivoColorNM='resultadomColorNM.csv';

 
 nombreArchivoSetCompleto='archivoTrainingSetCompletoColor.csv';
 
 %Leer las 
 nombreArchivoTraining='archivoSetTrainingColor.csv';
 nombreArchivoTest='archivoSetTestColor.csv';
 
% 
formatSpec='%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s%s'; %formato del archivo a leer
fileHandlerMC1=strcat(pathResultados,nombreArchivoColorM);%handle resultados clase1
fileHandlerMC2=strcat(pathResultados,nombreArchivoColorNM);%handle resultados clase2
%fileHandlerMC3=strcat(pathResultados,nombreArchivoMC3);%handle resultados clase2


fileHandlerTraining=strcat(pathResultados,nombreArchivoTraining); %handle para conjunto de entrenamiento
fileHandlerTest=strcat(pathResultados,nombreArchivoTest); %handle para conjunto de prueba


%% Ingresar parametros
proporcionTraining=input('INGRESE EL PORCENTAGE PARA TRAINING:');

%% Definición a cero de las variables promedio
    acumuladoPrecision=0.0;
    acumuladoSensibilidad=0.0;
    acumuladoEspecificidad=0.0;

    promedioPrecision=0.0;
    promedioSensibilidad=0.0;
    promedioEspecificidad=0.0;

%% total de experimentos
totalPruebas=10;
%% Pruebas
% bucle para repetir pruebas
for(prueba=1:1:totalPruebas)
%% 
fprintf('-----------------------------------\n');
fprintf('PRUEBA # %i \n',prueba);
fprintf('-----------------------------------\n');
dividirConjuntos( proporcionTraining, pathPrincipal, nombreArchivoSetCompleto, nombreArchivoTraining, nombreArchivoTest);


%% Carga del dataset de entrenamiento
% se cargan los datos en una tabla
tablaDSTraining = readtable(fileHandlerTraining,'Delimiter',',','Format',formatSpec);

%se cargan las etiquetas de clasificacion, el lugar 18 corresponde a la
%etiqueta de clasificacion de COLOR
tablaDSTrainingClasificacion=tablaDSTraining(:,18);

% se cargan las caracteristicas que alimentaran al clasificador, el lugar
% 13,14,15 corresponde a la etiqueta de h,s,v
tablaDSTrainingCaracteristicas=tablaDSTraining(:,13:15);


%% Conversion de tablas a array cell
% Con el fin de ingresar al clasificador se realizan las conversiones de
% tipo
arrayTrainingClasificacion=table2cell(tablaDSTrainingClasificacion);


%Conversion de tabla a array y de array a matriz
arrayTrainingCaracteristicas=table2array(tablaDSTrainingCaracteristicas);


%% Entrenamiento del clasificador
% Se alimenta al clasficador con caracteristicas y las etiquetas para las
% mismas
fprintf('Entrenando clasificador \n');
Clasificador = fitcknn(arrayTrainingCaracteristicas,arrayTrainingClasificacion,'NumNeighbors',5,'Standardize',1);


%% Dividir archivos



%% --- INICIO PRINCIPAL DEL CLASIFICADOR ---
% Se levanta en una tabla el conjunto de datos a clasificar
tablaDSTest = readtable(fileHandlerTest,'Delimiter',',','Format',formatSpec);


% Se obtiene la caracteristica para comparar. La posición 13, 14, 15 corresponde a
% la etiqueta de los canales HSV
tablaDSTestComparar=tablaDSTest(:,13:15);
arrayTest=table2array(tablaDSTestComparar);

%% Definicion de variables a cero
    TP=0;
    TN=0;    
    FP=0;
    FN=0;
    
    precision=0.0;
    sensibilidad=0.0;
    especificidad=0.0;


%contadorVP=0;
%contadorP=0;
%contadorM=0;
%contadorG=0;
%contadorNI=0;


matrizResultados=zeros(2,2);
%% Recorrer archivo
indiceTest=1;
for indiceTest=1:size(arrayTest)
    %% seleccion del objeto a comparar
    objetoComparar = arrayTest(indiceTest,1:3); %objeto a comparar
    nombreDelaImagenComparar=char(table2array(tablaDSTest(indiceTest,1)));
    etiquetaComparar=char(table2array(tablaDSTest(indiceTest,18)));
    
    %% Ejecucion de prediccion
    clasificacionObjeto = predict(Clasificador,objetoComparar);
    
    %% Presentacion de Resultados        
        % ---------------------------------------------------------------
        filaMatriz=1;
        columnaMatriz=1;
        
        switch char(clasificacionObjeto(1))
            case 'MANCHADO'
                columnaMatriz=1;
            case 'NO MANCHADO'
                columnaMatriz=2;                 
        end

        switch etiquetaComparar
            case 'MANCHADO'
                filaMatriz=1;
            case 'NO MANCHADO'
                filaMatriz=2;                
        end
        % --------------------------------------------------------------

    matrizResultados(filaMatriz,columnaMatriz)=matrizResultados(filaMatriz,columnaMatriz)+1;        
    if(strcmp(etiquetaComparar,clasificacionObjeto(1)))

    else
        fprintf('%s, h = %f, s = %f, v = %f, ce= %s ',nombreDelaImagenComparar, double(objetoComparar(1)), double(objetoComparar(2)), double(objetoComparar(3)),etiquetaComparar);        
        fprintf('cs=> %s \n',char(clasificacionObjeto(1)));
%        fprintf(' NO IGUALES \n');
    end%comparacion
    
end %fin de archivo

%% --- FIN PRINCIPAL DEL CLASIFICADOR    ---

fprintf('Resultados \n');
fprintf('-----------\n');

%% Mostrar resultados de la matriz
[totalFilas, totalColumnas]=size(matrizResultados);
    fprintf(' clas.software                        |\n');
    fprintf(' MANCHADO | NO MANCHADO | clas.experto|\n');
for(filas=1:1:totalFilas)
    for(columnas=1:1:totalColumnas)
        fprintf('%10i|',matrizResultados(filas,columnas));
    end%for

    switch filas
        case 1
            fprintf(' MANCHADO        |');
        case 2
            fprintf(' NO MANCHADO     |');
    end    
    fprintf('\n');           
end %end for

%% Calcular resultados parciales
    TP=matrizResultados(1,1);
    TN=matrizResultados(2,2);    
    FP=matrizResultados(1,2);
    FN=matrizResultados(2,1);

    
    precision=TP/(TP+FP);
    sensibilidad=TP/(TP+FN);
    especificidad=TN/(TN+FP);

    acumuladoPrecision=acumuladoPrecision+precision;
    acumuladoSensibilidad=acumuladoSensibilidad+sensibilidad;
    acumuladoEspecificidad=acumuladoEspecificidad+especificidad;

    
    fprintf('PRUEBA %i-> precision=%f, sensibilidad=%f especificidad=%f\n', prueba,precision, sensibilidad, especificidad);
    fprintf('APrecision=%f, ASensibilidad=%f AEspecificidad=%f\n', acumuladoPrecision, acumuladoSensibilidad, acumuladoEspecificidad);    
    
    % Presentacion de resultados
    %for(i=1:1:totalFilas)
    %    precision=precisionClase(matrizResultados,i);
    %    sensibilidad=sensitivityClase(matrizResultados,i);
    %    especificidad=specificityClase(matrizResultados,i);
        
    %    fprintf('Clase=%i, precision=%f, sensibilidad=%f especificidad=%f\n', i, precision, sensibilidad, especificidad);
    %    filaResultadosMetricas=sprintf('%f, %f, %f, \n',precision, sensibilidad, especificidad);
        
    %    switch i
    %        case 1
    %            guardarArchivoMetricas(fileHandlerMC1,filaResultadosMetricas);
    %        case 2
    %            guardarArchivoMetricas(fileHandlerMC2,filaResultadosMetricas);
    %        case 3
    %            guardarArchivoMetricas(fileHandlerMC3,filaResultadosMetricas);
    %    end                    
    %end %
    %totalPruebas
    



    
end% final de las pruebas



    promedioPrecision=acumuladoPrecision/totalPruebas;
    promedioSensibilidad=acumuladoSensibilidad/totalPruebas;
    promedioEspecificidad=acumuladoEspecificidad/totalPruebas;
    fprintf('--------------------------------\n');
    fprintf('PROPORCION: %f-%f RESULTADO PROMEDIO EN %i PRUEBAS\n',proporcionTraining,(100-proporcionTraining),totalPruebas);
    fprintf('--------------------------------\n');    
    fprintf('APrecision=%f, ASensibilidad=%f AEspecificidad=%f\n', acumuladoPrecision, acumuladoSensibilidad, acumuladoEspecificidad);
    
    fprintf('precision=%f, sensibilidad=%f especificidad=%f\n', promedioPrecision, promedioSensibilidad, promedioEspecificidad);
