%% Secuencia para obtener manchas
clc; clear all; close all;

%nombreIRemovida='removida2.jpg';
%nombreIintermedia='intermedia2.jpg';
%nombreIManchas='manchas2.jpg';
%nombreICManchas='cmanchas2.jpg';
umbralr=0.60;



obtenerManchas('removida1.jpg', 'intermedia1.jpg', 'manchas1.jpg', 'cmanchas1.jpg', umbralr);
obtenerManchas('removida2.jpg', 'intermedia2.jpg', 'manchas2.jpg', 'cmanchas2.jpg', umbralr);
obtenerManchas('removida3.jpg', 'intermedia3.jpg', 'manchas3.jpg', 'cmanchas3.jpg', umbralr);
obtenerManchas('removida4.jpg', 'intermedia4.jpg', 'manchas4.jpg', 'cmanchas4.jpg', umbralr);