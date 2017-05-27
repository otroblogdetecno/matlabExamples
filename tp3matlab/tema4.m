clear all;
close all;

original = imread('TP03/xadrez.bmp');
original = imadjust(original);
imshow(original), title('original')

range=(original >= 0 & original <= 100);
original(range)=0;
original(~range)=255;

original=255-original;
figure; imshow(original);


range=(original >= 0 & original <= 100);
original(range)=0;
original(~range)=255;

original=255-original;
figure; imshow(original);

% 
% K10 = imfilter(original,fspecial('sobel'),'replicate');
% 
% K = medfilt2(original);
% figure, imshow(K10);
% 
% se = strel('square',30);
% 
% 
% 
% for c=1:1
%     intermedia1 = imopen(original,se);
%     intermedia2 = imclose(original,se);
%     
%     for c2=1:30
%         se = strel('square',c2);
%         intermedia1 = imopen(intermedia1,se);
%     end
%     
%     for c2=1:30
%         se = strel('square',c2);
%         intermedia2 = imclose(intermedia2,se);
%     end
%     title('intermedia1');
%     figure, imshow(intermedia1);
%     figure, imshow(intermedia2);
%     
%     obr = imdilate(original, strel('square',3)) - imerode(original, strel('square',3));
% 
%     figure
%     imshow(obr,[])
% 
%     intermedia2 = intermedia1 + obr;
%     figure
%     imshow(intermedia2,[])
% 
% %     %intermedia3 = original - intermedia1; transformada top hat
% %     intermedia3 = original - intermedia1;
% %     %figure, imshow(intermedia3);
% % 
% %     %binarizacion de la imagen
% %     nivel = graythresh(intermedia3);
% %     BW = im2bw(intermedia3,nivel);
% %     grayImage = 255 * uint8(BW);
% %     figure, imshow(grayImage)
% % 
% %     obr = imreconstruct(grayImage,original);
% % 
% %     figure
% %     imshow(obr,[])
% %     
% 
% end
% 
% 
% 
