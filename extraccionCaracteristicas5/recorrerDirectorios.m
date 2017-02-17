%%recorrerDirectorios
%obtener path
%obtener hora fecha de la corrida.
% leer directorios de un path y levantar archivos.
%recorrer todos los directorios.

% Se asume calibrado el sistema, este script recorre todos los archivos de
% un directorio de entrada.


%clc; clear all; close all;

%pathAplicacion='/home/usuario/';
%pathTemporales;
%pathEntradas='/home/usuario/ml/input2/*.jpg';


%% Variables de configuracion

%% Ajuste de parámetros iniciales
clc; clear all; close all;

 %corrida = datetime('now','Format','yyyyMMdd''T''HHmmss')
 corrida='cali';
 
 banderaCalibracion=0; %0 falta calabrar 1=calibrado
 banderaRotar=0; %0 no rotar 1=rotar
 
nombreImagenP='117.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathEntrada=strcat(pathPrincipal,'input/');
 %pathEntrada=strcat(pathPrincipal,'input2/');
 %pathEntrada='/home/usuario/Imágenes/Cámara web';
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathCalibracion=strcat(pathPrincipal,'calibration/');
 pathAplicacion=strcat(pathPrincipal,'tmp/');
 pathResultados=strcat(pathPrincipal,'output/');


 
 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathCalibracion,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathCalibracion,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathCalibracion,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathCalibracion,nombreImagenP,'_','r4.jpg');
 

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathCalibracion,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathCalibracion,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathCalibracion,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathCalibracion,nombreImagenP,'_','sN4.jpg');

 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 
 archivoVector=strcat(pathResultados,'archivo.csv');




%carga del listado de nombres
listado=dir(strcat(pathEntrada,'*.jpg'));

banderaCalibracion=1;
 NOCALIBRADO=0;
 

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf(' %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    PrincipalProcesarImagen( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos',total(1));
fprintf('\n -------------------------------- \n');