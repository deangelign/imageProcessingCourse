clc;
clear;
close all;

HB = ones(128,128);

a = -1/2;
for i=1:128
    for j=1:128
    
        fr = 1;
        M = 4;
        fr_sqare = fr^2;
        v = (i-65);
        u = (j-65);
        d = sqrt((v^2) + (u^2));
        d_square = d^2;
        
        
        num = (-1/2)*d_square;
        denshift = (fr+M)^2;
        den = (fr)^2;
        
        factoShift = exp(num/denshift);
        factor = exp(num/den);
        
        HB(i,j) = factoShift*(1 - factor);
    end
end

figure()
imshow(mat2gray(HB));