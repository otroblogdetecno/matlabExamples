clear all;
close all;

imagenOriginal = imread('TP03/bureau.bmp');



range=(imagenOriginal > 45 & imagenOriginal <= 50);
imagenOriginal(range)=0;
imagenOriginal(~range)=255;



imagenOriginal=255-imagenOriginal;
figure; imshow(imagenOriginal);
BW3 = bwareaopen(imagenOriginal, 150);

figure; imshow(BW3);
BW3 = 255 * uint8(BW3);

imagenOriginal = imread('TP03/bureau.bmp');
figure; imshow(imagenOriginal);
for i=1:15
    BW3 = 255 * uint8(BW3);
    BW3=imdilate(BW3,strel('line',150,1));
    BW3=min(BW3,imagenOriginal);
end
figure; imshow(BW3);
imagenFinal = imdilate(BW3,strel('line',3,3)) - imerode(BW3,strel('line',3,3));
figure; imshow(imagenFinal);

% H=padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2); % create unsharp mask
% sharpened = imfilter(imagenOriginal,H);  % create a sharpened version of the image using that mask
% sharpened = imadjust(sharpened);
% figure; imshow(sharpened); %showing input & output images
% SE=strel('line', 3, 3);
% 
% intermedio1 = imdilate(sharpened,SE) - imerode(sharpened,SE);
% figure; imshow(intermedio1);
% 
% SE=strel('line', 3, 3);
% 
% intermedio2 = imdilate(sharpened,SE) - imerode(sharpened,SE);
% figure; imshow(intermedio2);
% 
% intermedio3 = imreconstruct(intermedio2,imagenOriginal);
% figure
% imshow(intermedio3,[])
% 
% intermedio4 = imerode(intermedio2,SE);
% 
% figure
% imshow(intermedio4,[])
% 
% 
