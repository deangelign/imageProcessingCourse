clc;
clear;
close all;


I1 = imread('img (2).jpg');
I2 = imread('img (1).png');
[M1 N1 c1] = size(I1); 
[M2 N2 c2] = size(I2);

numberPixels1 = M1*N1;
numberPixels2 = M2*N2;
numberIntensities = 256;

if c1>1
    I1 = rgb2gray(I1);
end

if c2>2
    I2 = rgb2gray(I2);
end

[counts1 binLocations1]=imhist(I1);
pixelsProb1 = counts1/numberPixels1;

[counts2 binLocations2]=imhist(I2);
pixelsProb2 = counts2/numberPixels2;

cdf1 = cumsum(pixelsProb1);
cdf2 = cumsum(pixelsProb2);


equalizationTable1 = zeros(numberIntensities,2);
equalizationTable1(:,1) = [0:255];

equalizationTable2 = zeros(numberIntensities,2);
equalizationTable2(:,1) = [0:255];

%tableMatch = zeros(numberIntensities,2);
%tableMatch(:,1) = [0:255];

for i=1:numberIntensities
    for j=1:i
        equalizationTable1(i,2) = equalizationTable1(i,2) + pixelsProb1(j);
        equalizationTable2(i,2) = equalizationTable2(i,2) + pixelsProb2(j);
    end
end

equalizationTable1(:,2) = equalizationTable1(:,2).*(numberIntensities-1);
equalizationTable2(:,2) = equalizationTable2(:,2).*(numberIntensities-1);

tableTotal = [equalizationTable1 equalizationTable2];

tableMatch = []

index1 = find(cdf1~=0, 1, 'first')
index2 = find(cdf2~=0, 1, 'first')
iterMax = 256*256;
iter = 0

while iter < iterMax
        ac1 = cdf1(index1)
        ac2 = cdf2(index2)
        diff = ac1 - ac2
        if diff < 0
            tableMatch = [tableMatch; [index1 index2]];
            if index1 < 256 
                index1 = index1+1;
            end
        else
            tableMatch = [tableMatch; [index1 index2]];
            if index2 < 256
                index2 = index2  + 1;
            end
            
            if index1 < 256 
                index1 = index1+1;
            end
            
        end
        
        if(index1 == 256 && index2 == 256)
            break
        end
        
        iter = iter + 1;
end
