function [imout] = segmentacion_disco(imin)

%% Componente roja
imr=imin(:,:,1);
%% Eliminar vasos
%Creamos un elemento estructurante
s=strel('square',30);
%Aplicamos un cierre
imc=imclose(imr,s);

%% Calculamos el gradiente 
% Aplicamos una dilatación
imd=imdilate(imc,s);
imc2=imclose(imc,s);
% Se obtiene el gradiente haciendo la diferencia entre la dilatación y el
% cierre de la imagen imc
img= imsubtract(imd,imc2);

%% Segmentamos emplenado watershed
imout=watershed(img);

%% Finalmente visualizamos la imagen 
figure ('Name','Segmentación de disco')
subplot(2,2,1),imshow(imr), title('Canal rojo')
subplot(2,2,2),imshow(imc), title('Eliminamos los vasos sanguíneos')
subplot(2,2,3),imshow(img), title('Gradiente de imc')
subplot(2,2,4), imshow(imout), title('Imagen segmentada')


end