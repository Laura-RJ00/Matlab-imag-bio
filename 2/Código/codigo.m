%Ya tenemos el script y ahora llamamos a la función con los distintpos
%valores de W y de c que nos dan.
imDicom = dicomread('breast');
[imOutput1] = bright_contrast_adjust(imDicom, 580, 2700);
[imOutput2] = bright_contrast_adjust(imDicom, 1200, 2890);
[imOutput3] = bright_contrast_adjust(imDicom, 100, 3700);


contrast=figure;
imshow('breast');
imcontrast(contrast)

imwrite(imOutput1,'breast1.png','png');
imwrite(imOutput2,'breast2.png','png');
imwrite(imOutput3,'breast3.png','png');
