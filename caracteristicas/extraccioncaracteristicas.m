% Octubre 2016
% http://otroblogdetecnologias.blogspot.com/
%
% -------------------------------------
% PRUEBAS DE SECUENCIAS PARA EXTRACCION DE CARACTERISTICAS
% -------------------------------------
% A partir de una imagen, se busca obtener características
% sin el fondo.

% Algoritmo general
%------------------

close all; clear all;

%Imagen original
nombreImagenOriginal='naranja-b-1.jpg';
Iorig=imread(nombreImagenOriginal);
figure;imshow(Iorig);


%Bordes con Prewitt
IG=rgb2gray(Iorig);
Iedges=edge(IG,'prewitt');
figure;imshow(Iedges)


%fill holes
BW4 = im2bw(Iedges);
BW5 = imfill(BW4,'holes');
imshow(BW4), figure, imshow(BW5)

IB5=1-BW4;
%IB5=BW4;
figure;imshow(IB5);


% Erosion
%--------------------
% Elemento estructurante CRUZ, el uno indica los valores hacia cada lado
SE = strel('diamond', 2); %elemento estructurante




i=0;
while i<16
%    IB6 = imerode(IB5,SE);
    IB6=imopen(IB5,SE);
    IB5=IB6;
    i=i+1;
end


figure;imshow(IB6);


%Binarizar
%-------------------
%nivel = graythresh(Iorig); %umbral de nivel de gris
%IB2=im2bw(Iorig,nivel);
%figure;imshow(IB2);



%--- aplicacion de filtro ---
%f=fspecial('average');
%IB3=filter2(f,IB2);



%


% Erosion
%--------------------
% Elemento estructurante CRUZ, el uno indica los valores hacia cada lado
%SE = strel('diamond', 2); %elemento estructurante
%IB3 = imdilate(IB2,SE);
%figure;imshow(IB3);

% Erosion utilizando elemento rombo
% --------------------
%SE = strel('disk', 3);
%IB4 = imdilate(IB2,SE);
%figure;imshow(IB4);

%Operacion XOR
%---------------------
%IB5=bitxor(IB3,IB4);
%figure; imshow(IB5);


%Operacion invertir imagen
%---------------------
%IB6=1-IB5;
%figure; imshow(IB6);

%----------------------------------------------
%%Si se utiliza octagon o diamon difiere un poco
%%SE=strel('octagon',21); 
%%SE=strel('diamond',21);
%%En la figura 5 se obtiene un resultado aproximado, utilizando disk, 15
%SE=strel('disk',15);
%----------------------------------------------
 
 
%IB7=imclose(IB5,SE);   
%figure; imshow(IB7);
% 
 
%IB8=bitor(IB2,IB7);
%figure; imshow(IB8);

 
%IB9=bitxor(IB8,IB2);
%figure; imshow(IB9);
 

%IB10=1-IB9;
%figure; imshow(IB10);

%IB11=bitxor(IB7,IB10);
%figure; imshow(IB11);

%IB12=1-IB11;
%figure; imshow(IB12);

%----------------------------
%Grafica en cuadros
%----------------------------
%figure;
%subplot(2,2,1);imshow(Iorig);
%subplot(2,2,2);imshow(IB12);
%subplot(2,2,3);imshow(Iorig);
%subplot(2,2,4);imshow(IB2);

%figure;
%subplot(2,2,1);imshow(IB3);
%subplot(2,2,2);imshow(IB4);
%subplot(2,2,3);imshow(IB5);
%subplot(2,2,4);imshow(IB6);

%figure;
%subplot(2,2,1);imshow(IB7);
%subplot(2,2,2);imshow(IB8);
%subplot(2,2,3);imshow(IB9);
%subplot(2,2,4);imshow(IB10);
%
%figure;
%subplot(2,2,1);imshow(IB11);
%subplot(2,2,2);imshow(IB12);

