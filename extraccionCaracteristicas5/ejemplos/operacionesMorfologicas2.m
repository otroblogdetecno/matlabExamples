function [ output_args ] = OperacionesMorfologicas2()
%function [ output_args ] = OperacionesMorfologicas2( imagenNombreOp, imagenNombreSilueta)
% Trabaja aplicando las operaciones morfologicas sobre cada imagen
% recortada


imagenNombreOp='recorte1.jpg';
imagenNombreSilueta='silueta1.jpg';
close all;

%Lectura de la imagen original
IMor=imread(imagenNombreOp);

I=imsharpen(IMor); %Realza contraste
IMor=I; %Guarda la imagen con contraste realzado



%Separacion de canales RGB, segun Forbes
% Se obtiene las manchas
otra = IMor(:, :, 1)+IMor(:, :, 2)-(2*IMor(:, :, 3));


IMor(:, :, 3)=0; %Se coloca en cero el canal azul porque no aporta al naranja

canalRojo = IMor(:, :, 1);

%figure('Name','Orig'); imshow(IMor);
%figure('Name','Otra'); imshow(otra);

% Canal Rojo aporta mayor contraste
umbral=graythresh(IMor);
IB1=im2bw(canalRojo,umbral);
%figure('Name','IMor Binaria'); imshow(IB1);

%%Inversa de la imagen
inversa=1-IB1;
%figure('Name','Inversa'); imshow(inversa);


%%Se binarizan las manchas
%umbral=graythresh(otra);
%IB2=im2bw(otra,umbral);
%figure; imshow(IB2);



% Aplicacion de operacion erosion
SE = strel('disk', 5);
IB2 = imerode(inversa,SE);
%figure('Name','Erosion');imshow(IB2);

%Se vuelve a invertir para dejar con unos la silueta
inversa=1-IB2;
%figure; imshow(inversa);


%%gardar la previa de la silueta
imwrite(inversa,imagenNombreSilueta,'jpg')


end

