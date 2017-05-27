function [ output_args ] = PrincipalProcesarImagenManchasSobel( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector )
%Proceso completo que se realiza por cada fotografia de entrada
% Se obtienen los datos aplicando operaciones morfológicas y extrayendo
% características geométricas.
% Se guardan resultados intermedios de manera a que se puedan obtener
% imagenes del proceso.
% -----------------------------------------------------------------------

%% Datos de configuración archivos
%pathPrincipal='/home/usuario/ml/';
%pathEntrada=strcat(pathPrincipal,'input/');
%pathConfiguracion=strcat(pathPrincipal,'conf/');
%pathAplicacion=strcat(pathPrincipal,'tmp/');
%pathResultados=strcat(pathPrincipal,'output/');


NOCALIBRADO=0; % Se define la constante NO CALIBRADO
%banderaCalibracion=0; %0 falta calabrar 1=calibrado
%banderaRotar=1; %0 no rotar 1=rotar



% Para la calibración se necesita la secuencia de recorte solamente

%imagenInicial='ultima4.jpg';
%imagenInicial=strcat(pathEntrada,'verde_sin_luz.jpg');
%imagenInicial=strcat(pathEntrada,'verde_con_luz.jpg');
%imagenInicial=strcat(pathEntrada,'amarillo_con_luz.jpg');
%nombreImagenP='ultima4.jpg';
imagenInicial=strcat(pathEntrada,nombreImagenP);
%archivoConfiguracion=strcat(pathConfiguracion,'configuracion2.xml');
%archivoVector=strcat(pathResultados,'archivo.csv');

pathAplicacion1=strcat(pathAplicacion,'recortes/');
pathAplicacion2=strcat(pathAplicacion,'siluetas/');
pathAplicacion3=strcat(pathAplicacion,'removido/');
pathAplicacion4=strcat(pathAplicacion,'siluetasManchas/');
pathAplicacion5=strcat(pathAplicacion,'manchas/');

% --- NOMBRE DE IMAGENES INTERMEDIAS ---
nombreImagenRecorte1=strcat(pathAplicacion1,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacion1,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacion1,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacion1,nombreImagenP,'_','r4.jpg');

% Siluetas operaciones morfologicas
nombreImagenSilueta1=strcat(pathAplicacion2,nombreImagenP,'_','s1.jpg');
nombreImagenSilueta2=strcat(pathAplicacion2,nombreImagenP,'_','s2.jpg');
nombreImagenSilueta3=strcat(pathAplicacion2,nombreImagenP,'_','s3.jpg');
nombreImagenSilueta4=strcat(pathAplicacion2,nombreImagenP,'_','s4.jpg');


% Siluetas operaciones morfologicas
nombreImagenSiluetaN1=strcat(pathAplicacion2,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacion2,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacion2,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacion2,nombreImagenP,'_','sN4.jpg');

% nombres de archivos con objetos removidos
nombreImagenRemovida1=strcat(pathAplicacion3,nombreImagenP,'_','rm1.jpg');
nombreImagenRemovida2=strcat(pathAplicacion3,nombreImagenP,'_','rm2.jpg');
nombreImagenRemovida3=strcat(pathAplicacion3,nombreImagenP,'_','rm3.jpg');
nombreImagenRemovida4=strcat(pathAplicacion3,nombreImagenP,'_','rm4.jpg');


    %% salida segmentacion
    nombreImagenSalida1=strcat(pathAplicacion4,nombreImagenP,'_','so1.jpg');
    nombreImagenSalida2=strcat(pathAplicacion4,nombreImagenP,'_','so2.jpg');
    nombreImagenSalida3=strcat(pathAplicacion4,nombreImagenP,'_','so3.jpg');
    nombreImagenSalida4=strcat(pathAplicacion4,nombreImagenP,'_','so4.jpg');

    %% salida manchas
    nombreImagenDefectos1=strcat(pathAplicacion5,nombreImagenP,'_','soM1.jpg');
    nombreImagenDefectos2=strcat(pathAplicacion5,nombreImagenP,'_','soM2.jpg');
    nombreImagenDefectos3=strcat(pathAplicacion5,nombreImagenP,'_','soM3.jpg');
    nombreImagenDefectos4=strcat(pathAplicacion5,nombreImagenP,'_','soM4.jpg');



areaObjetosRemover=500; % tamaño para realizar granulometria




%% Lectura de la imagen
IOrig=imread(imagenInicial);
%figure; imshow(IOrig);
%% Rotacion de la imagen
%Rotar en recortar imagen tambien

if(banderaRotar==1) %ROTAR
    IOrigTemp = imrotate(IOrig,180); %rotar la imagen
    IOrig=IOrigTemp;
end %rotar


%figure; imshow(IOrig);

%% ----- INICIO Definicion de topes
% Para definicion de rectangulos
% Se calcula el tamaño de la imagen para luego aplicar las lineas de
% cortes.
% obtener el tamaño

[filasTope, columnasTope, color]=size(IOrig);
inicioFilas=0;
inicioColumnas=0;

% ----- FIN Definicion de las variables de configuracion -----



%% Definicion de los cuadros, según numeración 
Fila1=lecturaConfiguracion('Fila1', archivoConfiguracion);
FilaAbajo=lecturaConfiguracion('FilaAbajo', archivoConfiguracion);

%Cuadro 1 abajo
Cuadro1_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro1_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro1_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro1_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro1_espacioFila=lecturaConfiguracion('Cuadro1_espacioFila', archivoConfiguracion);
Cuadro1_espacioColumna=lecturaConfiguracion('Cuadro1_espacioColumna', archivoConfiguracion);

%Cuadro 2 izquierda
Cuadro2_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro2_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro2_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro2_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro2_espacioFila=lecturaConfiguracion('Cuadro2_espacioFila', archivoConfiguracion);
Cuadro2_espacioColumna=lecturaConfiguracion('Cuadro2_espacioColumna', archivoConfiguracion);

%Cuadro 3 centro
Cuadro3_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro3_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro3_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro3_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro3_espacioFila=lecturaConfiguracion('Cuadro3_espacioFila', archivoConfiguracion);
Cuadro3_espacioColumna=lecturaConfiguracion('Cuadro3_espacioColumna', archivoConfiguracion);

%Cuadro 4 derecha
Cuadro4_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro4_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro4_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro4_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro4_espacioFila=lecturaConfiguracion('Cuadro4_espacioFila', archivoConfiguracion);
Cuadro4_espacioColumna=lecturaConfiguracion('Cuadro4_espacioColumna', archivoConfiguracion);


% ----- FIN Definicion de topes


%% --------------------------------------------
%% Recortando imagenes 
%
fprintf('Recortando imagenes --> \n');
%Recuadro 1 principal.
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte1, Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%Recuadro 2 izquierda
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte2, Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioFila, Cuadro2_espacioColumna);

%Recuadro 3 centro
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte3, Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila);

%Recuadro 4 derecha
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte4, Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioFila, Cuadro4_espacioColumna);

%% Aplicando operaciones morfologicas
fprintf('Aplicando operaciones morfologicas --> \n');
operacionesMorfologicas(nombreImagenRecorte1,nombreImagenSilueta1);
operacionesMorfologicas(nombreImagenRecorte2,nombreImagenSilueta2);
operacionesMorfologicas(nombreImagenRecorte3,nombreImagenSilueta3);
operacionesMorfologicas(nombreImagenRecorte4,nombreImagenSilueta4);

%% Removiendo objetos pequeños
fprintf('Removiendo objetos pequeños --> \n');
removerObjetos(nombreImagenSilueta1, nombreImagenSiluetaN1, areaObjetosRemover);
removerObjetos(nombreImagenSilueta2, nombreImagenSiluetaN2, areaObjetosRemover);
removerObjetos(nombreImagenSilueta3, nombreImagenSiluetaN3, areaObjetosRemover);
removerObjetos(nombreImagenSilueta4, nombreImagenSiluetaN4, areaObjetosRemover);


%% Removiendo fondo
fprintf('Removiendo fondo --> \n');
removerFondo4(nombreImagenRecorte1, nombreImagenSiluetaN1, nombreImagenRemovida1);
removerFondo4(nombreImagenRecorte2, nombreImagenSiluetaN2, nombreImagenRemovida2);
removerFondo4(nombreImagenRecorte3, nombreImagenSiluetaN3, nombreImagenRemovida3);
removerFondo4(nombreImagenRecorte4, nombreImagenSiluetaN4, nombreImagenRemovida4);


%% Tercera opcion, segmentacion con TopHat, Sobel.
tamanoManchas=1500;   
%Imagen 1 
   SegmentacionSobel(nombreImagenRemovida1, nombreImagenSalida1);
   extraerRegionManchas( nombreImagenSalida1, nombreImagenDefectos1, tamanoManchas);
   
   %Imagen 2
   SegmentacionSobel(nombreImagenRemovida2, nombreImagenSalida2);
   extraerRegionManchas( nombreImagenSalida2, nombreImagenDefectos2, tamanoManchas);
    
    %Imagen 3
   SegmentacionSobel(nombreImagenRemovida3, nombreImagenSalida3);
   extraerRegionManchas( nombreImagenSalida3, nombreImagenDefectos3, tamanoManchas);    
    
   %Imagen 4
   SegmentacionSobel(nombreImagenRemovida4, nombreImagenSalida4);
   extraerRegionManchas( nombreImagenSalida4, nombreImagenDefectos4, tamanoManchas);


%% si está calibrado o no

if(banderaCalibracion==NOCALIBRADO)
    % ---- Si NO está calibrado ----

else

%% Extraccion de caracteristicas
pixelmm=lecturaConfiguracion('pixelLineal', archivoCalibracion);
pixelCuadrado=lecturaConfiguracion('pixelCuadrado', archivoCalibracion);

fprintf('Extraccion de características --> \n');
[ sumaArea, redondez, diametro, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas ] = extraccionCaracteristicasGenerales( nombreImagenRemovida1, nombreImagenDefectos1, nombreImagenDefectos2, nombreImagenDefectos3, nombreImagenDefectos4);


% Cálculo para unidades de medida
diametromm=diametro*pixelmm;
sumaAreamm=sumaArea*pixelCuadrado;







%% Guardado en archivo
clase='SIN_CLASIFICAR';
claseM='SIN_CLASIFICAR';
%fprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f, %10.4f, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalL, finalA, finalB, finalVarianzaH, clase, claseM);

fprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas, clase, claseM);


fila=sprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas, clase, claseM);




guardarArchivoVectorManchas( archivoVector, fila)

    % ---- fin calibrado ----
end %if calbracion  

% -----------------------------------------------------------------------
end %end proceso completo

