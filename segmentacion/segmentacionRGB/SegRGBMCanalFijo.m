function [ output_args ] = SegRGBMCanalFijo( nombreImagenRecorte, nombreImagenManchas, umbralR, umbralG )
% segmenta una imagen. Asume el directorio completo donde guardar
% Produce una imagen con las manchas.
% Recorta el canal azul, dado que los canales mas influyentes para
% las manchas con el color rojo y verde.
% Produce una imagen intermedia de la naranja y las manchas, debe someterse
% a un proceso de extracciń final para obtener solamente las manchas.

%% sACAR CANAL AZUL
IColor=imread(nombreImagenRecorte);
IColorSinB=imread(nombreImagenRecorte);
IColorSinB(:,:,3)=0;

%% OBTENER SILUETA PREPROCESADA

imagenR=IColor(:,:,1);
imagenG=IColor(:,:,2);
imagenB=IColor(:,:,3);

%figure('Name','RGB'); imshow(IColor);
%figure('Name','RG0 sin Azul'); imshow(IColorSinB);
%figure('Name','Canal R'); imshow(imagenR)
%figure('Name','Canal G'); imshow(imagenG)

%figure('Name','Silueta'); imshow(ISiluetaB1);
%%

%umbralR=graythresh(imagenR)

%umbralR = 0.90;
IMR=im2bw(imagenR,umbralR);

%umbralG=0.75;
IMG=im2bw(imagenG,umbralG);

%%Extraccion del complemento
% Esta operacion se llev a cabo debido a que las manchas quedan como
% agujeros y la intencion es resaltarlos para que puedan ser
% contabilizados, dado que de otra manera no se encuentran las
% caracteristicas de las manchas.

complementoR=1-IMR;
complementoG=1-IMG;

%figure('Name','Binario R'); imshow(IMR)
%figure('Name','Binario G'); imshow(IMG)
%figure('Name','Complemento R'); imshow(complementoR)
%figure('Name','Complemento G'); imshow(complementoG)

%% Suma de los complementos
% Debido a que en cada canal se encuentra una parte de la mancha, se suman
% ambos para formar una gran mancha.
sumaComplementoRG=bitor(complementoR,complementoG);
%figure('Name','complementoR or complementoG'); imshow(sumaComplementoRG);

%% guardar imagen
imwrite(sumaComplementoRG,nombreImagenManchas,'jpg')




end

