function imOut = buscalineas(imInput, N, tam)
% imInput: imagen de entrada (binaria)

h=round(180/(N-1)); 

    for i=1:h:180
    linea = strel('line',tam,i-1);
    imApertura=imopen(imInput,linea);
    I(:,:,i)=imApertura;
    end  
%     for j=1:size(I,1)
%         for k= 1:size(I,2)
%           imOut(j,k)= max(I(j,k,:));
%         end
%     end

    imOut=max(I,[],3);
    figure('Name', 'Buscalíneas'),imshow(imOut); title ('Buscalíneas')
    
end