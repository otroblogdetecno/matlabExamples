%% Pruebas de machine learning

%% Ajuste de parámetros iniciales
clc; clear all; close all;

% pathPrincipal='/home/usuario/ml/'; 
% pathEntrada=strcat(pathPrincipal,'input/');
% pathConfiguracion=strcat(pathPrincipal,'conf/');
% pathCalibracion=strcat(pathPrincipal,'calibration/');
% pathAplicacion=strcat(pathPrincipal,'tmp/');
% pathResultados=strcat(pathPrincipal,'output/');

% nombreArchivoResultados='archivoRecortado.csv';
 
% filename=strcat(pathResultados,nombreArchivoResultados);
 
 
%fid = fopen( filename, 'r' );


%cac = textscan( fid, '%s%f%f%f%f%f%f%f%f%f%f%f%s', 'Delimiter', ',' );
%sts = fclose( fid );


load fisheriris
X = meas;
Y = species;

Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1)

flwr = mean(X); % an average flower
flwrClass = predict(Mdl,flwr)
