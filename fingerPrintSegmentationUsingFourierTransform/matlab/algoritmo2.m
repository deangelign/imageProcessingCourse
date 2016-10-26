clc;
clear;
close all;

image =  imread('AmostrasDigitais/db2a2000/1_1.tif');
[nRow nCol nChannels] = size(image);

if(nChannels > 1)
    image=rgb2gray(image);
end


zeroPadding = 1;
blockSize = 16;
windowSize = blockSize*2;
currentRow = 1;
currentCol = 1;
numberBlocks = 0;

extendedImage = [image image image;image image image;image image image];


for i=1:10
blocks = createBlocks2(image,blockSize);
imageBlock = cell2mat(blocks);
%figure()
%imshow(imageBlock)
windows = createOverlapBlocks2(blocks,blockSize,windowSize);
windows = computeWindowsFFT(windows,blockSize);
windows = computeWindowNoDCSpectrum(windows);
windows = computeWindowRidge(windows,windowSize);
windows = computeWindowNP(windows);
windows = computeWindowsQuality2(windows);
windows.allBlocks = 0;
iter = 0;
    
    while(windows.allBlocks < 1)
   
    
    [windows,row,col] = spectralFiltering2(windows,windowSize);
    blocks = updateBlocks(blocks,blockSize,windows,row,col);
    %windows = updateOverlapBlocks2(blocks,blockSize,windowSize,windows,row,col);
    imageBlock = cell2mat(blocks);
    
    
%     if(mod(i,50)==0)
%         figure()
%         imshow(imageBlock)
%     end
    %i
    
    end
    figure()
    imshow(imageBlock)
    image = imageBlock
end
%windows.data = b;

% figure()
% a=cell2mat(b)
% imshow(a)
