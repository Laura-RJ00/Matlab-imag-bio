function [resultado]= filtrar(imagen,kernel)

[m,n]=size(imagen);
[m1,n1]=size(kernel);
radio=floor(m1/2);

for i= 1:m
   for j=1:n
       a=0;
       for i1= -radio:radio
           for j1= -radio:radio
                ni= i +i1;
                nj= j +j1;
                if(ni<1) continue;end;
                if(nj<1) continue;end;
                if(ni>m) continue;end;
                if(nj>n) continue;end;
                a=a+imagen(ni,nj)* kernel(i1+radio+1,j1+radio+1);          
           end
       end
       resultado(i,j)= a; 
   end
   
end