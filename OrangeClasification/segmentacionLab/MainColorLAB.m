%% Segmentacion de una imagen RGB a LAB+KNN
% Se toman los datos desde una imagen RGB, luego se convierte al espacio de
% colores L*a*b, se extraen los pixeles para luego agruparlos con el
% algoritmo KNN.
% 

%% Ajuste de parámetros iniciales
clc; clear all; close all;
%% configuraciones generales
pathPrincipal='/home/usuario/ml/'; 

%% configuraciones de imágenes
%imagenNombreColor='010.jpg_rm1.jpg';
%imagenNombreColor='010.jpg_r1.jpg';
%imagenNombreColor='frutainternet.jpg';
%imagenNombreColor='012.jpg_r1.jpg';
%imagenNombreColor='012.jpg_rm1.jpg';
%imagenNombreColor='006.jpg_r1.jpg';
%imagenNombreColor='006.jpg_rm1.jpg';
%imagenNombreColor='ultima4_r1.jpg';
imagenNombreColor='ultima4_r2.jpg';
pathImagenes=strcat(pathPrincipal,'imgcolores/');
fileHandlerImgRGB=strcat(pathImagenes,imagenNombreColor); %%imagen con ruta completa

%imagenNombreColor='/home/usuario/ml/imgcolores/006.jpg_rem1.jpg';
%imagenNombreColor='/home/usuario/ml/imgcolores/010.jpg_rm1.jpg';
%imagenNombreMascara='/home/usuario/ml/imgcolores/006.jpg_sN1.jpg';

%% configuraciones del clasificador
pathPrincipal='/home/usuario/ml/'; 
pathResultados=strcat(pathPrincipal,'output/');

 %% Parametros de entrada en fomato .csv
formatSpecLAB='%f%f%f%i%i'; % formato de columnas
nombreArchivoLAB='archivoLAB.csv'; %nombre de archivo sin etiqutar
nombreArchivoLABCluster='archivoLABC.csv'; %archivo con pixeles etiqetados, se utiliza para almacenar los resultados

% manejadores de archivos con la ruta completa 
fileHandlerLAB=strcat(pathResultados,nombreArchivoLAB); %handle para conjunto de entrenamiento
fileHandlerLABCluster=strcat(pathResultados,nombreArchivoLABCluster);

% configuración del número de clusters
numeroClusters=4; 

%% Extraccion de color LAB
extraerColorLAB( fileHandlerImgRGB, fileHandlerLAB, formatSpecLAB);

%% Llamado de función de clustering
clusteringLAB(fileHandlerImgRGB, numeroClusters, fileHandlerLAB, fileHandlerLABCluster);


