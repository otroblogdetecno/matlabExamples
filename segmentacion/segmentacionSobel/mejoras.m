function [ output_args ] = mejoras(nClusteres, nombreImagenSegmentar, nombreImagenSalida,numeroRecorte)
% Asume las imagenes recortadas desde una fuente
%nClusteres = 5;

%% Inicio de segmentacion k-means
IOrig = imread(nombreImagenSegmentar);
%ISh = imsharpen(IOrig);
IOrig(:,:,3)=0;


I2 = imtophat(IOrig,strel('disk',15));
RGB2 = imadjust(IOrig,[.2 .3 0; .6 .7 1],[]);
RGB3 = imadjust(I2,[.2 .3 0; .6 .7 1],[]);


figure; imshow(IOrig);
figure; imshow(I2);
figure; imshow(RGB2);
figure; imshow(RGB3);
%figure; imshow(I3);


end

