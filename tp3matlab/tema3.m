%lectura de la imagen

imagenOriginal = imread('TP03/ratlung.bmp');
imshow(imagenOriginal);

%binarizacion

%binarizacion de la imagen
nivel = graythresh(imagenOriginal);
BW = im2bw(imagenOriginal,nivel);

%invertir la imagen
BWInvertido = 1 - BW;

figure; imshow(BWInvertido);

%rellenar agujeros, como paso previo al xor
I2  = imfill(BWInvertido,8,'holes');


pulmonXOR = xor(BWInvertido,I2);




CC= bwconncomp(pulmonXOR)

figure; imshow(pulmonXOR);








