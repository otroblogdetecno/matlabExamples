%%
% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
% Ejemplo adaptado de http://www.matpic.com/esp/matlab/funcion_regionprops.html
%
% -------------------------------------
% ROTACION DE FIGURAS
% -------------------------------------
% El ejemplo está pensado para una imagen con un único objeto, existen varias
% formas de complicar el problema, por ejemplo, teniendo varios objetos,
% etiquetarlos, alinearlos y separarlos contadolos.
%
% Para evitar complicaciones, se asume que en la figura solamente se
% encuentra un elemento en la imagen.
% realizar los siguientes pasos:
% * Calcular el área.
% * Excentricidad.
% * Centroides.
% * Rectangulo que la rodea.
% * Orientacion de ejes inerciales.

% ----------------------
% Algoritmo general
% ----------------------
% Ajuste de parámetros iniciales.
% Lectura de la imagen.
% Convertir a escala de grises.
% Umbralización y Binarización.
% Invertir imagen.
% Etiquetado de áreas conectadas.
% Cálculo de propiedades de los objetos de la imagen.
% Con los elementos etiquetados, extraer las características geométricas:
%    * Area.
%    * Perímetro.  
%    * Exentricidad.
%    * Centroides.
%    * Bounding Box.
%    


%% Ajuste de parámetros iniciales
clc; clear all; close all;

imagenInicial='calibracion11.png';
tamanoAreaBorrar=1000; %tamano en pixeles de las areas a borrar
%% Lectura de la imagen
IOrig=imread(imagenInicial);

%% Convertir a escala de grises
IGray=rgb2gray(IOrig);

%% Umbralización y Binarización
umbral=graythresh(IGray);
IB1=im2bw(IGray,umbral);

%% Invertir imagen binarizada para tratamiento
IB2=1-IB1; %invertir
IB1=IB2;

%% Mostrar imagen original
subplot(2,2,1);imshow(IOrig);

%% Etiquetado de áreas conectadas, se necesita una imagen binaria
[L Ne]=bwlabel(IB1); %en L los objetos y en Ne= números de áreas etiquetadas

%% Cálculo de propiedades de los objetos de la imagen
% se toman los datos geométricos necesarios para luego poder caracterizarlos.
% se puede optar por imprimir las caracteristicas
propiedades= regionprops(L,'Area','Perimeter', 'Eccentricity','Centroid', 'BoundingBox', 'Orientation');
hold on

%% Graficar las rectángulo de frontera y etiquetar el objeto
% Se grafica un rectángulo de color verde para recortar la imagen
rectangle('Position',propiedades(1).BoundingBox,'EdgeColor','g','LineWidth',2)
text(propiedades(1).Centroid(:,1), propiedades(1).Centroid(:,2),int2str(1),'Color','g');

%% Recortar imagen
IB3=imcrop(IB1,propiedades(1).BoundingBox); %cortar imagen   
orientacionFinal=-90+propiedades(1).Orientation; %se calcula el angulo para rotar a 90 grados    
IB4 = imrotate(IB3,orientacionFinal); %rotar la imagen a 90grados


%% Mostrar imagen resultante
subplot(2,2,2);imshow(IB1);
subplot(2,2,3);imshow(IB3);
subplot(2,2,4);imshow(IB4);
