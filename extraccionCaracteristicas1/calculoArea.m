% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
%
% -------------------------------------
% PRUEBAS DE SECUENCIAS PARA EXTRACCION DE CARACTERISTICAS
% -------------------------------------
% A partir de una imagen, se busca obtener características
% sin el fondo.

% Algoritmo general
%------------------

close all; clear all;

%Imagen original
%nombreImagenOriginal='naranja-b-1.jpg';
nombreImagenOriginal='calibracionCirculo1.jpg';
Iorig=imread(nombreImagenOriginal);
figure;imshow(Iorig);


IB1=im2bw(Iorig);
figure;imshow(IB1);

IB5=1-IB1;

figure;imshow(IB5);


area1=regionprops(IB5,'Area')
perimetro1=regionprops(IB5,'Perimeter')

area2=regionprops(IB1,'Area')
perimetro2=regionprops(IB1,'Perimeter')