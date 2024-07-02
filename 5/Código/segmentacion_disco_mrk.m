function imout = segmentacion_disco_mrk(imin)

%% Componente roja
imr=imin(:,:,1);
%% Eliminar vasos
%Creamos un elemento estructurante
s=strel('square',15);
%Aplicamos un cierre
imc=imclose(imr,s);

%% Umbralizamos
imc_umbral= imc > 170;

%% Buscamos el objeto más grande
%imBW=bwconncomp(imc_umbral);
imBW=bwlabel(imc_umbral);
imAreas=regionprops(imBW,'Area');
Areas=[imAreas.Area];
area_max=0;
    for i=1:size(Areas,2)
        
        if Areas(i)> area_max
                area_max= Areas(i);
                etiqueta = i;
        end
    end
    
    for k=1:size(imBW,1)
        for j=1:size(imBW,2)
            if imBW(k,j)~= etiqueta
                imBW(k,j)= 0;
            
            else
                imBW(k,j)= 255; 
             end
        end
    end
   
imu=imBW;
%% Generaremos un marcador interno 
% Obtenemos el negativo de imu
imu_N= (255 - imu);
figure('Name','imu_N')
imshow(imu_N)
% calculamos la distancia al borde
im_D=bwdist(imu_N);
figure('Name','imu_D')
imshow(mat2gray(im_D))

% Buscamos el pixel máximo de la imagen
ma=max(max(im_D));
[x,y]=find(im_D==ma);
imPixel=zeros(size(imBW,1),size(imBW,2));
imPixel(x,y)=1;


figure('Name','imPixel')
imshow(imPixel)


%%  Marcador externo
area=Areas(etiqueta);
radio=sqrt(area/pi);

bwout=circunferencia(imPixel,radio);
imMarc= bwout +imPixel;
figure('Name','bwOut')
imshow(bwout)

figure('Name','Marcador defintivo')
imshow(imMarc)

%% Calculamos el gradiente 
% Aplicamos una dilatación
imd=imdilate(imc,s);
imc2=imclose(imc,s);
% Se obtiene el gradiente haciendo la diferencia entre la dilatación y el
% cierre de la imagen imc
img= imsubtract(imd,imc2);
% Imponemos como mínimos los marcadores anteriores
img2=imimposemin(img,imMarc);
figure('Name','gradientes')
subplot(1,2,1),imshow(img)
subplot(1,2,2),imshow(img2)

%% Segmentamos empleando watershed
imout=watershed(img2);
figure ('Name','Segmentación de disco')
subplot(2,2,1),imshow(imr), title('Canal rojo')
subplot(2,2,2),imshow(imc), title('Eliminamos los vasos sanguíneos')
subplot(2,2,3),imshow(img), title('Gradiente de imc')
subplot(2,2,4), imshow(imout), title('Imagen segmentada')

end