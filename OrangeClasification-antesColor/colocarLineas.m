function [ output_args ] = colocarLineas( imagenInicial )
%% Ajuste de parámetros iniciales
clc; clear all; close all;

%% Datos de configuración
imagenInicial='ultima5.jpg';

%% Lectura de la imagen
IOrig=imread(imagenInicial);

%% Rotacion de la imagen
%IOrigTemp = imrotate(IOrig,180); %rotar la imagen
%IOrig=IOrigTemp;

%% ----- INICIO Definicion de topes
% Para definicion de rectangulos
% Se calcula el tamaño de la imagen para luego aplicar las lineas de
% cortes.
% obtener el tamaño

inicioFilas=0;
inicioColumnas=0;
[filasTope, columnasTope, color]=size(IOrig);

% variables para separacion entre cuadros
primeraFila=200; %700;%20;%300; %570; %Establece el desplazamiento para la primera fila
desplazamientoIzquierda=0; %mover el cuadro 2 
desplazamientoDerecha=0; %50; %mover el cuadro 4
espacioFila=250;%500;%300;
espacioFila2=350;%500;
espacioColumna=250;%300;


%Definicion de linea columna central
lineaGuiaCentralColumna=columnasTope/2;
lineaGuiaCentralColumna1=lineaGuiaCentralColumna-(espacioColumna+desplazamientoIzquierda);
lineaGuiaCentralColumna2=lineaGuiaCentralColumna+(espacioColumna+desplazamientoDerecha);

% definicion del primer cuadro
lineaGuiaFila1= primeraFila; %520;% 380;
lineaGuiaFila2=lineaGuiaFila1+espacioFila;
lineaGuiaFila3=lineaGuiaFila2+espacioFila2;

%definicion de columnas
lineaGuiaColumna1=(espacioColumna+desplazamientoIzquierda);
lineaGuiaColumna2=columnasTope-(espacioColumna+desplazamientoDerecha);

% ----- FIN Definicion de topes

fprintf('--- Calibración --- \n');
fprintf('Filas = %.2i \n', filasTope);
fprintf('Columnas = %.2i \n', columnasTope);


% Definicion de la imagen en un cuadro
figure; imshow(IOrig);
hold on;

%lineas horizontales filas
% X,Y cuadro 3 y cuadro 4
line([inicioColumnas columnasTope ],[lineaGuiaFila1 lineaGuiaFila1],'LineWidth',2, 'Color', 'red');
line([inicioColumnas columnasTope],[lineaGuiaFila2 lineaGuiaFila2],'LineWidth',2, 'Color', 'red');
line([inicioColumnas columnasTope],[lineaGuiaFila3 lineaGuiaFila3],'LineWidth',2, 'Color', 'red');



%lineas verticales columnas, cuadro 2 y cuadro 4
line([lineaGuiaColumna1 lineaGuiaColumna1],[inicioFilas filasTope],'LineWidth',2, 'Color', 'green');
line([lineaGuiaColumna2 lineaGuiaColumna2],[inicioFilas filasTope],'LineWidth',2, 'Color', 'green');


%Dibujar lineas centrales, cuadro1
line([lineaGuiaCentralColumna lineaGuiaCentralColumna],[inicioFilas filasTope],'LineWidth',1, 'Color', 'white');
line([lineaGuiaCentralColumna1 lineaGuiaCentralColumna1],[inicioFilas filasTope],'LineWidth',1, 'Color', 'blue');
line([lineaGuiaCentralColumna2 lineaGuiaCentralColumna2],[inicioFilas filasTope],'LineWidth',1, 'Color', 'blue');



%% ----- fin cuerpo de la funcion -----

end %%fin funcion
