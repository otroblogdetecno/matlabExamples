function [ output_args ] = MainGetImageToProcess()
%%getImageToProcess
% Asume la entrada de una imagen y produce un vector de caracteristicas el
% cual será utilizado para comparar contra un algoritmo entrenado
% Esta funcionalidad asume calibrado el sistema

%% Ajuste de parámetros iniciales
clc; clear all; close all;

nombreImagenP='117.jpg';
corrida='cali';
 
banderaCalibracion=1; %0=falta calabrar 1=calibrado
banderaRotar=0; %0 no rotar 1=rotar
 


 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/');

 pathEntradaAPredecir=strcat(pathPrincipal,'inputToPredict/');
 pathAplicacionPrediccion=strcat(pathPrincipal,'tmpToPredict/'); 


 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathAplicacionPrediccion,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacionPrediccion,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacionPrediccion,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacionPrediccion,nombreImagenP,'_','r4.jpg');
 

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathAplicacionPrediccion,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacionPrediccion,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacionPrediccion,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacionPrediccion,nombreImagenP,'_','sN4.jpg');

 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 archivoVector=strcat(pathResultados,'archivoToPredict.csv');




%carga del listado de nombres
listado=dir(strcat(pathEntradaAPredecir,'*.jpg'));


%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf(' %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    PrincipalProcesarImagen( corrida, pathPrincipal, pathEntradaAPredecir, pathConfiguracion, pathAplicacionPrediccion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
end %

total=size(listado);

fprintf('\n -------------------------------------------------- \n');
fprintf('Se extrajeron características desde %i archivos',total(1));
fprintf('\n -------------------------------------------------- \n');



end %fin MainGetImageToProcess