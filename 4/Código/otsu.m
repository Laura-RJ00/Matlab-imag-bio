function [threshold] = otsu(imInput)
L=256;

P=imhist(imInput,L)/numel(imInput);

var_max=0;

q(1)= P(1);
u(1)= 0;
ut(1)=0;
    for a=2:255
        ut= ut + a* P(a);
    end
var_inter_clase= ((ut*q-u)^2)/(q*(1-q));
        for i=2:255
            q(i)=q(i-1)+P(i);
            u(i)=u(i-1)+i*P(i);
            
            var_inter_clase=((ut*q(i)-u(i))^2)/(q(i)*(1-q(i)));
                
                
            if var_inter_clase> var_max
                var_max= var_inter_clase;
                threshold = i;
                
            end
            
        end
end