function [ output_args ] = recortarImagen(imagenNombreRecortar, bRotar, imagenNombreSalida, xmin, ymin, width, height)
% Recortar Imágenes segun un rectangulo
% Recordar que las coordenadas en la imagen se toman a partir de la esquina
% superior izquierda

%% Datos de configuración
%imagenNombreRecortar='ultima3.jpg';

%% Lectura de la imagen
IRecorte=imread(imagenNombreRecortar);
%% Rotacion de la imagen
if(bRotar==1)
    IRecorteTemp = imrotate(IRecorte,180); %rotar la imagen
    IRecorte=IRecorteTemp;
end %fin rotar



%xmin=0;
%ymin=600
%width=500;
%height=600;

rect=[xmin ymin width height]; %definicion de la zona rectangular de recorte
I2 = imcrop(IRecorte,rect);



%figure; imshow(I2);

%escritura del resultado
imwrite(I2,imagenNombreSalida,'jpg')

end

