function [ totalPixeles , totalObjetos] = extraerPixelesManchas(nombreImagenDefectos)
% Recibe una imagen y devuelve el total de pixeles. Asume que la imagen es
% binaria y que fue sometida a un tramiento previo para la extracción de
% fondo, segmentado de la forma.
% La función es el paso final para caracterizar la fruta.


%% Lectura de la imagen

IDefectos=imread(nombreImagenDefectos);

%% Binarización

umbral=graythresh(IDefectos);

IDefectosB1=im2bw(IDefectos,umbral); %Imagen tratada

sumaPixeles=0;
totalObjetos=0; %%determina la cantidad de objetos manchas
%% Etiquetar elementos conectados

[ListadoObjetos totalObjetos]=bwlabel(IDefectosB1);

%% Calcular propiedades de los objetos de la imagen

propiedades= regionprops(ListadoObjetos);

%% Eliminar áreas menores a 500

for n=1:totalObjetos
%    fprintf('Mancha %i -> %i \n', n,propiedades(n).Area);
    sumaPixeles=sumaPixeles+propiedades(n).Area;
end

totalPixeles=sumaPixeles; %total devuelto por la funcion


end

