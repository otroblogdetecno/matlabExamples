% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
%
% -------------------------------------
% EXTRACCIÓN DE CARACTERÍSTICAS A PARTIR DE IMÁGENES
% -------------------------------------
% Se obtienen las características de varias imágenes de figuras
% geométricas las cuales fueron confeccionadas en formato .svg y luego
% exportadas a formato .png

% * Area
% * Perimetro
% * Excentricidad
% * Redondez
% * Centroide X
% * Centroide Y
% * Orientacion
%

%%
clc; 
clear all; 
close all;

%%
%------------------------------------------------------------
 fprintf('Imagen; Area; Perimetro; Excentricidad; Redondez ;Centroide X; Centroide Y; Orientacion \n');
 %-------------------------------%-----------------------------
 calibracion('calibracion1.png'); %circulo
 calibracion('calibracion2.png'); %circulo
 calibracion('calibracion3.png'); %circulo
 calibracion('calibracion4.png'); %cuadrado
 calibracion('calibracion5.png'); %cuadrado
 calibracion('calibracion6.png'); %cuadrado  
 calibracion('calibracion7.png'); %elipse 
 calibracion('calibracion8.png'); %elipse 
 calibracion('calibracion9.png'); %elipse
 calibracion('calibracion10.png'); %rectangulo 
 calibracion('calibracion11.png'); %rectangulo  45 grados
 calibracion('calibracion12.png'); %rectangulo  alargado 0 grados 
 calibracion('calibracion13.png'); %rectangulo  alargado 0 grados  
 %-------------------------------%-----------------------------


 




