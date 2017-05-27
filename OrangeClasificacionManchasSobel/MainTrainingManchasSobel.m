% MainTraining.m
% Esta funcion recorre un directorio y genera un conjunto de entrenamiento
% para el algoritmo, el mismo se guarda en un archivo de
% texto separado por comas .csv y sirve de entrada para el algoritmo
% clasificador.
% Se asume CALIBRADO EL SISTEMA, este script recorre todos los archivos de
% un directorio de entrada.
%
% Posteriormente, un EXPERTO DEBERA CLASIFICAR LOS RESULTADOS


%% Variables de configuracion

%% Ajuste de parámetros iniciales
clc; clear all; close all;

 
corrida='train';
 
banderaCalibracion=1; %0 falta calabrar 1=calibrado
banderaRotar=0; %0 no rotar 1=rotar
NOCALIBRADO=0;


nombreImagenP='117.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasManchas/');
 
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/');
 %pathEntradaAprender=strcat(pathPrincipal,'inputToLearnNoManchas/');
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearnManchasSobel/');
 
%% Salida manchas
 %pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegSobel/'); 


%% Nombres de archivos 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 archivoVector=strcat(pathResultados,'aManchasSCF.csv');




%carga del listado de nombres
listado=dir(strcat(pathEntradaAprender,'*.jpg'));


 

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo características para entrenamiento Sobel-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    PrincipalProcesarImagenManchasSobel( corrida, pathPrincipal, pathEntradaAprender, pathConfiguracion, pathAplicacionAprender, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos \n',total(1));
fprintf('El experto deberá ETIQUETAR %i filas \n',total(1));
fprintf('En el archivo %s antes de correr el clasificador \n', archivoVector);
fprintf('\n -------------------------------- \n');