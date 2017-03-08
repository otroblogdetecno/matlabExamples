function [ sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV ] = extraccionCaracteristicas( imagenNombreColor1, imagenNombreColor2, imagenNombreColor3, imagenNombreColor4, imagenNombreSilueta1, imagenNombreSilueta2, imagenNombreSilueta3, imagenNombreSilueta4)
% Se realiza el proceso completo de extraccion de caracteristicas,
% utilizando las imagenes generadas en la etapa de adquisicion y
% sirviendose de los archivos temporales para el proceso, el cual proviene
% de un ciclo principal de lectura del directorio.

% ----------------------------------------------------------------------

tamano=2000;

%imagen 1 
%fprintf('Imagen; Suma de Areas; Redondez; diametro; eMayor; eMenor; MediaCanalRojo; MediaCanalVerde; MediaCanalAzul \n');
%llamado a funciones

%% Extraccion de características geométricas
[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta1,tamano);
%% Extracción de características de color

[mediaRojo1, mediaVerde1, mediaAzul1]=extraerColorPromedio( imagenNombreColor1, imagenNombreSilueta1);
[mediaH1, mediaS1, mediaV1]=extraerColorPromedioHSV( imagenNombreColor1, imagenNombreSilueta1);

%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaVerde, mediaAzul);


%imagen 2
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta2,tamano);
[mediaRojo2, mediaVerde2, mediaAzul2]=extraerColorPromedio( imagenNombreColor2, imagenNombreSilueta2);
[mediaH2, mediaS2, mediaV2]=extraerColorPromedioHSV( imagenNombreColor2, imagenNombreSilueta2);

%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta2, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaVerde, mediaAzul);

%imagen 3 
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta3,tamano);
[mediaRojo3, mediaVerde3, mediaAzul3]=extraerColorPromedio( imagenNombreColor3, imagenNombreSilueta3);
[mediaH3, mediaS3, mediaV3]=extraerColorPromedioHSV( imagenNombreColor3, imagenNombreSilueta3);
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta3, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaVerde, mediaAzul);

%imagen 4 
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta4,tamano);
[mediaRojo4, mediaVerde4, mediaAzul4]=extraerColorPromedio( imagenNombreColor4, imagenNombreSilueta4);
[mediaH4, mediaS4, mediaV4]=extraerColorPromedioHSV( imagenNombreColor4, imagenNombreSilueta4);
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta4, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaVerde, mediaAzul);

% Cálculo de la media en RGB
finalRojo=uint8((mediaRojo1+mediaRojo2+mediaRojo3+mediaRojo4)/4);
finalVerde=uint8((mediaVerde1+mediaVerde2+mediaVerde3+mediaVerde4)/4);
finalAzul=uint8((mediaAzul1+mediaAzul2+mediaAzul3+mediaAzul4)/4);

% Cálculo de la media HSV
finalH=(mediaH1+mediaH2+mediaH3+mediaH4)/4;
finalS=(mediaS1+mediaS2+mediaS3+mediaS4)/4;
finalV=(mediaV1+mediaV2+mediaV3+mediaV4)/4;


%prueba de impresion
%fprintf('en la funcion extraccion %s, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f,\n',imagenNombreSilueta1, sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV);

%% Armado de vector
% Las variables que forman el vector se encuentran incluidas como parámetro de salida

% ----------------------------------------------------------------------

end %fin extraccionCaracteristicas

