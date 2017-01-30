%% Script principal
% Se agregan los scripts del programa principal

%% --------------------------------------------
%%----- inicio cuerpo de la funcion -----
%% Ajuste de parámetros iniciales
clc; clear all; close all;

 %corrida = datetime('now','Format','yyyyMMdd''T''HHmmss')
 corrida='cali';
 
 banderaCalibracion=1; %0 falta calabrar 1=calibrado
 banderaRotar=0; %0 no rotar 1=rotar

 
 %nombreImagenP='ultima4.jpg';
 %nombreImagenP='2017-01-27-153742.jpg';
 nombreImagenP='2017-01-27-161012.jpg';
 %nombreImagenP='2017-01-27-160146.jpg';
 %nombreImagenP='verde_con_luz.jpg'; 
 
 pathPrincipal='/home/usuario/ml/'; 
 pathEntrada=strcat(pathPrincipal,'input/');
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathAplicacion=strcat(pathPrincipal,'tmp/');
 pathResultados=strcat(pathPrincipal,'output/');

 
 archivoConfiguracion=strcat(pathConfiguracion,'20170127configuracion.xml');
 archivoVector=strcat(pathResultados,'archivo.csv');
 
 PrincipalProcesarImagen( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoVector );
 