function vesselMask = vesselDetection(imInput,extMask,tamFilt)

% Componente verde (Paso 1)
imInput= imInput(:,:,2);

% Filtro mediana (Paso 2)
im_filtrada = medfilt2(imInput,[tamFilt tamFilt]);

% Top_hat dual (Paso 3)
s=strel('square',5);
imCierre=imclose(im_filtrada,s);
imVessel= (double(imCierre)-double(im_filtrada));

% Paso 4
imOut= buscalineas(imVessel,12,31);
im_result=imreconstruct(imOut,imVessel);


% Paso 5
im_Mask=immultiply(extMask,im_result);

% Paso 6
im_Mask =uint8(im_Mask);

umbral = otsu(im_Mask);

vesselMask= im_Mask < umbral;

% Imágenes
figure ('Name','vesselDetection')
subplot(2,2,1),imshow(imInput), title('Componente verde')
subplot(2,2,2),imshow(im_filtrada), title('Imagen filtrada con un filtro de mediana')
subplot(2,2,3),imshow(im_result), title('Imagen reconstruida')
subplot(2,2,4), imshow(vesselMask), title('Vasos sanguíneos')


end