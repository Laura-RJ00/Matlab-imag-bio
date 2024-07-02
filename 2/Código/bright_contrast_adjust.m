function [imOutput] = bright_contrast_adjust(imInput, W, c)
% imInput: imagen de gris a la que se le desea variar el brillo y contraste
% c: Es la variable que definirá el valor de intensidad sobre el que se 
% centrará la ventana definida por W.
% W: Ancho de la ventana. Este par´ametro permite definir el tamaño y 
% posición de la ventana como [c ? W/2 : c + W/2].
% imOutput: Se trata de la imagen en grises de salida con el contraste y 
% brillo modificado.

%% PASO 1: necesitamos conocer cual es el tipo de datos que 
%% utiliza la imagen de entrada y a partir de estos asociarle un número de
%% bits

% Creamos dos cadena de string (una para el formato int y otra para el
% unit)
    formatoINT=['int8 int16 int32 int32 '];
    formatoUINT=['uint8 uint16 uint32 uint64 '];

% Mediante la función split partimos las cadenas de sring anteriores
% eliminando los espacios entre palabras, dando como resultado dos matrices
% cell
    strINT=split(formatoINT);
    strUINT=split(formatoUINT);

% Los pasamos a formato String para poder trabajar con ellos
    tiposINT=string(strINT);
    tiposUINT=string(strUINT);

% Mediante el bucle for probaremos reiterativamente cual es el tipo de
% datos, de la imagen obteniendo 1 en caso afirmativo y 0 en caso negativo
    for i=1:4
         a=isa(imInput,tiposINT(i));
         b=isa(imInput,tiposUINT(i));
         nbits=8*2^(i-1);% Calculamos la variable nbits 

           if(a==1)%En caso de que "a" sea true (1), pararemos el bucle
               break;
           end
           if(b==1)%En caso de que "b" sea true (1), pararemos el bucle
               break;
           end
           % Solo puede ser verdadero uno de los dos parámetros
    end
%% PASO 2:calculamos los parámetros de la ventana

 low_in=c-W/2 ;% Inicio
 high_in=c+W/2 ;% Fin
 low_in_norm= (low_in)/2^nbits; % Inicio normalizado
 high_in_norm= (high_in)/2^nbits; % Fin normalizado
   
 imOutput = imadjust(imInput,[low_in_norm high_in_norm]);
 figure, imshow(imOutput, [])
 
end
    
   
    
    
    
    
    
    