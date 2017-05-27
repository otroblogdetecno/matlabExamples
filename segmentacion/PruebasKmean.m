%% MainSegmentarRGB.m
% Asume las imagenes recortadas desde una fuente

%% Variables de configuracion

%% Ajuste de parámetros iniciales
clc; clear all; close all;


%nombreImagenP='061.jpg';
%nombreImagenP='143.jpg';
nombreImagenP='011.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/'); 
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearn/'); 
 
%% Salida manchas
 pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegLAB/'); 

 
 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathAplicacionAprender,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacionAprender,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacionAprender,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacionAprender,nombreImagenP,'_','r4.jpg');
 

% nombres de archivos con objetos removidos
nombreImagenRemovida1=strcat(pathAplicacionAprender,nombreImagenP,'_','rm1.jpg');
nombreImagenRemovida2=strcat(pathAplicacionAprender,nombreImagenP,'_','rm2.jpg');
nombreImagenRemovida3=strcat(pathAplicacionAprender,nombreImagenP,'_','rm3.jpg');
nombreImagenRemovida4=strcat(pathAplicacionAprender,nombreImagenP,'_','rm4.jpg');

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathAplicacionAprender,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacionAprender,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacionAprender,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacionAprender,nombreImagenP,'_','sN4.jpg');


%% Siluetas manchas
nombreImagenManchasN1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN1.jpg');
nombreImagenManchasN2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN2.jpg');
nombreImagenManchasN3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN3.jpg');
nombreImagenManchasN4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN4.jpg');


%% solo manchas
nombreImagenDefectosND1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND1.jpg');
nombreImagenDefectosND2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND2.jpg');
nombreImagenDefectosND3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND3.jpg');
nombreImagenDefectosND4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND4.jpg');



%% Nombres de archivos 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 

%% alg

%he = imread('hestain.png');
%he = imread(nombreImagenRecorte1);

nombreImagenSegmentar=nombreImagenRemovida1;
IOrig = imread(nombreImagenSegmentar);
ISh = imsharpen(IOrig);

%figure; imshow(IOrig), title('Imagen Original');
%text(size(ISh,2),size(ISh,1)+15,'Imagen sharpen', 'FontSize',7,'HorizontalAlignment','right');
%figure; imshow(ISh), title('H&E image');
%text(size(ISh,2),size(ISh,1)+15,'Image courtesy of Alan Partin, Johns Hopkins University', 'FontSize',7,'HorizontalAlignment','right');

% crea una transformacion de color RGB a L*a*b
cform = makecform('srgb2lab');
lab_ISh = applycform(ISh,cform); % aplica transformacoinacion de color independiente del dispositivo


ab = double(lab_ISh(:,:,2:3));
nfilas = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nfilas*ncols,2); %cambia la figura 

nColors = 5;
% repetir agrupamiento 3 veces para evitar un mínimo local
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', 'Replicates',3);

pixel_etiqueta = reshape(cluster_idx,nfilas,ncols);
%figure; imshow(pixel_etiqueta,[]), title('imagen etiquetada por grupo');


%% crear imagenes

segmented_images = cell(1,3);
rgb_label = repmat(pixel_etiqueta,[1 1 3]);

for k = 1:nColors
    color = ISh;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
    
    %% Almacenar en archivos las imagenes de clusteres
    extension=strcat('C',strcat(int2str(k),'.jpg'));
    nombreImagenCluster=strcat(pathAplicacionSalidaSeg,nombreImagenP,extension);   
    imwrite(segmented_images{k},nombreImagenCluster,'jpg');
end



%% mostrar imagenes
%figure; imshow(segmented_images{1}), title('objects in cluster 1');
%figure; imshow(segmented_images{2}), title('objects in cluster 2'); 
%figure; imshow(segmented_images{3}), title('objects in cluster 3'); 
%figure; imshow(segmented_images{4}), title('objects in cluster 4'); 

%for k = 1:nColors
    % figure; imshow(segmented_images{k}), title(strcat('objects in cluster ',int2str(k)));

%end
