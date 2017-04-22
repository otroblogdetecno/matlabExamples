%% Pruebas de machine learning
% 
% Según la entrada generada por el proceso de entrenamiento, a la cual un
% experto etiqueta manualmente las naranjas obtenidas y recibiendo una
% entrada de carcterísticas de una naranja a clasificar.
% Este proceso emite un resultado final clasificando la naranja según
% corresponda.

%% Ajuste de parámetros iniciales
clc; clear all; close all;

 pathPrincipal='/home/usuario/ml/'; 
 pathResultados=strcat(pathPrincipal,'output/');

 %% Parametros de entrada en fomato .csv
 nombreArchivoTraining='archivoTrainingColor.csv';
 %nombreArchivoTest='archivoTest.csv';
  nombreArchivoTest='archivoToPredictColor.csv';

% 
formatSpec='%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s%s'; %formato del archivo a leer
fileHandlerTraining=strcat(pathResultados,nombreArchivoTraining); %handle para conjunto de entrenamiento
fileHandlerTest=strcat(pathResultados,nombreArchivoTest); %handle para conjunto de prueba

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
Clasificador = fitcknn(arrayTrainingCaracteristicas,arrayTrainingClasificacion,'NumNeighbors',5,'Standardize',1);



%% --- INICIO PRINCIPAL DEL CLASIFICADOR ---
% Se levanta en una tabla el conjunto de datos a clasificar
tablaDSTest = readtable(fileHandlerTest,'Delimiter',',','Format',formatSpec);

% Se obtiene la caracteristica para comparar. La posición 13, 14, 15 corresponde a
% la etiqueta de los canales HSV
tablaDSTestComparar=tablaDSTest(:,13:15);
arrayTest=table2array(tablaDSTestComparar);


%% Recorrer archivo
indiceTest=1;
for indiceTest=1:size(arrayTest)


    %% seleccion del objeto a comparar
    objetoComparar = arrayTest(indiceTest,1:3); %objeto a comparar
    nombreDelaImagenComparar=char(table2array(tablaDSTest(indiceTest,1)));
    
    fprintf('%s, H= %f, S= %f, V= %f,',nombreDelaImagenComparar, double(objetoComparar(1)),double(objetoComparar(2)),double(objetoComparar(3)));
    
    %% Ejecucion de prediccion
    clasificacionObjeto = predict(Clasificador,objetoComparar);
    
    %% Presentacion de Resultados
    fprintf(' es => %s \n',char(clasificacionObjeto(1)));
    
end %fin de archivo

%% --- FIN PRINCIPAL DEL CLASIFICADOR    ---



