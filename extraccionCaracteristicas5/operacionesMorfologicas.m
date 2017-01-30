function [ output_args ] = OperacionesMorfologicas( imagenNombreOp, imagenNombreSilueta)
% Trabaja aplicando las operaciones morfologicas sobre cada imagen
% recortada


%close all;

%Lectura de la imagen original
IMor=imread(imagenNombreOp);
I=imsharpen(IMor);
IMor=I;


%Separacion de canales RGB
canalRojo = IMor(:, :, 1);
canalVerde = IMor(:, :, 2);
canalAzul = IMor(:, :, 3);

%figure('Name','Rojo'); imshow(canalRojo);
%figure('Name','Verde'); imshow(canalVerde);
%figure('Name','Azul'); imshow(canalAzul);


% Canal Rojo aporta mayor contraste
umbral=graythresh(canalRojo);
IB1=im2bw(canalRojo,umbral);
%figure; imshow(IB1);

%Inversa de la imagen
inversa=1-IB1;
%figure; imshow(inversa);


% Aplicacion de operacion erosion
SE = strel('disk', 5);
IB2 = imerode(inversa,SE);
%figure;imshow(IB2);

%Se vuelve a invertir para dejar con unos la silueta
inversa=1-IB2;
%figure; imshow(inversa);


%%gardar la previa de la silueta
imwrite(inversa,imagenNombreSilueta,'jpg')


end

