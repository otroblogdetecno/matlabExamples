function [ output_args ] = guardarArchivoVector( nombreArchivo, filaAgregar )
% Guardar archivo vector según la fila a agregar
% Abre y cierra el archivo agregando al final



fileID = fopen(nombreArchivo,'a');
fprintf(fileID,'%6s \n',filaAgregar);
fclose(fileID);



end %guardarArchivoVector

