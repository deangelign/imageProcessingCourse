function [blocksOverlap] = circularGaussianBandPassFilter(blocksOverlap,blockRow,blockCol)
    [row col] = size(blocksOverlap.data{blockRow,blockCol});
   
    for i=1:row
        for j=1:col
            
            v = (i-blocksOverlap.u0)^2;
            u = (j-blocksOverlap.v0)^2;
            D_square = u+v;
            
            num = (-1/2)*D_square;
            denshift = (blocksOverlap.fr{blockRow,blockCol} + blocksOverlap.M)^2;
            den = (blocksOverlap.fr{blockRow,blockCol} )^2;
            
            factoShift = exp(num/denshift);
            factor = exp(num/den);
            
            blocksOverlap.HB{blockRow,blockCol}(i,j) = factoShift*(1 - factor);
        end
    end
    
    %figure()
    %imshow( mat2gray((blocksOverlap.HB{blockRow,blockCol})) )
    
end