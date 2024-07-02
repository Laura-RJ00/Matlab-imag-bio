%% Ejercicio 1
close all
clear all
imin=imread('fondo_ojo.jpg','jpg');
[imout] = segmentacion_disco(imin);
figure ('Name', 'Imagen segmentada')
imOut=label2rgb(imout);
imshow(imOut)

%% Ejercicio 2
close all
clear all
imin=imread('fondo_ojo.jpg','jpg');
[imout] = segmentacion_disco_mrk(imin);

figure ('Name', 'Imagen segmentada')
imOut=label2rgb(imout);
imshow(imOut)
%% Ejercicio 4
close all
clear all
imInput=imread('prostate.png','png');
num_clusters=5;
nuclei_mask = detectingNuclei(imInput, num_clusters);

figure 
suptitle('Resultados Ejercicio 4')
subplot(1,3,1), imshow(imInput), title('original')
subplot(1,3,2), imshow(nuclei_mask), title('nuclei mask')
subplot(1,3,3),figureBlend(imInput,nuclei_mask,0.5,'red'),title ('Imagen con máscara superpuesta')