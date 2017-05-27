clc; close all; clear all;

PRIMER_PLANO=1;
imagenNombreColor='rverde_sin_luz.jpg';
imagenNombreMascara='sverde_sin_luz.jpg';


%Lectura de la imagen con fondo
IRecorte=imread(imagenNombreColor);
IMascaraC=imread(imagenNombreMascara);

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, color]=size(IRecorte);

sumaRojo=double(0.0);
sumaVerde=double(0.0);
sumaAzul=double(0.0);
contadorPixeles=double(0.0);

%fprintf('contador= %f ; sumaR= %f sumaG= %f sumaB= %f\n', contadorPixeles, sumaRojo, sumaVerde, sumaAzul);

%recorrer la imagen mascara
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
%        fprintf('%.2i %.2i \n',f,c);        
        pixelMascara=IMascara(f,c);

        if pixelMascara == PRIMER_PLANO

            sumaRojo=double(IRecorte(f,c,1))+sumaRojo;
            sumaVerde=double(IRecorte(f,c,2))+sumaVerde;
            sumaAzul=double(IRecorte(f,c,3))+sumaAzul; 
            contadorPixeles=contadorPixeles+1;
%           fprintf('pp, R= %f G= %f B= %f contador= %f ; sumaR= %f sumaG= %f sumaB= %f\n', double(IRecorte(f,c,1)), double(IRecorte(f,c,2)), double(IRecorte(f,c,3)), contadorPixeles, sumaRojo, sumaVerde, sumaAzul);            
        end %if        
    end %for columnas
end %for filas

fprintf('R= %i G= %i B= %2i Contador=%i \n',sumaRojo, sumaVerde, sumaAzul,contadorPixeles);        

colorRojo=uint8(sumaRojo/contadorPixeles);
colorVerde=uint8(sumaVerde/contadorPixeles);
colorAzul=uint8(sumaAzul/contadorPixeles);

fprintf('R= %i G= %i B= %2i \n',colorRojo, colorVerde, colorAzul);        
