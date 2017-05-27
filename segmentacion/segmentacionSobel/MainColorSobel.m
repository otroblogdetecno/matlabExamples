%% Segmentacion de una imagen RGB a LAB+KNN
% Se toman los datos desde una imagen RGB, luego se convierte al espacio de
% colores L*a*b, se extraen los pixeles para luego agruparlos con el
% algoritmo KNN.
% 

%% Ajuste de parámetros iniciales
clc; clear all; close all;


%nombreImagenP='010.jpg';
%nombreImagenP='011.jpg';
%nombreImagenP='017.jpg';
%nombreImagenP='014.jpg';

%nombreImagenP='003.jpg';
%nombreImagenP='004.jpg';
nombreImagenP='022.jpg';


 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/'); 
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearn/'); 

 %% Salida manchas
 pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegSobel/'); 

 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
%nombreImagenRecorte1=strcat(pathAplicacionAprender,nombreImagenP,'_','r1.jpg');
%nombreImagenRecorte2=strcat(pathAplicacionAprender,nombreImagenP,'_','r2.jpg');
%nombreImagenRecorte3=strcat(pathAplicacionAprender,nombreImagenP,'_','r3.jpg');
%nombreImagenRecorte4=strcat(pathAplicacionAprender,nombreImagenP,'_','r4.jpg');



%% lectura del directorio

%carga del listado de nombres
listado=dir(strcat(pathEntradaAprender,'*.jpg'));

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo manchas Sobel-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    
    %% Imagen con fondo removido, previamente tratada on silueta
    nombreImagenRemovida1=strcat(pathAplicacionAprender,nombreImagenP,'_','rm1.jpg');
    nombreImagenRemovida2=strcat(pathAplicacionAprender,nombreImagenP,'_','rm2.jpg');
    nombreImagenRemovida3=strcat(pathAplicacionAprender,nombreImagenP,'_','rm3.jpg');
    nombreImagenRemovida4=strcat(pathAplicacionAprender,nombreImagenP,'_','rm4.jpg');

    %% salida segmentacion
    nombreImagenSalida1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','so1.jpg');
    nombreImagenSalida2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','so2.jpg');
    nombreImagenSalida3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','so3.jpg');
    nombreImagenSalida4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','so4.jpg');

    %% salida manchas
    nombreImagenDefectos1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','soM1.jpg');
    nombreImagenDefectos2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','soM2.jpg');
    nombreImagenDefectos3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','soM3.jpg');
    nombreImagenDefectos4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','soM4.jpg');

    
   %% llamado al proceso 
   tamanoManchas=2000;
   %% Proceso de produccion de imagen segmentada
   %Imagen 1 
   SegmentacionSobel(nombreImagenRemovida1, nombreImagenSalida1);
   extraerRegionManchas( nombreImagenSalida1, nombreImagenDefectos1, tamanoManchas);
   
    %Imagen 2
    SegmentacionSobel(nombreImagenRemovida2, nombreImagenSalida2);
    extraerRegionManchas( nombreImagenSalida2, nombreImagenDefectos2, tamanoManchas);
    
    %Imagen 3
    SegmentacionSobel(nombreImagenRemovida3, nombreImagenSalida3);
    extraerRegionManchas( nombreImagenSalida3, nombreImagenDefectos3, tamanoManchas);    
    
    %Imagen 4
    SegmentacionSobel(nombreImagenRemovida4, nombreImagenSalida4);
    extraerRegionManchas( nombreImagenSalida4, nombreImagenDefectos4, tamanoManchas);
    
end %

