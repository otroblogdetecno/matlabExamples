%% Propiedades de regiones de una imagen

% Ejemplo de uso de la función REGIONPROPS

%% Lectura de la imagen

img=imread('utiles1.jpg');

%% Convertir a escala de grises

im_g=rgb2gray(img);



%% Binarización


umb=graythresh(im_g);

bw=im2bw(im_g,umb);

%% Mostrar imagen

imshow(img)

%% Etiquetar elementos conectados

[L Ne]=bwlabel(bw);

%% Calcular propiedades de los objetos de la imagen

propied= regionprops(L);

hold on

%% Graficar las 'cajas' de frontera de los objetos

for n=1:size(propied,1)

    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)

end

pause (3)

%% Buscar áreas menores a 500

s=find([propied.Area]<500);

%% Marcar áreas menores a 500

for n=1:size(s,2)

    rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2)

end

pause (2)

%% Eliminar áreas menores a 500

for n=1:size(s,2)

    d=round(propied(s(n)).BoundingBox);

    bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;

end

figure

imshow(bw)