clc;
clear;
close all;
%image = imread('img/2.jpg');
%image = imread('AmostrasDigitais/db4a2004/1_5.tif');
image =  imread('AmostrasDigitais/db2a2000/1_2.tif');
[nRow nCol nChannels] = size(image);

if(nChannels > 1)
    image=rgb2gray(image);
end
figure()
imshow(image);

zeroPadding = 1;
blockSize = 32;
currentRow = 1;
currentCol = 1;
numberBlocks = 0;
imageFiltred2 = image;
numIter = 1;

for i=1:numIter
cells = createCells(image,nRow,nCol, blockSize,zeroPadding);
[cellRow cellCol] = size(cells);
overlapCells = createOverlapCells(image, blockSize,cells,cellRow,cellCol);
overlapCells = computeBlockQuality(overlapCells,cellRow,cellCol);
overlapCells = spectralFiltering(overlapCells);
overlapCells2 = returnToSpatialDomain(overlapCells);
cells2 = unOverlapBlocks(overlapCells2, blockSize,1);
imageFiltred = blocks2Image(cells2, nRow, nCol);
%figure()
%imshow(imageFiltred)
image = imageFiltred;
%if(i > 1)
%    imageFiltred2 = imageFiltred2 + imageFiltred;
%else
%    imageFiltred2 = imageFiltred;
%end
%image = imageFiltred2;
%imageFiltred2 = imageFiltred;
%figure()
%imshow(imageFiltred2)
i
end

% a = sumImage{1};
% 
% 
% for i=1:numIter-1
%     diff{i} = double(sumImage{1}) - double(sumImage{(i+1)});
% end
%     
% for k=1:numIter-1
%         for row=1:size(diff{1},1)
%              for col=1:size(diff{1},2)
%                  if(diff{k}(row,col) > 127 )
%                   54   a(row,col) = 0;
%                  end
%              end
%         end
%         figure()
%         imshow(a);
% end
% 
%  figure()
%  imshow(a);
%  figure()
%  imshow(imageFiltred)



