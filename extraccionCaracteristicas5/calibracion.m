%% calibracion de valores
clc; clear all; close all;


areaMedir=0.0;
diametromm=0.0;

areaPixeles=0.0;
areaCalibracion=0.0;
equivalencia1mmCuadrado=0.0;
equivalencia1mm=0.0;
tamano=500;

%imagen entrada 
pathPrincipal='/home/usuario/ml/'; 
pathAplicacion=strcat(pathPrincipal,'tmp/');
 nombreImagenP='verde_con_luz.jpg'; 
 nombreImagenSiluetaN1=strcat(pathAplicacion,nombreImagenP,'_','sN1.jpg');


fprintf('------------------------------------------------- \n');
fprintf('Ingrese los valores para la conversion de medidas \n');
fprintf('------------------------------------------------- \n');

fprintf('La calibración se realiza en base a una esfera conocida \n');


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


%fprintf('Ingrese los valores para la conversion de medidas \n');


% Primeramente obtener un buen recorte de las fotografías, modificando los
% archivos que sean necesarios.

%Abrir fotografía.
%Medir características geométricas.
%Presentar valores.
