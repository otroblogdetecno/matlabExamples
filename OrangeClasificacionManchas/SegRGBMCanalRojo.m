function [ output_args ] = SegRGBMCanalRojo( nombreImagenRecorte, nombreImagenManchas, umbralR, umbralG, tamanoMaximoManchas )
% segmenta una imagen. Asume el directorio completo donde guardar
% Produce una imagen con las manchas.
% Recorta el canal azul, dado que los canales mas influyentes para
% las manchas con el color rojo y verde.
% Produce una imagen intermedia de la naranja y las manchas, debe someterse
% a un proceso de extracciń final para obtener solamente las manchas.

%% sACAR CANAL AZUL
IColorOrig=imread(nombreImagenRecorte);
IColor=imsharpen(IColorOrig);
%% OBTENER SILUETA PREPROCESADA

imagenR=IColor(:,:,1);
imagenG=IColor(:,:,2);
%imagenB=IColor(:,:,3);

%figure('Name','RGB'); imshow(IColor);

%% binariza el canal rojo
IMR=imagenR<umbralR;
IManchasContornoRojo=IMR;


%% Binariza el canal verde
IMG=imagenG<umbralG;
IManchasContornoVerde=IMG;

%figure('Name','Binario R'); imshow(IMR)
%figure('Name','Binario G'); imshow(IMG)



%% tratamiento de canal rojo
% Etiquetar elementos conectados
[ListadoObjetosRojo Ne]=bwlabel(IMR);
%% Calcular propiedades de los objetos de la imagen
propiedadesRojo= regionprops(ListadoObjetosRojo);
% Buscar áreas menores a tamanoMaximoManchas
seleccionRojo=find([propiedadesRojo.Area]<tamanoMaximoManchas);
% Eliminar áreas menores a 500
for n=1:size(seleccionRojo,2)
    coordenadasAPintar=round(propiedadesRojo(seleccionRojo(n)).BoundingBox);
    % pintado de manchas en colr negro
    IManchasContornoRojo(coordenadasAPintar(2):coordenadasAPintar(2)+coordenadasAPintar(4),coordenadasAPintar(1):coordenadasAPintar(1)+coordenadasAPintar(3))=0;
end

%figure('Name','contorno R'); imshow(IManchasContornoRojo);

%manchas en color rojo
IManchasFinalRojo=bitxor(IMR,IManchasContornoRojo);
%figure('Name','final R');imshow(IManchasFinalRojo);

%% tratamiento de canal color verde
% Etiquetar elementos conectados
[ListadoObjetosVerde Ne]=bwlabel(IMG);
%% Calcular propiedades de los objetos de la imagen
propiedadesVerde= regionprops(ListadoObjetosVerde);
% Buscar áreas menores a tamanoMaximoManchas
seleccionVerde=find([propiedadesVerde.Area]<tamanoMaximoManchas);
% Eliminar áreas menores a 500
for n=1:size(seleccionVerde,2)
    coordenadasAPintarVerde=round(propiedadesVerde(seleccionVerde(n)).BoundingBox);
    % pintado de manchas en colr negro
    IManchasContornoVerde(coordenadasAPintarVerde(2):coordenadasAPintarVerde(2)+coordenadasAPintarVerde(4),coordenadasAPintarVerde(1):coordenadasAPintarVerde(1)+coordenadasAPintarVerde(3))=0;
end

%figure('Name','contorno G'); imshow(IManchasContornoVerde);

%manchas en color rojo
IManchasFinalVerde=bitxor(IMG,IManchasContornoVerde);
%figure('Name','final G');imshow(IManchasFinalVerde);



%% Suma de los complementos
% Debido a que en cada canal se encuentra una parte de la mancha, se suman
% ambos para formar una gran mancha.
sumaFinalesRG=bitor(IManchasFinalRojo,IManchasFinalVerde);
%figure('Name','suma de manchas'); imshow(sumaFinalesRG);

%% guardar imagen
imwrite(sumaFinalesRG,nombreImagenManchas,'jpg');


end

