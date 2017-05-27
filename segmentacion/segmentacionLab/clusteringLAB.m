function [ output_args ] = clusteringLAB(imagenNombreColor, numeroClusters, fileHandlerLAB, fileHandlerLABCluster)
%% Pruebas de machine learning
% 
% Según la entrada generada por el proceso de entrenamiento, a la cual un
% experto etiqueta manualmente las naranjas obtenidas y recibiendo una
% entrada de carcterísticas de una naranja a clasificar.
% Este proceso emite un resultado final clasificando la naranja según
% corresponda.
% Asume que los parametros vienen configurados previamente desde un nivel
% superior.

%% Ajuste de parámetros iniciales
%clc; clear all; close all;


% Segmenta imagenes por color
%numeroClusters=5;

%% configuraciones de imágenes
%imagenNombreColor='/home/usuario/ml/imgcolores/006.jpg_rem1.jpg';
%imagenNombreColor='/home/usuario/ml/imgcolores/010.jpg_rm1.jpg';
%imagenNombreMascara='/home/usuario/ml/imgcolores/006.jpg_sN1.jpg';

%% configuraciones del clasificador
%pathPrincipal='/home/usuario/ml/'; 
%pathResultados=strcat(pathPrincipal,'output/');

 %% Parametros de entrada en fomato .csv
%nombreArchivoLAB='archivoLAB.csv';
%nombreArchivoLABCluster='archivoLABC.csv'; 
% 
%formatSpecLAB='%f%f%f%i%i'; %formato del archivo a leer
%fileHandlerLAB=strcat(pathResultados,nombreArchivoLAB); %handle para conjunto de entrenamiento
%fileHandlerLABCluster=strcat(pathResultados,nombreArchivoLABCluster);

%% configuracion de nombre de salida
sufijo1='_c1.jpg'; 
sufijo2='_c2.jpg';
sufijo3='_c3.jpg';
sufijo4='_c4.jpg';
sufijo5='_c5.jpg';

rgbc1=strcat(imagenNombreColor,sufijo1);
rgbc2=strcat(imagenNombreColor,sufijo2);
rgbc3=strcat(imagenNombreColor,sufijo3);
rgbc4=strcat(imagenNombreColor,sufijo4);
rgbc5=strcat(imagenNombreColor,sufijo5);


%% Carga del dataset de entrenamiento
% se cargan los datos en una tabla
tablaDSTLAB = readtable(fileHandlerLAB);

% se cargan las caracteristicas que alimentaran al clasificador, el lugar
% 1 2 3 L *a *b
tablaDSTLABCaracteristicas=tablaDSTLAB(:,1:3);

%% Conversion de tablas a array cell
% Se realizan conversiones para entrenar al clasificador
arrayTrainingCaracteristicas=table2array(tablaDSTLABCaracteristicas);


%% Entrenamiento del clasificador
% Se alimenta al algoritmo de agrupamiento
fprintf('k-mean CLUSTERING \n');
idx= kmeans(arrayTrainingCaracteristicas,numeroClusters);

fprintf('ETIQUETANDO DE CLUSTERING \n');
%Se toma el resultado del algoritmo para agregarlos a la tabla de
%resultados
clusterT=array2table(idx); 
tablaDSTLAB(:,6)=clusterT; %la posición 6 es para guardar la etiqueta
fprintf('GUARDANDO EL ARCHIVO CON LAS ETIQUETAS DE CLUSTERING \n');
%writetable(tablaDSTLAB,fileHandlerLABCluster,'WriteRowNames',true);
%%escritura en archivo


%% --- INICIO PRINCIPAL TRABAJO CON IMAGENES EN RGB Y L*a*b ---
%Establecer el tamano de la imagen.
%Crear cinco fondos del mismo tamano
%fondo de imagen con el mismo tamano
%escribir segun sea el cluster en la imagen.



%Lectura de la imagen con fondo
IRecorteRGB=imread(imagenNombreColor); %solamente queda por las dimensiones de las imagenes
%IRecorteLAB=rgb2lab(IRecorteRGB); % conversion a L*a*b
[filasTope, columnasTope, algo]=size(IRecorteRGB);

%% declaracion de clusters
Icluster1=zeros(filasTope,columnasTope,3);
Icluster2=zeros(filasTope,columnasTope,3);
Icluster3=zeros(filasTope,columnasTope,3);
Icluster4=zeros(filasTope,columnasTope,3);
Icluster5=zeros(filasTope,columnasTope,3);


[totalFilasTabla totalColumnas]=size(tablaDSTLAB);
%% --------------------------

fprintf('SEPARANDO CLUSTER EN IMAGENES \n');
for index=1:totalFilasTabla
    %fprintf('index=%i/%i \n',index,totalFilasTabla);
    registro=tablaDSTLAB(index,:); %guarda el registro
    %index
    %registro
    
    xi=table2array(registro(1,4));
    yi=table2array(registro(1,5));
    numCluster=table2array(registro(1,6));
    %elige el archivo cluster
    switch (numCluster)
        case 1
            Icluster1(xi,yi,1)=table2array(registro(1,1)); % valores L
            Icluster1(xi,yi,2)=table2array(registro(1,2)); % valores *a
            Icluster1(xi,yi,3)=table2array(registro(1,3)); % valores *b            
            
        case 2
            Icluster2(xi,yi,1)=table2array(registro(1,1)); % valores L
            Icluster2(xi,yi,2)=table2array(registro(1,2)); % valores *a
            Icluster2(xi,yi,3)=table2array(registro(1,3)); % valores *b            
            
        case 3
            Icluster3(xi,yi,1)=table2array(registro(1,1)); % valores L
            Icluster3(xi,yi,2)=table2array(registro(1,2)); % valores *a
            Icluster3(xi,yi,3)=table2array(registro(1,3)); % valores *b            

        case 4
            Icluster4(xi,yi,1)=table2array(registro(1,1)); % valores L
            Icluster4(xi,yi,2)=table2array(registro(1,2)); % valores *a
            Icluster4(xi,yi,3)=table2array(registro(1,3)); % valores *b            

        case 5
            Icluster5(xi,yi,1)=table2array(registro(1,1)); % valores L
            Icluster5(xi,yi,2)=table2array(registro(1,2)); % valores *a
            Icluster5(xi,yi,3)=table2array(registro(1,3)); % valores *b            

    end
end %for

%% --- FIN PRINCIPAL DEL CLASIFICADOR    ---

%size(tablaDSTLAB);

%% presentación en pantalla de las imáegenes obtenidas
%figure;imshow(Icluster1);
%figure;imshow(Icluster2);
%figure;imshow(Icluster3);
%figure;imshow(Icluster4);
%figure;imshow(Icluster5);

IRGB1=lab2rgb(Icluster1);
IRGB2=lab2rgb(Icluster2);
IRGB3=lab2rgb(Icluster3);
IRGB4=lab2rgb(Icluster4);
IRGB5=lab2rgb(Icluster5);

%% guardar en archivos
imwrite(IRGB1,rgbc1);
imwrite(IRGB2,rgbc2);
imwrite(IRGB3,rgbc3);
imwrite(IRGB4,rgbc4);
imwrite(IRGB5,rgbc5);

%% Mostrar
figure('Name','Cluster 1'); imshow(IRGB1);
figure('Name','Cluster 2'); imshow(IRGB2);
figure('Name','Cluster 3'); imshow(IRGB3);
figure('Name','Cluster 4'); imshow(IRGB4);
figure('Name','Cluster 5'); imshow(IRGB5);
end % fin clusteringLAB