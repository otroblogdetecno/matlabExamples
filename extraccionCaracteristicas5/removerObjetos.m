function [ output_args ] = removerObjetos( imagenNombreSilueta, imagenNombreRe, tamano)
%function [ output_args ] = removerObjetos()
% Remueve objetos mayores al area definida

 %imagenNombreSilueta='silueta4.jpg';
 %imagenNombreRe='removida4.jpg';
 %tamano=500;

%Lectura de la imagen original
ISilueta=imread(imagenNombreSilueta);

% Binarizar
umbral=graythresh(ISilueta);
IB1=im2bw(ISilueta,umbral);
%figure; imshow(IB1);

% Elimina los elementos cuya area es igual al parametro
IB2=bwareaopen(IB1,tamano);
%figure; imshow(IB2);

%Inversa de la imagen
%inversa=1-IB1;
%figure; imshow(inversa);

%%guardar la previa de la silueta con remosion de ruido externo
imwrite(IB2,imagenNombreRe,'jpg')


%imagenNombreSilueta
comando = { 'rm','-rf',imagenNombreSilueta};
command=strjoin(comando);
[status,cmdout] = system(command);



command = strcat('rm -rf ','/home/usuario/ml/tmp/verde_sin_luz.jpg_s4.jpg');

end

