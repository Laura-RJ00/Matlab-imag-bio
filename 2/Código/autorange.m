function [imOutput, histOutput] = autorange(imInput, P)
% imInput: imagen de gris a la que se le desea aumentar su contraste.
% P: Porcentaje (en tanto por 100) de los píxeles saturados a 0 y 255 
% (mismo valor para ambos casos).
% imOutput: imagen de gris de salida con el contraste mejorado.


% Por defecto si no se define la variable bins, esta toma el valor 256.
% Como queremos los rmin y rmax entre 0 y 255 tomaremos bins = 256
dist_probabilidad = imhist(imInput)/numel(imInput);
bar(dist_probabilidad);
histOutput(1)=dist_probabilidad(1);
    for i=1:255
        histOutput(i+1)=dist_probabilidad(i+1)+histOutput(i);
    end
 bar(histOutput)
 %% PASO 2: Calculamos rmin y rmax
 dist_r=abs(histOutput-P);
 dist_R=abs(histOutput-(1-P));
 dist_r_min=min(dist_r);
 dist_R_min=min(dist_R);
 rmin=find(dist_r==dist_r_min);
 rmax=find(dist_R==dist_R_min);
 
 %% PASO 3: Transformación de la intensidad
 
 w=rmax-rmin;
 c=(rmin+rmax)/2;
 
 imOutput = bright_contrast_adjust(imInput, w, c);
    
end


