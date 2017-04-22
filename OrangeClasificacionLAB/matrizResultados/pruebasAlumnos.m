%% Pruebas alumnos
close all;
clear all;
clc;

%Matriz=[39 0 0; 2 45 1; 0 0 17]
%Matriz=[40 1 1; 2 45 1; 1 1 19]
%Matriz=[15 5 ; 8 11]
Matriz=[17 6 ; 7 19]

;
fprintf('Precision | Sensibilidad | Especificidad | \n');
fprintf('-----------------------------------\n');
clase=1;
fprintf('Clase %i\n',clase);
fprintf('%f | %f | %f | \n',precisionClase(Matriz, clase),sensitivityClase(Matriz,clase),specificityClase(Matriz,clase));


fprintf('-----------------------------------\n');
clase=2;
fprintf('Clase %i\n',clase);
fprintf('%f | %f | %f | \n',precisionClase(Matriz, clase),sensitivityClase(Matriz,clase),specificityClase(Matriz,clase));
fprintf('-----------------------------------\n');

