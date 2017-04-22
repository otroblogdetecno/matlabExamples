%function [ output_args ] = extraerColorPromedioLAB()
function [ valorL, valorA, valorB, varianzaH ] = extraerColorPromedioLAB( imagenNombreColor, imagenNombreMascara)


% Extraer color promedio de una imagen, utilizando una silueta para
% cuantificar el color y los valores que se extraen. 
% El resultado se trabaja en el espacio de color HSV.


% -----------------------------------------------------------------------
%clc; clear all; close all;
PRIMER_PLANO=1;
%imagenNombreColor='/home/usuario/ml/tmpToLearn/001.jpg_rm1.jpg';
%imagenNombreMascara='/home/usuario/ml/tmpToLearn/001.jpg_sN1.jpg';


%Lectura de la imagen con fondo
IRecorteRGB=imread(imagenNombreColor);
IRecorteLAB=rgb2lab(IRecorteRGB); % LAB

IMascaraC=imread(imagenNombreMascara);

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, ~]=size(IRecorteRGB);

sumaL=double(0.0);
sumaA=double(0.0);
sumaB=double(0.0);
contadorPixeles=double(0.0);

%variables para el calculo de varianza
sumaBarianzaH=double(0.0);
varianzaH=double(0.0);


%fprintf('contador= %f ; sumaL= %f sumaA= %f sumaB= %f\n', contadorPixeles, sumaL, sumaA, sumaB);

%recorrer la imagen mascara
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
%        fprintf('%.2i %.2i \n',f,c);        
        pixelMascara=IMascara(f,c);

        if pixelMascara == PRIMER_PLANO

            sumaL=double(IRecorteLAB(f,c,1))+sumaL;
            sumaA=double(IRecorteLAB(f,c,2))+sumaA;
            sumaB=double(IRecorteLAB(f,c,3))+sumaB; 

            contadorPixeles=contadorPixeles+1;
%           fprintf('pp, L= %f *a= %f *b= %f contador= %f ; sumaL= %f sumaA= %f sumaB= %f \n', double(IRecorteLAB(f,c,1)), double(IRecorteLAB(f,c,2)), double(IRecorteLAB(f,c,3)), contadorPixeles, sumaL, sumaA, sumaB);
        end %if        
    end %for columnas
end %for filas

% --------------------------------------
%valores de los promedios porcanales
%---------------------------------------
valorL=double(sumaL/contadorPixeles); %promedio canal H
valorA=double(sumaA/contadorPixeles); %promedio canal S
valorB=double(sumaB/contadorPixeles); %promedio canal V

%fprintf('contador= %f ; sumaL= %f sumaA= %f sumaB= %f\n', contadorPixeles, sumaL, sumaA, sumaB);

%% resultados finales
%fprintf('finalL= %f finalA= %f finalB= %f contadorPixeles=%i varianzaH=%f \n', valorL, valorA, valorB, contadorPixeles, varianzaH);

varianzaH=0;

end %fin de la funcion


