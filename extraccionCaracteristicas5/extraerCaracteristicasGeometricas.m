%function [ output_args ] = extraerCaracteristicasGeometricas()
function [ imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor ] = extraerCaracteristicasGeometricas( imagenNombreSilueta, tamano)
% Extraer el área desde la figura mayor

%% -------------------------------------
%% Ajuste de parámetros iniciales
%clc; clear all; close all;

%imagenNombreSilueta='siluetaN1.jpg';
%imagenNombreSilueta='siluetaN2.jpg';
%imagenNombreSilueta='siluetaN3.jpg';


%% Lectura de la imagen
IOrig=imread(imagenNombreSilueta);

%B=imresize(IOrig,[501 501]);
%IOrig=B;

%% Convertir a escala de grises
%IGray=rgb2gray(IOrig);

%% Umbralización y Binarización
umbral=graythresh(IOrig);
IB1=im2bw(IOrig,umbral);

%% Mostrar imagen original
%imshow(IOrig)

%% Etiquetado de áreas conectadas, se necesita una imagen binaria
[L Ne]=bwlabel(IB1); %en L los objetos y en Ne= números de áreas etiquetadas

%% Cálculo de propiedades de los objetos de la imagen
% se toman los datos geométricos necesarios para luego poder caracterizarlos.
propiedades= regionprops(L,'Area','Perimeter','MajorAxisLength','MinorAxisLength');


%% Mostrar características geométricas
% Se recorre de principio a fin las propiedades obtenidas
sumaArea=0;
redondez=0;
diametro=0;

ejeMayor=0;
ejeMenor=0;

%fprintf('       N#;      Area;  Perimetro; \n');
for n=1:size(propiedades,1)
    if(propiedades(n).Area > tamano)
        redondez=(4*propiedades(n).Area*pi)/(propiedades(n).Perimeter^2); %fórmula de redondez de objetos
%        fprintf('%s %10.2i; %10.2i; %10.2f; %10.4f; \n', imagenNombreSilueta, n,propiedades(n).Area, propiedades(n).Perimeter, redondez);
        sumaArea=sumaArea+propiedades(n).Area;
        ejeMayor=propiedades(n).MajorAxisLength;
        ejeMenor=propiedades(n).MinorAxisLength;
    end
end

diametro=sqrt((sumaArea*4)/pi);

%fprintf('Imagen; Suma de Areas; Redondez; diametro; eMayor; eMenor \n');
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f \n',imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor);


%% -------------------------------------
%imwrite(IB2,imagenNombreRe,'jpg')


end

