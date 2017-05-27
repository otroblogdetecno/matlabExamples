function [ ] = extraerColorLAB( fileHandlerRGB, fileHandlerLAB, formatSpecLAB)
% Asume una imagen con el fondo separado.
% Crea un archivo .csv para el proceso temporal de k-means
% -----------------------------------------------------------------------
%clc; clear all; close all;

%El algoritmo se basa en el uso de una imagen con silueta, la misma permite separar
%específicamnte los colores.
%% configuración de valores constantes, fondo y primer plano
PRIMER_PLANO=1;
FONDO=0;

%imagenNombreColor='/home/usuario/ml/imgcolores/010.jpg_rm1.jpg'; %manchada
%imagenNombreColor='/home/usuario/ml/imgcolores/006.jpg_rem1.jpg';
%imagenNombreMascara='/home/usuario/ml/imgcolores/006.jpg_sN1.jpg';

%pathPrincipal='/home/usuario/ml/';
%pathResultados=strcat(pathPrincipal,'output/');

%% Parametros de entrada en fomato .csv
%nombreArchivoLAB='archivoLAB.csv';
%formatSpecLAB='%f%f%f%i%i'; %formato del archivo a leer
%fileHandlerLAB=strcat(pathResultados,nombreArchivoLAB); 

%Lectura de la imagen con fondo
IRecorteRGB=imread(fileHandlerRGB);
IRecorteLAB=rgb2lab(IRecorteRGB); % conversion a L*a*b

%figure;imshow(IRecorteRGB);
%figure;imshow(IRecorteLAB(:,:,1));
%figure;imshow(IRecorteLAB(:,:,2));
%figure;imshow(IRecorteLAB(:,:,3));

%IMascaraC=imread(imagenNombreMascara);

% Binarizar
%umbral=graythresh(IMascaraC);
%IMascara=im2bw(IMascaraC,umbral);

[filasTope, columnasTope, algo]=size(IRecorteRGB);

pixelL=double(0.0);
pixela=double(0.0);
pixelb=double(0.0);
x=0; y=0;

%fprintf('contador= %f ; sumaR= %f sumaG= %f sumaB= %f\n', contadorPixeles, sumaH, sumaS, sumaV);
%recorrer la imagen mascara

%limpiar el archivo antes de comenzar a guardar los nuevos pixeles
guardarCIELAB(fileHandlerLAB,' ',0);

for f=1:filasTope
    for c=1:columnasTope
%%        % Leer de la imagen mascara si el valor es diferente a cero
%       pixelMascara=IMascara(f,c);
%        if (pixelMascara ~= FONDO)
        if(((IRecorteRGB(f,c,1)==0) && (IRecorteRGB(f,c,2)==0) && (IRecorteRGB(f,c,3)==0))==0)
       %fprintf('coordenadas %i %i \n',f,c);        
            pixelL=double(IRecorteLAB(f,c,1));
            pixela=double(IRecorteLAB(f,c,2));
            pixelb=double(IRecorteLAB(f,c,3)); 
            x=f; %fila del pixel
            y=c; %columna del pixel
           cluster=0; 
           filaLAB=sprintf('%f,%f,%f,%i,%i,%i \n',pixelL, pixela, pixelb,x,y,cluster);            
           guardarCIELAB(fileHandlerLAB,filaLAB,1)
           fprintf('%f,%f,%f,%i,%i,%i \n',pixelL, pixela, pixelb,x,y,cluster);            
        end %if        
    end %for columnas
end %for filas

end