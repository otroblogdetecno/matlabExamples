clear all;
close all;

imagenOriginal = imread('TP03/tronco5.bmp');
figure; imshow(imagenOriginal);

    nivel = graythresh(imagenOriginal);
    BW = im2bw(imagenOriginal,nivel);
    BW = 1 - BW;
    grayImage = 255 * uint8(BW);
    figure, imshow(grayImage)

BW2 = imclearborder(BW);
figure, imshow(BW2)
title('se eliminan los objetos que tocan el borde')

BW3 = bwareaopen(BW2, 650);

%este es el ultimo objeto que queda en la imagen
figure, imshow(BW3)

BW4 = bwareaopen(BW2, 550);

figure, imshow(BW4)

imagenFinal = xor(BW3,BW4);

figure, imshow(imagenFinal)

