 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 
 %pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/');
 
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearnSF/'); 
 %pathAplicacionAprender=strcat(pathPrincipal,'noreconocidos/MANCHADOSexp/segFondo/');
pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearnLABSF/'); 
 
pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegRGB/'); 

%nombreImagenM=strcat(pathAplicacionSalidaSeg,'057.jpg_MN1.jpg');
nombreImagenM=strcat(pathAplicacionSalidaSeg,'057.jpg_MN2.jpg');

tamanoMaximoManchas=500; %pixeles

%% Lectura de la imagen

img=imread(nombreImagenM);

%% Binarización

umb=graythresh(img);

bw1=im2bw(img,umb);

bw2=im2bw(img,umb);
%% Mostrar imagen

imshow(img)

%% Etiquetar elementos conectados

[L Ne]=bwlabel(bw2);

%% Calcular propiedades de los objetos de la imagen

propied= regionprops(L);

hold on

%% Graficar las 'cajas' de frontera de los objetos

for n=1:size(propied,1)

    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)

end

pause (3)

%% Buscar áreas menores a tamanoMaximoManchas

s=find([propied.Area]<tamanoMaximoManchas);

%% Marcar áreas menores a tamanoMaximoManchas

for n=1:size(s,2)

    rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2)

end

pause (2)

%% Eliminar áreas menores a 500

for n=1:size(s,2)

    d=round(propied(s(n)).BoundingBox);

    bw2(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;

end

figure;imshow(bw1)
figure;imshow(bw2)

bw3=bitxor(bw1,bw2);
figure;imshow(bw3);