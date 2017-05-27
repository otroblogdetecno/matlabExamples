%% MainSegmentarRGB.m
% Asume las imagenes recortadas desde una fuente

%% Variables de configuracion

%% Ajuste de parámetros iniciales
clc; clear all; close all;


%nombreImagenP='061.jpg';
nombreImagenP='143.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/clasLAB/');
 pathEntradaAprender=strcat(pathPrincipal,'inputToLearn/'); 
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearnLABCF/'); 
 
%% Salida manchas
 pathAplicacionSalidaSeg=strcat(pathPrincipal,'tmpSegRGB/'); 

 
 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathAplicacionAprender,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacionAprender,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacionAprender,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacionAprender,nombreImagenP,'_','r4.jpg');
 

% nombres de archivos con objetos removidos
nombreImagenRemovida1=strcat(pathAplicacionAprender,nombreImagenP,'_','rm1.jpg');
nombreImagenRemovida2=strcat(pathAplicacionAprender,nombreImagenP,'_','rm2.jpg');
nombreImagenRemovida3=strcat(pathAplicacionAprender,nombreImagenP,'_','rm3.jpg');
nombreImagenRemovida4=strcat(pathAplicacionAprender,nombreImagenP,'_','rm4.jpg');

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathAplicacionAprender,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacionAprender,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacionAprender,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacionAprender,nombreImagenP,'_','sN4.jpg');


%% Siluetas manchas
nombreImagenManchasN1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN1.jpg');
nombreImagenManchasN2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN2.jpg');
nombreImagenManchasN3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN3.jpg');
nombreImagenManchasN4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MN4.jpg');


%% solo manchas
nombreImagenDefectosND1=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND1.jpg');
nombreImagenDefectosND2=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND2.jpg');
nombreImagenDefectosND3=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND3.jpg');
nombreImagenDefectosND4=strcat(pathAplicacionSalidaSeg,nombreImagenP,'_','MND4.jpg');



%% Nombres de archivos 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 

umbralFijoR= 0.90;
umbralFijoG= 0.75;
tamanoMaximoManchas=1000;
%% resultados
% en base a las cuatro caras de la fruta se calculan las características
sumaParcial1=0;
sumaParcial2=0;
sumaParcial3=0;
sumaParcial4=0;

totalManchasParcial1=0;
totalManchasParcial2=0;
totalManchasParcial3=0;
totalManchasParcial4=0;

%SegmentarRGBManchasOtzuFijo(nombreImagenRecorte1);

%SegRGBMCanalFijo( nombreImagenRecorte1, nombreImagenManchasN1, umbralFijoR, umbralFijoG );
%SegRGBMCanalFijo( nombreImagenRecorte2, nombreImagenManchasN2, umbralFijoR, umbralFijoG );
%SegRGBMCanalFijo( nombreImagenRecorte3, nombreImagenManchasN3, umbralFijoR, umbralFijoG );
%SegRGBMCanalFijo( nombreImagenRecorte4, nombreImagenManchasN4, umbralFijoR, umbralFijoG );

%extraerRegionManchas(nombreImagenManchasN1, nombreImagenDefectosND1, tamanoMaximoManchas);
%extraerRegionManchas(nombreImagenManchasN2, nombreImagenDefectosND2, tamanoMaximoManchas);
%extraerRegionManchas(nombreImagenManchasN3, nombreImagenDefectosND3, tamanoMaximoManchas);
%extraerRegionManchas(nombreImagenManchasN4, nombreImagenDefectosND4, tamanoMaximoManchas);

%[sumaParcial1, totalManchas1]=extraerPixelesManchas(nombreImagenDefectosND1);
%[sumaParcial2, totalManchas2]=extraerPixelesManchas(nombreImagenDefectosND2);
%[sumaParcial3, totalManchas3]=extraerPixelesManchas(nombreImagenDefectosND3);
%[sumaParcial4, totalManchas4]=extraerPixelesManchas(nombreImagenDefectosND4);


%totalPixelesFruta=sumaParcial1+sumaParcial2+sumaParcial3+sumaParcial4;

%fprintf('Pixeles=%i TotalManchas=%i \n',sumaParcial1, totalManchas1);
%fprintf('Pixeles=%i TotalManchas=%i \n',sumaParcial2, totalManchas2);
%fprintf('Pixeles=%i TotalManchas=%i \n',sumaParcial3, totalManchas3);
%fprintf('Pixeles=%i TotalManchas=%i \n',sumaParcial4, totalManchas4);

%% watershed

RGB=imread(nombreImagenRemovida1);

IR=RGB(:,:,1);

%BW = IR < 172;

BW = IR < 190;

%umbral=graythresh(IR);
%BW=im2bw(IR,umbral);

[ListadoObjetos totalObjetos]=bwlabel(BW);

figure; imshow(IR);
figure; imshow(BW);