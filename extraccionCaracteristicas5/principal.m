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
 %nombreImagenP='2017-02-01-142558.jpg';
 %nombreImagenP='2017-02-01-144633.jpg';
 %nombreImagenP='2017-02-01-150250.jpg';
 nombreImagenP='2017-02-01-163416.jpg';
 %nombreImagenP='2017-01-27-160146.jpg';
 %nombreImagenP='verde_con_luz.jpg'; 


 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathEntrada=strcat(pathPrincipal,'input/');
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

 
 archivoConfiguracion=strcat(pathConfiguracion,'20170201configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170201calibracion.xml');
 
 archivoVector=strcat(pathResultados,'archivo.csv');
 
 banderaCalibracion=1;
 NOCALIBRADO=0;
 
 if(banderaCalibracion==NOCALIBRADO)
    corrida='cali';

    PrincipalProcesarImagen( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathCalibracion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
    calibracion(pathPrincipal, pathCalibracion, nombreImagenP);
    
    figure('name', 'Vistas');
        subplot(2,2,1);imshow(nombreImagenRecorte1);
        subplot(2,2,2);imshow(nombreImagenRecorte2);
        subplot(2,2,3);imshow(nombreImagenRecorte3);
        subplot(2,2,4);imshow(nombreImagenRecorte4);    
    
    figure('name', 'Siluetas');
        subplot(2,2,1);imshow(nombreImagenSiluetaN1);
        subplot(2,2,2);imshow(nombreImagenSiluetaN2);
        subplot(2,2,3);imshow(nombreImagenSiluetaN3);
        subplot(2,2,4);imshow(nombreImagenSiluetaN4);    
 else
     PrincipalProcesarImagen( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
 end %caibracion
