function [ output_args ] = obtenerManchas(nombreIRemovida, nombreIintermedia, nombreIManchas, nombreICManchas, umbralr)
% Trabaja aplicando las operaciones morfologicas sobre cada imagen
% recortada, utiliza como entrada las imagenes siluetas para emitir un
% resultado con manchas y sin manchas

%clc; clear all; close all;

% Nombre archivos
%nombreIRemovida='removida2.jpg';
%nombreIintermedia='intermedia2.jpg';
%nombreIManchas='manchas2.jpg';
%nombreICManchas='cmanchas2.jpg';
%umbralr=0.90;

%Lectura de la imagen original
IMor=imread(nombreIRemovida);

%Separacion de canales RGB, se elige el canal rojo porque es el que mas
%aporta a las manchas
canalRojo = IMor(:, :, 2);
%canalVerde = IMor(:, :, 2);
%canalAzul = IMor(:, :, 3);

figure('Name','Rojo'); imshow(canalRojo);
%figure('Name','Verde'); imshow(canalVerde);
%figure('Name','Azul'); imshow(canalAzul);

% Canal Rojo aporta mayor contraste
% Se binariza la imagen con un umbral manual
IB1=im2bw(canalRojo,umbralr);
%figure; imshow(IB1);

%Se genera una imagen intermedia, la cual se utiliza como complemento
imwrite(IB1,nombreIintermedia,'jpg')



%%Se aplica el complemento para que las manchas tengan valor 1 en binario
IB2=1-IB1;
%figure; imshow(IB2);
imwrite(IB2,nombreICManchas,'jpg')

% Se guarda un archivo intermedio de las manchas
ICManchas=imread(nombreICManchas);

%Se levantan los datos desde una imagen en disco, se binariza las manchas
umbralr=graythresh(ICManchas);
IB2=im2bw(ICManchas,umbralr);


% Se procesan los valores de los canales para obtener la parte sana
% Solo la naranja en colores para obtener parte sana
i(:, :, 1)=immultiply(IMor(:, :, 1),IB1);
i(:, :, 2)=immultiply(IMor(:, :, 2),IB1);
i(:, :, 3)=immultiply(IMor(:, :, 3),IB1);
figure('Name','Partes Sanas'); imshow(i);



% Solo las manchas en colores, se procesan los valores de las manchas
manchas(:, :, 1)=immultiply(IMor(:, :, 1),IB2);
manchas(:, :, 2)=immultiply(IMor(:, :, 2),IB2);
manchas(:, :, 3)=immultiply(IMor(:, :, 3),IB2);
figure('Name','Partes manchadas'); imshow(manchas);




end

