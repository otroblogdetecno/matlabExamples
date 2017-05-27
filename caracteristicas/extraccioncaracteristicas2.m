% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
%
% -------------------------------------
% PRUEBAS DE SECUENCIAS PARA EXTRACCION DE CARACTERISTICAS
% -------------------------------------
% A partir de una imagen de calibracion se busca obtener
% el centroide.


% Algoritmo general
%------------------

close all; clear all;

%Imagen original
nombreImagenOriginal='pezon.jpg';
Iorig=imread(nombreImagenOriginal);
figure;imshow(Iorig);


IB1=im2bw(Iorig);
figure; imshow(IB1);

IB2=1-IB1;
IB1=IB2;
%-------------------
%Calculo de area
%-------------------
area1=regionprops(IB1,'Area')
perimetro1=regionprops(IB1,'Perimeter')
excentricidad1=regionprops(IB1,'Eccentricity')

%-------------------
%Calculo del centroide
%-------------------
s  = regionprops(IB1, 'centroid');
centroids = cat(1, s.Centroid);
imshow(IB1)
hold on
plot(centroids(:,1), centroids(:,2), 'b*')
hold off

%-------------------
% Mostrar resultados
%-------------------

fprintf('Imagen; Area; Perimetro; Excentricidad; Centroide X; Centroide Y \n');
fprintf('%s; %.2i; %.2f; %.4f; %.2f; %.2f\n', nombreImagenOriginal, area1.Area, perimetro1.Perimeter, excentricidad1.Eccentricity, centroids(:,1), centroids(:,2));

%fprintf('Imagen=%s \n',nombreImagenOriginal);
%fprintf('Imagen=%.2i \n',area1.Area);
%fprintf('Perimetro=%.2i \n',perimetro1.Perimeter);
%fprintf('Imagen=%.4f \n',excentricidad1.Eccentricity);
%fprintf('Centroide x=%.2f y=%.2f \n',centroids(:,1), centroids(:,2));
