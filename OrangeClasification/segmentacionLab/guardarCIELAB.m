function [ output_args ] = guardarCIELAB( nombreArchivo, filaAgregar, borrar )
%function [ output_args ] = guardarArchivoTestTraining()

%pathPrincipal='/home/usuario/ml/';
%pathResultados=strcat(pathPrincipal,'output/');
%nombreArchivoLAB='archivoLAB.csv';
%fileHandlerLAB=strcat(pathResultados,nombreArchivoLAB); 

%nombreArchivo=fileHandlerLAB;
%filaAgregar=sprintf('%f,%f,%f,%i,%i \n',0.0, 0.0, 0.0,1,1);
%borrar=1;

fileIDTest = fopen(nombreArchivo,'r'); %el hander para saber si existe
fileID = fopen(nombreArchivo,'a'); %abre el archivo para agregar datos
filaCabecera=sprintf('L, a, b, x, y, cluster');  

if (fileIDTest==-1)    
        %% Es primera vez
        %Si se agregan mas campos, se debe agregar su cabecera
%        fprintf('CREANDO ARCHIVO CON CABECERA \n');
        fprintf(fileID,'%6s \n',filaCabecera);% agrega la cabecera
        fprintf(fileID,'%6s \n',filaAgregar);  
else
    if borrar==0 %se limpia el archivo        
%        fprintf('BORRANDO LOS RESULTADOS\n');
        fclose(fileIDTest);% cierra el handler de lectura, dado que el archivo existe        
        fileIDBorrar = fopen(nombreArchivo,'w'); %borrar
        fprintf(fileID,'%6s \n',filaCabecera);% agrega la cabecera        
        fclose(fileIDBorrar);
    else
%        fprintf('AGREGANDO DATOS AL ARCHIVO EXISTENTE \n');
        fclose(fileIDTest);% cierra el handler de lectura, dado que el archivo existe
        fprintf(fileID,'%6s',filaAgregar);        
    end %borrar==0        
end %fin verificacion si el archivo existe
    
    fclose(fileID);    %cierre del archivo para escritura

end %guardarCIELAB
