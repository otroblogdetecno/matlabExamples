function [ ] = calibracion( nombreImagenOriginal )


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


%Imagen original
Iorig=imread(nombreImagenOriginal);

%figure;imshow(Iorig);


IB1=im2bw(Iorig);
%figure; imshow(IB1);

IB2=1-IB1;
IB1=IB2;

%% Calculo de caracteristicas geometricas

area1=regionprops(IB1,'Area');
perimetro1=regionprops(IB1,'Perimeter');
excentricidad1=regionprops(IB1,'Eccentricity');
orientacion1=regionprops(IB1,'Orientation');
redondez1=(4*area1.Area*pi)/(perimetro1.Perimeter^2);
s  = regionprops(IB1, 'centroid');
centroids = cat(1, s.Centroid);

%imshow(IB1); hold on; plot(centroids(:,1), centroids(:,2), 'b*'); hold off


%% Mostrar resultados

%fprintf('Imagen; Area; Perimetro; Excentricidad; Redondez ;Centroide X; Centroide Y, Orientacion \n');
fprintf('%s; %.2i; %.2f; %.4f; %.4f; %.2f; %.2f; %.4f \n', nombreImagenOriginal, area1.Area, perimetro1.Perimeter, excentricidad1.Eccentricity, redondez1 ,centroids(:,1), centroids(:,2), orientacion1.Orientation);



end

