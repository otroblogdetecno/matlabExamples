function [ output_args ] = removerFondo()
%function [ output_args ] = removerObjetos( imagenNombreColor, imagenNombreMascara, imagenNombreFondo)
% Remueve el fondo obteniendo solamente los pixeles según una máscara
% binaria

FONDO=0;
imagenNombreColor='recorte2.jpg';
imagenNombreMascara='removida2.jpg';
imagenNombreFondo='fondo2.jpg';


%Lectura de la imagen con fondo
IRecorte=imread(imagenNombreColor);
IMascaraC=imread(imagenNombreMascara);

IFondo=imread(imagenNombreColor);
IFondo(:,:,1:3)=0;

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, color]=size(IRecorte);

fprintf('%.2i %.2i \n',filasTope,columnasTope);   

%recorrer la imagen mascara
for f=1:1:200%filasTope
    for c=1:1:200%columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
        fprintf('%.2i %.2i \n',f,c);        
        pixelMascara=IMascara(f,c);

        if pixelMascara ~= FONDO
%%            disp('NO ES IGUAL');
            pixelCopiar=impixel(IRecorte, c, f);%es al reves que fila columnas
%            IFondo(f,c,1:3)=pixelCopiar;
            
            IFondo(f,c,1)=pixelCopiar(1);
            IFondo(f,c,2)=pixelCopiar(2);
            IFondo(f,c,3)=pixelCopiar(3);
%%%            pixelr=impixel(IFondo, 350, 350)
%%        else
%%            IFondo(f,c,1:3)=[0 0 0];
%%%            disp('Mensaje IGUAL A cero');
        end %if
    end %for columnas
end %for filas

figure;imshow(IRecorte);
%figure;imshow(IMascara);
figure;imshow(IFondo);

end %fin de la funcion

