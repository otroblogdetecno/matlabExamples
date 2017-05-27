function [output_args]=calibracion(pathPrincipal, pathCalibracion, nombreImagenP)
%% calibracion de valores
%clc; clear all; close all;


areaMedir=0.0;
diametromm=0.0;

areaPixeles=0.0;
areaCalibracion=0.0;
equivalencia1mmCuadrado=0.0;
equivalencia1mm=0.0;
tamano=500;

%imagen entrada 
%pathPrincipal='/home/usuario/ml/'; 
%pathAplicacion=strcat(pathPrincipal,'calibration/');
% nombreImagenP='2017-01-27-160836.jpg'; 

nombreImagenSiluetaN1=strcat(pathCalibracion,nombreImagenP,'_','sN1.jpg');


fprintf('------------------------------------------------- \n');
fprintf('Ingrese los valores para la conversion de medidas \n');
fprintf('------------------------------------------------- \n');

fprintf('La calibración se realiza en base a una esfera conocida \n');

fprintf('Calculando características geométricas desde una imagen \n');
[nombreImagenSiluetaN1, areaPixeles, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas(nombreImagenSiluetaN1,tamano);


diametromm=input('Ingrese DIÁMETRO de la esfera de calibración en milímetros: ');
%areaPixeles=input('Valor del área en pixeles: ');
areaCalibracion=pi*((diametromm^2)/4);

equivalencia1mmCuadrado=areaCalibracion/areaPixeles;
equivalencia1mm=sqrt(equivalencia1mmCuadrado);

fprintf('------------------------------------------------- \n');
fprintf('Resultados \n');
fprintf('------------------------------------------------- \n');

fprintf('Area de Calibración= %f \n', areaCalibracion);
fprintf('Area en pixeles = %f \n', areaPixeles);
fprintf('1 pixel^2= %f mm^2\n', equivalencia1mmCuadrado);
fprintf('1 pixel lineal= %f mm\n', equivalencia1mm);

%% impresion de archivo
cadenaAreaCalibracion=sprintf('<listitem>\n <label>areaCalibracion</label>\n <value>%f</value>\n </listitem>\n',areaCalibracion);
cadenaAreaPixeles=sprintf('<listitem>\n <label>areaPixeles</label>\n <value>%f</value>\n </listitem>\n',areaPixeles);
cadenaPixelCuadrado=sprintf('<listitem>\n <label>pixelCuadrado</label>\n <value>%f</value>\n </listitem>\n', equivalencia1mmCuadrado);	
cadenaPixelLineal=sprintf('<listitem>\n <label>pixelLineal</label>\n <value>%f</value>\n </listitem> \n',equivalencia1mm);
cadenaDiametro=sprintf('<listitem>\n <label>diametroEsfera</label>\n <value>%f</value>\n </listitem>\n',diametromm);


fprintf('\n------------ RECORTAR DESDE AQUI ------\n');
fprintf('%s',cadenaAreaCalibracion);
fprintf('%s',cadenaAreaPixeles);
fprintf('%s',cadenaPixelCuadrado);
fprintf('%s',cadenaPixelLineal);
fprintf('%s',cadenaDiametro);
fprintf('\n------------ RECORTAR HASTA AQUI ------\n');


%%
%fprintf('Ingrese los valores para la conversion de medidas \n');


% Primeramente obtener un buen recorte de las fotografías, modificando los
% archivos que sean necesarios.

%Abrir fotografía.
%Medir características geométricas.
%Presentar valores.
end %Fin de la funcion