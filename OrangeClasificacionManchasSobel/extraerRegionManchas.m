function [ output_args ] = extraerRegionManchas( nombreImagenManchas, nombreImagenDefectos, tamanoMaximoManchas )
% REcibe imagenes segmentadas, las cuenta y genera una imagen de solo
% manchas.
% Produce una imagen final con las manchas y sin contorno.


%% Lectura de la imagen

IManchas=imread(nombreImagenManchas);

%% Binarización

umbral=graythresh(IManchas);

IManchasB1=im2bw(IManchas,umbral); %Imagen tratada

IManchasContorno=im2bw(IManchas,umbral); %Se utiliza para obtener el complemento, se borran las particulas
%% Mostrar imagen

%figure; imshow(IManchas)

%% Etiquetar elementos conectados

[ListadoObjetos Ne]=bwlabel(IManchasContorno);

%% Calcular propiedades de los objetos de la imagen

propiedades= regionprops(ListadoObjetos);


%% Buscar áreas menores a tamanoMaximoManchas

seleccion=find([propiedades.Area]<tamanoMaximoManchas);

%% Eliminar áreas 

for n=1:size(seleccion,2)

    coordenadasAPintar=round(propiedades(seleccion(n)).BoundingBox);
    % pintado de manchas en colr negro
    IManchasContorno(coordenadasAPintar(2):coordenadasAPintar(2)+coordenadasAPintar(4),coordenadasAPintar(1):coordenadasAPintar(1)+coordenadasAPintar(3))=0;

end

%figure('Name','Manchas y contorno');imshow(IManchasB1)
%figure('Name','Contorno');imshow(IManchasContorno)

IManchasFinal=bitxor(IManchasB1,IManchasContorno);
%figure('Name','Manchas final');imshow(IManchasFinal);
imwrite(IManchasFinal,nombreImagenDefectos,'jpg')
end

