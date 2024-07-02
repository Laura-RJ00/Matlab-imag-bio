% Creamos 
A = rand(3);
B = rand(3);
C = conv2(A,B);
C1 = conv2(A,B,'same') ;% cogemos la parte central de la matriz de convolucion
tic; C1 = conv2(A,B,'same'); t1=toc % el comando tic toc nois da el tiempo que le cuesta realoizar al programa una operación
% Comprobamos la npropiedad conmutativa
D = conv2(B,A);
C==D % se compara y nos da true (excepto algunos valores pero es or los decimales)
%%
tic
pm=4;
pn=4;
A(pm,pn)=0;% meto una fila y columna de ceros
B(pm,pn)=0; % idem A CEROPADDING al calcular la transformada rapida de fourier la dimensión debe ser potencia de 2
C2=ifft2(fft2(A).*fft2(B)); % convolucionar porque multiplicar en frecuencia es convolucionar en continuo
C2=C2(2:end,2:end);
t2=toc; % Deshacemos el ceropadding que hempos añadido, por la estructura de la TF estas entradas de los ceros se añaden al raves (1ra columna y 1ra fila)

% Comparando t1= 4.267000000000000e-04 y t2= 0.0103 vemos que convolucionar
% direct5amente es mucho más rapido que hacer TF y después la ITF (¿pero 
% porque es más lento? porque fft + ceropadding tien un valor cte pero slidding aumenta exponenciamente el tiempo de computación, solo es más rápida cuando covolucionamos matrices de dimensio0nes pequeñas)
%%
A1 = rand(256);
for i=1:128
B1 = rand(i);
% sliding window
tic
C1 = conv2(A1,B1,'same'); % Cs is the same size as A: 3-by-3
t1(i)=toc;
% FFT
tic
C2=FFTconv2(A1,B1); % Automatizar lo de poner cero padding cuando la matriz no es potencia de 2
t2(i)=toc;
end
%clc
plot(t1)
hold on
plot(t2,'r')
legend('Sliding','FFT')
%%
ima=imread('T1axial.png'); % leemos una imagen
ima=double(ima(:,:,1)); % lo pasamos a double para po9der trabajar hasta con factores de 10 elevado a -13 con int solo podriamos hasta 10 elevado a -2% leemos solo el canal 1
colormap(gray);
subplot(2,2,1),imagesc(ima); % visualizamos la imagen

tam=55;
%Normalizar los kernels
h1=ones(1,tam)/tam; % 1x55
h2=ones(tam,1)/tam; % 55x1
tic

imah=conv2(ima,h1,'same');
fima1=conv2(imah,h2,'same');
t1=toc % tiempo en hacer la convolucion con kernels separables
h3=ones(tam,tam)/(tam*tam);
tic
fima2=conv2(ima,h3,'same');
t2=toc % tiempo nen hacer la convoolucion con uhn kernel entero
subplot(2,2,2),imagesc(imah);
subplot(2,2,3),imagesc(fima1); 
subplot(2,2,4),imagesc(fima2);
%comprueba las diferencias --> vemos que visulamente la difrencia entre
%fima1 (kernels separqables) y fima2 (kernel entero) es mínima y no se
%aprecia
figure 
imagesc(fima2-fima1) % Es la diferencia entre obtener la imagen mediante kernbels sepoarados o juntos, es decir es el error que tenemos de uno a otro)
dif=mean2(abs(fima1-fima2)) % para cuantificar este error obtenemos el valor y vmeos que tiene un factor de 10 a la -13 por lo que no es significativo

% Comparando tiempos vemos que con los separados es mucho más rapido que
% con el kernel conjunto con un factor de 20

%%
ima=imread('ojo.jpg');
ima=rgb2gray(ima);
colormap(gray);
imagesc(ima);
% ejemplo de aplicación de un filtro gaussiano
h=fspecial('gaussian')
fima=imfilter(ima,h,'symmetric');
figure
colormap(gray);
imagesc(fima);
% ejemplo de un filtro de bordes
h=fspecial('prewitt')
fima1=imfilter(ima,h);
fima2=imfilter(ima,h');
figure
colormap(gray);
imagesc(abs(fima1)+abs(fima2))

h=fspecial('gaussian',2,5)
fima=imfilter(ima,h,'symmetric');
figure
colormap(gray);
imagesc(fima);

h=fspecial('gaussian',5,4)
fima=imfilter(ima,h,'symmetric');
figure
colormap(gray);
imagesc(fima);

%%

% edge function (binary output)
e1=edge(ima,'sobel');
e2=edge(ima,'prewitt');
e3=edge(ima,'roberts');
e4=edge(ima,'canny');
colormap(gray);
figure
subplot(2,2,1),imagesc(e1);
subplot(2,2,2),imagesc(e2);
subplot(2,2,3),imagesc(e3);
subplot(2,2,4),imagesc(e4);

e1=edge(ima,'sobel',0.5);
e2=edge(ima,'prewitt',0.2);
e3=edge(ima,'roberts',0.7);
e4=edge(ima,'canny',0.5);
colormap(gray);
figure
subplot(2,2,1),imagesc(e1);
subplot(2,2,2),imagesc(e2);
subplot(2,2,3),imagesc(e3);
subplot(2,2,4),imagesc(e4);
%%
h=fspecial('laplacian')
fima=imfilter(ima,h,'symmetric');
alfa=1;
sima=ima-alfa*fima;
figure
subplot(1,2,1),imagesc(ima),title('original')
subplot(1,2,2),imagesc(sima),title('sharpened')

h=fspecial('laplacian',0.6)
fima=imfilter(ima,h,'symmetric');
alfa=6;
sima=ima-alfa*fima;
figure
subplot(1,2,1),imagesc(ima),title('original')
subplot(1,2,2),imagesc(sima),title('sharpened')


