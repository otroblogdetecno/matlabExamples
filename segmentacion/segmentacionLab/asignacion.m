clc; close all; clear all;

imagenNombreColor='/home/usuario/ml/imgcolores/006.jpg_rem1.jpg';
imagenNombreMascara='/home/usuario/ml/imgcolores/006.jpg_sN1.jpg';
pathPrincipal='/home/usuario/ml/';
pathResultados=strcat(pathPrincipal,'output/');


%Lectura de la imagen con fondo
IRecorteRGB=imread(imagenNombreColor);
IRecorteLAB=rgb2lab(IRecorteRGB); % conversion a L*a*b
[filasTope, columnasTope, algo]=size(IRecorteRGB);
