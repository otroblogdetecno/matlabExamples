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
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearnSF/'); 
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearnLABSF/'); 
 

 
 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathAplicacionAprender,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacionAprender,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacionAprender,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacionAprender,nombreImagenP,'_','r4.jpg');
 

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathAplicacionAprender,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacionAprender,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacionAprender,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacionAprender,nombreImagenP,'_','sN4.jpg');

%% Nombres de archivos 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 archivoVector=strcat(pathResultados,'aLABSF.csv');




%carga del listado de nombres
listado=dir(strcat(pathEntradaAprender,'*.jpg'));

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo características para entrenamiento-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    PrincipalProcesarImagen2( corrida, pathPrincipal, pathEntradaAprender, pathConfiguracion, pathAplicacionAprender, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos \n',total(1));
fprintf('El experto deberá ETIQUETAR %i filas \n',total(1));
fprintf('En el archivo %s antes de correr el clasificador \n', archivoVector);
fprintf('\n -------------------------------- \n');