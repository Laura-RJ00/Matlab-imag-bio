%% Ejercicio 1
close all
clear all
imInput1=imread('cells.tif', 'tif');
imInput2=imread('dark.bmp', 'bmp');
umbral_1 = otsu(imInput1)
umbral_2 = otsu(imInput2)
o1= graythresh(imInput1)*255; % hay que multiplicar el valor del gray por 256 
% o 255 porqure el valor que da está entre 0 y 1
o2= graythresh(imInput2)*255;
C= cell(3,2);
C(1,:)={['umbral con otsu'] ['umbral con nuestro graythresh']};
C(2:3,:)= {umbral_1 o1;umbral_2 o2};
disp(C)

%% Ejercicio 3
close all
clear all
imInput= imread('circuit.bmp', 'bmp');
bordes_imInput=edge(imInput,'canny');
imOut = buscalineas(bordes_imInput, 5, 25);
top_hat= (double(bordes_imInput)-double(imOut));

figure  ('Name','Ejercicio 3')
subplot(2,2,1),imshow(imInput);title('Imagen original');
subplot(2,2,2),imshow(imOut); title('Resultado buscalíneas');
subplot(2,2,3),imshow(bordes_imInput);title('Contorno: Canny');
subplot(2,2,4),imshow(top_hat); title('Top-hat');

%% Ejercicio 5
close all
clear all
imInput=imread('fundusHealthy.tif', 'tif');
extMask=imread('extMask.tif', 'tif');
tamFilt= 3;
vesselMask = vesselDetection(imInput,extMask,tamFilt);






