function [ sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalL, finalA, finalB, finalVarianzaH ] = extraccionCaracteristicas2( imagenNombreColor1, imagenNombreColor2, imagenNombreColor3, imagenNombreColor4, imagenNombreSilueta1, imagenNombreSilueta2, imagenNombreSilueta3, imagenNombreSilueta4)
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

%% Extracción de características de color RGB
%imagen 1
%[mediaRojo1, mediaBerde1, mediaAzul1]=extraerColorPromedio( imagenNombreColor1, imagenNombreSilueta1);
[mediaL1, mediaA1, mediaB1, mediaVarianzaH1]=extraerColorPromedioLAB( imagenNombreColor1, imagenNombreSilueta1);

%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaBerde, mediaAzul);


%imagen 2
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta2,tamano);
%[mediaRojo2, mediaBerde2, mediaAzul2]=extraerColorPromedio( imagenNombreColor2, imagenNombreSilueta2);
[mediaL2, mediaA2, mediaB2, mediaVarianzaH2]=extraerColorPromedioLAB( imagenNombreColor2, imagenNombreSilueta2);

%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta2, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaBerde, mediaAzul);

%imagen 3 
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta3,tamano);
%[mediaRojo3, mediaBerde3, mediaAzul3]=extraerColorPromedio( imagenNombreColor3, imagenNombreSilueta3);
[mediaL3, mediaA3, mediaB3, mediaVarianzaH3]=extraerColorPromedioLAB( imagenNombreColor3, imagenNombreSilueta3);
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta3, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaBerde, mediaAzul);

%imagen 4 
%llamado a funciones

%[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta4,tamano);
%[mediaRojo4, mediaBerde4, mediaAzul4]=extraerColorPromedio( imagenNombreColor4, imagenNombreSilueta4);
[mediaL4, mediaA4, mediaB4, mediaVarianzaH4]=extraerColorPromedioLAB( imagenNombreColor4, imagenNombreSilueta4);
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f; %3i; %3i; %3i; \n',imagenNombreSilueta4, sumaArea, redondez, diametro, ejeMayor, ejeMenor,mediaRojo, mediaBerde, mediaAzul);

% Cálculo de la media en RGB
finalRojo=0; %uint8((mediaRojo1+mediaRojo2+mediaRojo3+mediaRojo4)/4);
finalVerde=0; %uint8((mediaBerde1+mediaBerde2+mediaBerde3+mediaBerde4)/4);
finalAzul=0; %uint8((mediaAzul1+mediaAzul2+mediaAzul3+mediaAzul4)/4);

% Cálculo de la media HSV
finalL=(mediaL1+mediaL2+mediaL3+mediaL4)/4;
finalA=(mediaA1+mediaA2+mediaA3+mediaA4)/4;
finalB=(mediaB1+mediaB2+mediaB3+mediaB4)/4;

%Media de la varianza del canal H, para clasificación de color
%finalVarianzaH=(mediaVarianzaH1+mediaVarianzaH2+mediaVarianzaH3+mediaVarianzaH4)/4;
finalVarianzaH=0;
%prueba de impresion
%fprintf('en la funcion extraccion %s, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f,\n',imagenNombreSilueta1, sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV);

%% Armado de vector
% Las variables que forman el vector se encuentran incluidas como parámetro de salida

% ----------------------------------------------------------------------

end %fin extraccionCaracteristicas

