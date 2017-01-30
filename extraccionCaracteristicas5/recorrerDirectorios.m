%%recorrerDirectorios
%obtener path
%obtener hora fecha de la corrida.
% leer directorios de un path y levantar archivos.
%recorrer todos los directorios.

%/home/usuario/entrada

clc; clear all; close all;

pathAplicacion='/home/usuario/';
pathTemporales;
pathEntradas='/home/usuario/Imágenes/Cámara web/*.jpg';

%carga del listado de nombres
listado=dir(pathEntradas);

%%lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
 fprintf(' %s \n',listado(n).name);    
end %

%s=strcat(s1,s2)