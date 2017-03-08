function [ output_args ] = guardarArchivoVector( nombreArchivo, filaAgregar )
% Guardar archivo vector según la fila a agregar
% Abre y cierra el archivo agregando al final


fileIDTest = fopen(nombreArchivo,'r'); %el hander para saber si existe
fileID = fopen(nombreArchivo,'a'); %abre el archivo para agregar datos
    


if (fileIDTest==-1)
    %% Es primera vez
    %Si se agregan mas campos, se debe agregar su cabecera
    filaCabecera=sprintf('nombre_imagen, pixel_p, area_p, area_mm, redondez, diametro_p, diametro_mm, ejeMayor, ejeMenor, R, G, B, H, S, V, clasificacion');
    fprintf('CREANDO ARCHIVO CON CARACTERÍSTICAS \n');
    fprintf(fileID,'%6s \n',filaCabecera);% agrega la cabecera
    fprintf(fileID,'%6s',filaAgregar);

else
    fprintf('AGREGANDO DATOS AL ARCHIVO EXISTENTE \n');
    fclose(fileIDTest);% cierra el handler de lectura, dado que el archivo existe
    fprintf(fileID,'%6s',filaAgregar);
    
end %fin verificacion si el archivo existe
    
    fclose(fileID);    %cierre del archivo para escritura

end %guardarArchivoVector

