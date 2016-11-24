function [ valorR, valorG, valorB ] = funcionMediaColores( imagenNombre )
%%

rgbImagen=imread(imagenNombre);

canalRojo = rgbImagen(:, :, 1);
canalVerde = rgbImagen(:, :, 2);
canalAzul = rgbImagen(:, :, 3);

% Get means
redMean = mean2(canalRojo);
greenMean = mean2(canalVerde);
blueMean = mean2(canalAzul);


valorR = uint8(redMean);
valorG = uint8(greenMean);
valorB = uint8(blueMean);


%fprintf('%s; %3i; %3i; %3i \n',imagenNombre,valorR, valorG, valorB);


%% Calculo a HSV, conversion a espacio HSV
hsvImagen=rgb2hsv(rgbImagen);

%hue, saturation, value
hue=hsvImagen(:, :, 1);
sat=hsvImagen(:, :, 2);
val=hsvImagen(:, :, 3);


hueMean=mean2(hue);
satMean=mean2(sat);
valMean=mean2(val);

valorH=uint16(hueMean*360);
valorS=uint16(satMean*100);
valorV=uint16(valMean*100);


fprintf('\n NOMBRE DE IMAGEN; R; G; B - H; S; V \n');
fprintf('%s; %3i; %3i; %3i - %3i; %3i; %3i\n',imagenNombre,valorR, valorG, valorB, valorH, valorS, valorV);

%%
end

