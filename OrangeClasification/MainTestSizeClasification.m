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
 nombreArchivoMC1='resultadomc1.csv';
 nombreArchivoMC2='resultadomc2.csv';
 nombreArchivoMC3='resultadomc3.csv';
 
 nombreArchivoSetCompleto='archivoTrainingSetCompleto.csv';
 
 %Leer las 
 nombreArchivoTraining='archivoSetTraining.csv';
 nombreArchivoTest='archivoSetTest.csv';
 
% 
formatSpec='%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s'; %formato del archivo a leer
fileHandlerMC1=strcat(pathResultados,nombreArchivoMC1);%handle resultados clase1
fileHandlerMC2=strcat(pathResultados,nombreArchivoMC2);%handle resultados clase2
fileHandlerMC3=strcat(pathResultados,nombreArchivoMC3);%handle resultados clase2


fileHandlerTraining=strcat(pathResultados,nombreArchivoTraining); %handle para conjunto de entrenamiento
fileHandlerTest=strcat(pathResultados,nombreArchivoTest); %handle para conjunto de prueba


%% Ingresar parametros
proporcionTraining=input('INGRESE EL PORCENTAGE PARA TRAINING:');

%% Pruebas
% bucle para repetir pruebas
for(prueba=1:1:100)
%% 
dividirConjuntos( proporcionTraining, pathPrincipal, nombreArchivoSetCompleto, nombreArchivoTraining, nombreArchivoTest);


%% Carga del dataset de entrenamiento
% se cargan los datos en una tabla
tablaDSTraining = readtable(fileHandlerTraining,'Delimiter',',','Format',formatSpec);

%se cargan las etiquetas de clasificacion, el lugar 16 corresponde a la
%etiqueta de clasificacion
tablaDSTrainingClasificacion=tablaDSTraining(:,16);

% se cargan las caracteristicas que alimentaran al clasificador, el lugar 7
% corresponde a la etiqueta de diametro en milímetros
tablaDSTrainingCaracteristicas=tablaDSTraining(:,7);

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

% Se obtiene la caracteristica para comparar. La posición 7 corresponde a
% la etiqueta del diámetro en milímetros
tablaDSTestComparar=tablaDSTest(:,7);
arrayTest=table2array(tablaDSTestComparar);


contadorVP=0;
contadorP=0;
contadorM=0;
contadorG=0;
contadorNI=0;

matrizResultados=zeros(3,3);
%% Recorrer archivo
indiceTest=1;
for indiceTest=1:size(arrayTest)


    %% seleccion del objeto a comparar
    objetoComparar = arrayTest(indiceTest); %objeto a comparar
    nombreDelaImagenComparar=char(table2array(tablaDSTest(indiceTest,1)));
    etiquetaComparar=char(table2array(tablaDSTest(indiceTest,16)));
    
    %% Ejecucion de prediccion
    clasificacionObjeto = predict(Clasificador,objetoComparar);
    
    %% Presentacion de Resultados


        
        % ---------------------------------------------------------------
        filaMatriz=1;
        columnaMatriz=1;
        
        switch char(clasificacionObjeto(1))
            case 'pequena'
                columnaMatriz=1;
            case 'mediana'
                columnaMatriz=2;                
            case 'grande'
                columnaMatriz=3;                
        end

        switch etiquetaComparar
            case 'pequena'
                filaMatriz=1;
            case 'mediana'
                filaMatriz=2;                
            case 'grande'
                filaMatriz=3;                
        end
        % --------------------------------------------------------------

    matrizResultados(filaMatriz,columnaMatriz)=matrizResultados(filaMatriz,columnaMatriz)+1;        
    if(strcmp(etiquetaComparar,clasificacionObjeto(1)))

    else
        fprintf('%s, Diametro = %f, ce= %s ',nombreDelaImagenComparar, double(objetoComparar(1)),etiquetaComparar);        
        fprintf('cs=> %s \n',char(clasificacionObjeto(1)));
%        fprintf(' NO IGUALES \n');
    end%comparacion
    
end %fin de archivo

%% --- FIN PRINCIPAL DEL CLASIFICADOR    ---

fprintf('Resultados \n');
fprintf('-----------\n');

%% Mostrar resultados de la matriz
[totalFilas, totalColumnas]=size(matrizResultados);
    fprintf(' clas.software                  |\n');
    fprintf(' pequeno  | mediana  | grande   | clas.experto|\n');
for(filas=1:1:totalFilas)
    for(columnas=1:1:totalColumnas)
        fprintf('%10i|',matrizResultados(filas,columnas));
    end%for

    switch filas
        case 1
            fprintf(' pequeno     |');
        case 2
            fprintf(' mediana     |');
        case 3
            fprintf(' grande      |');
    end    
    fprintf('\n');           
end %end for


    TP=matrizResultados(1,1)+matrizResultados(2,2)+matrizResultados(3,3);
    FP=matrizResultados(2,1)+matrizResultados(3,1)+matrizResultados(3,2);
    FN=matrizResultados(1,2)+matrizResultados(1,3)+matrizResultados(2,3);

    % Presentacion de resultados
    for(i=1:1:totalFilas)
        precision=precisionClase(matrizResultados,i);
        sensibilidad=sensitivityClase(matrizResultados,i);
        especificidad=specificityClase(matrizResultados,i);
        
        fprintf('Clase=%i, precision=%f, sensibilidad=%f especificidad=%f\n', i, precision, sensibilidad, especificidad);
        filaResultadosMetricas=sprintf('%f, %f, %f, \n',precision, sensibilidad, especificidad);
        
        switch i
            case 1
                guardarArchivoMetricas(fileHandlerMC1,filaResultadosMetricas);
            case 2
                guardarArchivoMetricas(fileHandlerMC2,filaResultadosMetricas);
            case 3
                guardarArchivoMetricas(fileHandlerMC3,filaResultadosMetricas);
        end    
        
        

    end %

end% final de las pruebas