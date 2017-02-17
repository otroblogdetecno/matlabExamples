% Cálculo de la segmentación
%

%% Ajuste de parámetros iniciales
clc; clear all; close all;

%% Datos de configuración
imagenInicial='cuadro1.jpg';

%% Lectura de la imagen
IOrig=imread(imagenInicial);

%% Rotacion de la imagen
%IOrigTemp = imrotate(IOrig,180); %rotar la imagen
%IOrig=IOrigTemp;

figure; imshow(IOrig);




%%% Obtener tamaño de la imagen
%[filas,columnas]=size(IOrig);

%%% Convertir a escala de grises
IGray=rgb2gray(IOrig);

%%% Umbralización y Binarización
umbral=graythresh(IGray);
IB1=im2bw(IGray,umbral);
figure; imshow(IB1)




%%% separar los canales
%rgbImagen=IOrig;
%canalRojo = rgbImagen(:, :, 1);
%canalVerde = rgbImagen(:, :, 2);
%canalAzul = rgbImagen(:, :, 3);

%%figure; imshow(canalRojo);
%%figure; imshow(canalVerde);
%%figure; imshow(canalAzul);


%%% canal rojo binario
%umbral=graythresh(canalRojo);
%IB1=im2bw(canalRojo,umbral);
%figure; imshow(IB1)

%%% Invertir la imagen
%IB2=1-IB1;
%figure; imshow(IB2);
%%hold on;
%%p1=[0 100]; p2=[100 100];
%%line(p1, p2);

%hold on;
%plot([100 0],[100 100],'+');

%%% Graficar lineas
