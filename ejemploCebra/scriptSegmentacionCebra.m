% Septiembre 2016
% http://otroblogdetecnologias.blogspot.com/
%
% -------------------------------------
% PRUEBAS DE SECUENCIAS DE IMAGENES
% -------------------------------------
% Ejercicio a partir de una imagen original de una cebra, obtener la cebra
% sin el fondo.

% Algoritmo general
%------------------
% La solución del ejercicio se basa en las secuencias a continuación
% Binarizar
% Erosion y definicion de elementos estructurantes
% Operación XOR
% Invertir
% Cerramiento usando elemento estructurante linea
% Operación OR
% Operacion XOR
% Invertir Imagen
% Operacion XOR
% Invertir Imagen

close all; clear all;

%Imagen original
nombreImagenOriginal='cebra.png';
Iorig=imread(nombreImagenOriginal);
figure;imshow(Iorig);

%Binarizar
%-------------------
nivel = graythresh(Iorig); %umbral de nivel de gris
IB2=im2bw(Iorig,nivel);
figure;imshow(IB2);

% Erosion
%--------------------
% Elemento estructurante CRUZ, el uno indica los valores hacia cada lado
SE = strel('diamond', 2); %elemento estructurante
IB3 = imdilate(IB2,SE);
figure;imshow(IB3);

% Erosion utilizando elemento rombo
% --------------------
SE = strel('disk', 3);
IB4 = imdilate(IB2,SE);
figure;imshow(IB4);

%Operacion XOR
%---------------------
IB5=bitxor(IB3,IB4);
figure; imshow(IB5);


%Operacion invertir imagen
%---------------------
IB6=1-IB5;
figure; imshow(IB6);

%----------------------------------------------
%Si se utiliza octagon o diamon difiere un poco
%SE=strel('octagon',21); 
%SE=strel('diamond',21);
%En la figura 5 se obtiene un resultado aproximado, utilizando disk, 15
SE=strel('disk',15);
%----------------------------------------------
 
 
IB7=imclose(IB5,SE);   
figure; imshow(IB7);
 
 
IB8=bitor(IB2,IB7);
figure; imshow(IB8);

 
IB9=bitxor(IB8,IB2);
figure; imshow(IB9);
 

IB10=1-IB9;
figure; imshow(IB10);

IB11=bitxor(IB7,IB10);
figure; imshow(IB11);

IB12=1-IB11;
figure; imshow(IB12);

%----------------------------
%Grafica en cuadros
%----------------------------
figure;
subplot(2,2,1);imshow(Iorig);
subplot(2,2,2);imshow(IB12);
subplot(2,2,3);imshow(Iorig);
subplot(2,2,4);imshow(IB2);

figure;
subplot(2,2,1);imshow(IB3);
subplot(2,2,2);imshow(IB4);
subplot(2,2,3);imshow(IB5);
subplot(2,2,4);imshow(IB6);

figure;
subplot(2,2,1);imshow(IB7);
subplot(2,2,2);imshow(IB8);
subplot(2,2,3);imshow(IB9);
subplot(2,2,4);imshow(IB10);

figure;
subplot(2,2,1);imshow(IB11);
subplot(2,2,2);imshow(IB12);

