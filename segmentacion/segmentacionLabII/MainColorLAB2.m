%% Segmentacion de una imagen RGB a LAB+KNN
% Se toman los datos desde una imagen RGB, luego se convierte al espacio de
% colores L*a*b, se extraen los pixeles para luego agruparlos con el
% algoritmo KNN.
% 

%% Ajuste de parámetros iniciales
clc; clear all; close all;


%nombreImagenP='010.jpg';
%nombreImagenP='011.jpg';
nombreImagenP='013.jpg';
%nombreImagenP='014.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/'); 
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearn/'); 

 %% Salida manchas
 pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegLAB/'); 

 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
%nombreImagenRecorte1=strcat(pathAplicacionAprender,nombreImagenP,'_','r1.jpg');
%nombreImagenRecorte2=strcat(pathAplicacionAprender,nombreImagenP,'_','r2.jpg');
%nombreImagenRecorte3=strcat(pathAplicacionAprender,nombreImagenP,'_','r3.jpg');
%nombreImagenRecorte4=strcat(pathAplicacionAprender,nombreImagenP,'_','r4.jpg');





%% Llamado de función de clustering
% primero nombreImagenSegmentar y segundo nombreImagenSalida que es una
% salida parcial

numeroClusteres=4;


%carga del listado de nombres
listado=dir(strcat(pathEntradaAprender,'*.jpg'));

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo manchas-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    
    nombreImagenRemovida1=strcat(pathAplicacionAprender,nombreImagenP,'_','rm1.jpg');
    nombreImagenRemovida2=strcat(pathAplicacionAprender,nombreImagenP,'_','rm2.jpg');
    nombreImagenRemovida3=strcat(pathAplicacionAprender,nombreImagenP,'_','rm3.jpg');
    nombreImagenRemovida4=strcat(pathAplicacionAprender,nombreImagenP,'_','rm4.jpg');

    %% salida segmentacion
    nombreImagenSalida1=strcat(pathAplicacionSalidaSeg,nombreImagenP);
    nombreImagenSalida2=strcat(pathAplicacionSalidaSeg,nombreImagenP);
    nombreImagenSalida3=strcat(pathAplicacionSalidaSeg,nombreImagenP);
    nombreImagenSalida4=strcat(pathAplicacionSalidaSeg,nombreImagenP);

    
    ClusteringLAB2(numeroClusteres, nombreImagenRemovida1, nombreImagenSalida1,'1');    
end %



%ClusteringLAB2(numeroClusteres, nombreImagenRemovida1, nombreImagenSalida1,'1');
%ClusteringLAB2(numeroClusteres, nombreImagenRemovida2, nombreImagenSalida2,'2');
%ClusteringLAB2(numeroClusteres, nombreImagenRemovida3, nombreImagenSalida3,'3');
%ClusteringLAB2(numeroClusteres, nombreImagenRemovida4, nombreImagenSalida4,'4');

%mejoras(numeroClusteres, nombreImagenRemovida1, nombreImagenSalida1,'1');
%mejoras(numeroClusteres, nombreImagenRemovida2, nombreImagenSalida2,'2');
%mejoras(numeroClusteres, nombreImagenRemovida3, nombreImagenSalida3,'3');
%mejoras(numeroClusteres, nombreImagenRemovida4, nombreImagenSalida4,'4');
