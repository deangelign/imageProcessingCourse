clc;
close all;
clear;

image = imread('lena_gray.jpg');
[nrow,ncol,nc]= size(image);


k = 128;
m = 8; %5-40;
seRadius = 0; %1 or 1.5
colopt = 'median';



%[l, Am, Sp, d] = slic(I, k, m, seRadius, colopt, mw)
[l, Am, Sp, d] = slic(image, k, m, seRadius, colopt);
labelBorders = uint8(zeros(nrow,ncol));


%Lrgb = label2rgb(Am);
%figure, imshow(Lrgb);
for i=1:nrow
    for j=1:ncol
        
        if(i+1 < nrow)
            labelBorders(i+1,j) = abs(sign(l(i+1,j)- l(i,j)))*255;
        end
        
        
        
        if(j+1 < ncol)
            labelBorders(i,j+1) = abs(sign(l(i,j+1)- l(i,j)))*255;
        end
        
        
    end
end

figure, imshow(labelBorders);
teste = image(:,:,1) + (labelBorders);
teste = image(:,:,2) + (labelBorders);
teste = image(:,:,3) + (labelBorders);
figure, imshow(teste);
figure, imshow(image);