%% Pruebas alumnos
close all;
clear all;
clc;

%Matriz=[39 0 0; 2 45 1; 0 0 17]
Matriz=[40 1 1; 2 45 1; 1 1 19]


fprintf('-----------------------------------\n');
fprintf('Clase %i\n',1);
precisionClase(Matriz, 1)
sensitivityClase(Matriz,1)
specificityClase(Matriz,1)
fprintf('-----------------------------------\n');


fprintf('-----------------------------------\n');
fprintf('Clase %i\n',2);
precisionClase(Matriz, 2)
sensitivityClase(Matriz,2)
specificityClase(Matriz,2)
fprintf('-----------------------------------\n');


fprintf('-----------------------------------\n');
fprintf('Clase %i\n',3);
precisionClase(Matriz, 3)
sensitivityClase(Matriz,3)
specificityClase(Matriz,3)
fprintf('-----------------------------------\n');