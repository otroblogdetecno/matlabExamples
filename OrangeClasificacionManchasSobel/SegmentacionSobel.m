function [ output_args ] = SegmentacionSobel(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel, Prewit
IOrig=imread(nombreImagenSegmentar);
%IS=imsharpen(IOrig);

%IOrig=IS; %realzada


IGris=rgb2gray(IOrig);
ITopHat = imtophat(IGris, strel('disk', 10));

BW3 = edge(IGris,'Sobel');
%BW6 = edge(ITopHat,'Sobel');


% Aplicacion de operacion 
SE = strel('disk', 1);
BW4 = imdilate(BW3,SE);

%figure; imshow(BW3); 
%figure; imshow(BW4);    
%% Almacenar en archivos las imagenes de clusteres
imwrite(BW4,nombreImagenSalida,'jpg');


end

