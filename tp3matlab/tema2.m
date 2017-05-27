%se realiza un gradiente 

imagenOriginal = imread('TP03/duaspaginas.bmp');
figure; imshow(imagenOriginal);

se = strel('disk',2);
marker = imerode(imagenOriginal,se);
figure; imshow(marker);

imagenDiferencia = imagenOriginal - marker;

figure; imshow(imagenDiferencia);



%binarizacion de la imagen
nivel = graythresh(imagenDiferencia);
BW = im2bw(imagenDiferencia,nivel);

figure; imshow(BW);
