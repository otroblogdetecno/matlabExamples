%se efectúa el gradiente morfológico, el cual consiste en la dilatación y
%posterior resta del resultado, usando la erosión

imagenOriginal = imread('TP03/MUSCLE.BMP');
imshow(imagenOriginal);

SE = strel('disk', 3);

imagenDilatada = imdilate(imagenOriginal,SE);

%figure; imshow(imagenDilatada);

imagenErosionada = imerode(imagenOriginal,SE);

%figure; imshow(imagenErosionada);



imagenGradiente = imagenDilatada - imagenErosionada;

figure; imshow (imagenGradiente);

%binarizacion de la imagen
nivel = graythresh(imagenGradiente);
BW = im2bw(imagenGradiente,nivel);

%se obtienen elementos que no tocan el borde
BW2= imclearborder(BW);

resultadoFinal = bitxor(BW, BW2);

figure; imshow(resultadoFinal);
