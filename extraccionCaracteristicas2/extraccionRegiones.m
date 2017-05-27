%%
% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
% Ejemplo adaptado de http://www.matpic.com/esp/matlab/funcion_regionprops.html
%
% -------------------------------------
% EXTRACCIÓN DE CARACTERÍSTICAS GEOMÉTRICAS CON ETIQUETADO DE FIGURAS
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
% Eliminar regiones con áreas menores a determinado número de pixeles.
% Buscar áreas menores al tamano indicado y marcarlas para el borrado.
% Mostrar resultados en formato vector con las características geométricas
% obtenidas de ls objetos.

%% Ajuste de parámetros iniciales
clc; clear all; close all;

imagenInicial='ultima2.jpg';
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
imshow(IOrig)

%% Etiquetado de áreas conectadas, se necesita una imagen binaria
[L Ne]=bwlabel(IB1); %en L los objetos y en Ne= números de áreas etiquetadas

%% Cálculo de propiedades de los objetos de la imagen
% se toman los datos geométricos necesarios para luego poder caracterizarlos.
propiedades= regionprops(L,'Area','Perimeter', 'Eccentricity','Centroid', 'BoundingBox');
hold on

%% Graficar las rectángulos de frontera y enumerar objetos
% Se grafican rectángulos de color verde y se enumeran los objetos en
% pantalla
for n=1:size(propiedades,1)
    rectangle('Position',propiedades(n).BoundingBox,'EdgeColor','g','LineWidth',2)
	text(propiedades(n).Centroid(:,1), propiedades(n).Centroid(:,2),int2str(n),'Color','g');
end

pause (3)

%% Buscar áreas menores al tamano indicado
% Devuelve el valor de los índices de arrays de valores que cumplen la
% condición de tamano menor al área.
s=find([propiedades.Area]<tamanoAreaBorrar);


%% Marcar áreas menores al tamano indicado
% Se recorre el array y se le pinta un rectángulo de color rojo para que
% sea visibe al operador.
for n=1:size(s,2)
    rectangle('Position',propiedades(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2)
end

pause (2)

%% Eliminar áreas menores al tamano indicado
% Se pintan de negro las áreas dentro del rectangulo, de manera a que
% queden como espacio vacio
for n=1:size(s,2)
    d=round(propiedades(s(n)).BoundingBox);
    IB1(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
end

%% Mostrar imagen resultante
figure; imshow(IB1)

%% Mostrar características geométricas
% Se recorre de principio a fin las propiedades obtenidas
fprintf('       N#;      Area;  Perimetro;  Redondez;Excentricidad; Centroide X; Centroide Y; \n');
for n=1:size(propiedades,1)
    redondez=(4*propiedades(n).Area*pi)/(propiedades(n).Perimeter^2); %fórmula de redondez de objetos
    fprintf('%10.2i; %10.2i; %10.2f; %10.4f; %10.4f; %10.2f; %10.2f; \n', n,propiedades(n).Area, propiedades(n).Perimeter, redondez,propiedades(n).Eccentricity, propiedades(n).Centroid(:,1), propiedades(n).Centroid(:,2));
end
