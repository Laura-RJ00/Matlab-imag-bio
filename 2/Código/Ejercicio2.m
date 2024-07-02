im = imread('cells.bmp','bmp');
imInput_R = im(:,:,1);
[imOutput, histOutput] = autorange(imInput_R, 0.25);