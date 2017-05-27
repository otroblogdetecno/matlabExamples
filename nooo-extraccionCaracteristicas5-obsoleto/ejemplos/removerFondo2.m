function [ output_args ] = removerFondo()
%function [ output_args ] = removerFondo2( imagenNombreColor, imagenNombreMascara, imagenNombreFondo)
% Remueve el fondo obteniendo solamente los pixeles según una máscara
% binaria

FONDO=0;
imagenNombreColor='recorte1.jpg';
imagenNombreMascara='removida1.jpg';
imagenNombreFondo='fondo1.jpg';


%Lectura de la imagen con fondo
IRecorte=imread(imagenNombreColor);
IMascaraC=imread(imagenNombreMascara);

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, color]=size(IRecorte);

%fprintf('%.2i %.2i \n',filasTope,columnasTope);   

%recorrer la imagen mascara
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
        fprintf('%.2i %.2i \n',f,c);        
        pixelMascara=IMascara(f,c);

        if pixelMascara == FONDO
            IRecorte(f,c,1:3)=[0 0 0];
        end %if
        
    end %for columnas
end %for filas

%figure;imshow(IRecorte);

imwrite(IRecorte,imagenNombreFondo,'jpg')

end %fin de la funcion

