im1=imread('silueta1.jpg');
im2=imread('manchas1.jpg');

%figure; imshow(im1);
%figure; imshow(im2);



%ig1=rgb2gray(im1);
%ig2=rgb2gray(im2);

umbral=graythresh(im1);
ib1=im2bw(im1,umbral);

umbral=graythresh(im2);
ib2=im2bw(im2,umbral);


ib3=and(ib1,ib2);

figure; imshow(ib1);
figure; imshow(ib2);
figure; imshow(ib3);