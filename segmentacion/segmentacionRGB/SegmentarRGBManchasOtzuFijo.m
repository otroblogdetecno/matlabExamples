function [ output_args ] = SegmentarRGBManchas3( nombreImagenRecorte1 )
% segmenta una imagen. Asume el directorio completo donde guardar
% Produce una imagen con las manchas.
% Asume el canal azul recortado, dado que los canales mas influyentes para
% las manchas con el color rojo y verde.

%% sACAR CANAL AZUL
IColor=imread(nombreImagenRecorte1);
%IColorSinB=imread(nombreImagenRecorte1);
%IColorSinB(:,:,3)=0;

%% OBTENER SILUETA PREPROCESADA
%ISilueta1=imread(nombreImagenSiluetaN1);

%umbralBinario=graythresh(ISilueta1);
%ISiluetaB1=im2bw(ISilueta1,umbralBinario);


%imagenR=IColor(:,:,1);
%imagenG=IColor(:,:,2);
%imagenB=IColor(:,:,3);

%figure('Name','RGB'); imshow(IColor);
%figure('Name','RG0 sin Azul'); imshow(IColorSinB);
%figure('Name','Canal R'); imshow(imagenR)
%figure('Name','Canal G'); imshow(imagenG)

%figure('Name','Silueta'); imshow(ISiluetaB1);
%%%

umbralGeneral=graythresh(IColor)
IMGeneral=im2bw(IColor,umbralGeneral);

figure; imshow(IColor);
figure; imshow(IMGeneral);

%umbralR = 0.90
%umbralR=graythresh(imagenR)
%IMR=im2bw(imagenR,umbralR);

%umbralG=0.75
%umbralG=graythresh(imagenG)
%IMG=im2bw(imagenG,umbralG);


%complementoR=1-IMR;
%complementoG=1-IMG;

%figure('Name','Binario R'); imshow(IMR)
%figure('Name','Binario G'); imshow(IMG)
%figure('Name','Complemento R'); imshow(complementoR)
%figure('Name','Complemento G'); imshow(complementoG)

%sumaComplementoRG=bitor(complementoR,complementoG);
%figure('Name','complementoR or complementoG'); imshow(sumaComplementoRG);

%% guardar imagen
%imwrite(sumaComplementoRG,nombreImagenManchasN1,'jpg')




end

