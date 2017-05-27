function [ sumaArea, redondez, diametro, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas ] = extraccionCaracteristicasGenerales( imagenNombreSilueta1, nombreImagenDefectosND1, nombreImagenDefectosND2, nombreImagenDefectosND3, nombreImagenDefectosND4)
% Se realiza el proceso completo de extraccion de caracteristicas,
% utilizando las imagenes generadas en la etapa de adquisicion y
% sirviendose de los archivos temporales para el proceso, el cual proviene
% de un ciclo principal de lectura del directorio.

% ----------------------------------------------------------------------

tamano=2000;

% en base a las cuatro caras de la fruta se calculan las características
sumaParcial1=0;
sumaParcial2=0;
sumaParcial3=0;
sumaParcial4=0;

totalManchasParcial1=0;
totalManchasParcial2=0;
totalManchasParcial3=0;
totalManchasParcial4=0;

%% imagen 1 

%% Extraccion de características geométricas
[imagenNombreSilueta, sumaArea, redondez, diametro, ejeMayor, ejeMenor]=extraerCaracteristicasGeometricas( imagenNombreSilueta1,tamano);

%conteo de pixeles manchados
[sumaParcial1, totalManchas1]=extraerPixelesManchas(nombreImagenDefectosND1);

%% imagen 2
[sumaParcial2, totalManchas2]=extraerPixelesManchas(nombreImagenDefectosND2);

%% imagen 3
[sumaParcial3, totalManchas3]=extraerPixelesManchas(nombreImagenDefectosND3);


%% imagen 4 
[sumaParcial4, totalManchas4]=extraerPixelesManchas(nombreImagenDefectosND4);


totalPixelesManchas=sumaParcial1+sumaParcial2+sumaParcial3+sumaParcial4;
totalManchas=totalManchas1+totalManchas2+totalManchas3+totalManchas4;


 



%% Armado de vector
% Las variables que forman el vector se encuentran incluidas como parámetro de salida

% ----------------------------------------------------------------------

end %fin extraccionCaracteristicas

