clc;
clear;
close all;


I1 = imread('img (1).png');

[M1 N1 C1]= size(I1);
numberPixels = M1*N1;
numberIntensities = 256;

if(C1 > 1)
    I1 = rgb2gray(I1);
end

Ieq = I1;


figure();
subplot(2,3,1);
imshow(I1);

subplot(2,3,2);
imhist(I1);
[counts binLocations]=imhist(I1);
histPdf = cumsum(counts);
subplot(2,3,3);
plot(histPdf);

%equalization
pixelsProb = counts/numberPixels;
equalizationTable = zeros(numberIntensities,1);

for i=1:numberIntensities
    for j=1:i
        equalizationTable(i) = equalizationTable(i) + pixelsProb(j);
    end
    equalizationTable(i) = equalizationTable(i)*(numberIntensities-1);
end

equalizationTable = round(equalizationTable);

for i=1:M1
    for j=1:N1
        Ieq(i,j) = equalizationTable(Ieq(i,j)+1);
    end
end

subplot(2,3,4);
imshow(Ieq);

subplot(2,3,5);
imhist(Ieq);

[counts binLocations]=imhist(Ieq);
histPdf = cumsum(counts);
subplot(2,3,6);
plot(histPdf);

figure()
subplot(2,2,1)
J = histeq(I1)
F = histeq(I1,counts)
imshow(J)
subplot(2,2,2)
imshow(F)

subplot(2,2,3)
plot(cumsum(imhist(J)))

subplot(2,2,4)
plot(cumsum(imhist(F)))





