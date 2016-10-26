clc;
close all;
clear;

%I = imread('lena_gray.jpg');
I2 = imread('lago.jpg');
I =I2;
[nRows,nCols,nChannels] = size(I);

if(nChannels > 1)
    I = rgb2gray(I);
end
nRows = 256;
nCols = 256;
I = imresize(I,[256 256]);


se = strel(ones(3,3));
I_MG = imdilate(I,se) - imerode(I,se);
%[I_MG,~]  = imgradient(image.originalData);
%I_MG = uint8(I_MG);
k = 4;
image.seeds = zeros(nRows,nCols);
labels = uint8(zeros(nRows,nCols,3));
numberSPH = 8;
numberSPV = 8;
stepRow = nRows/numberSPV;
stepCol = nCols/numberSPH;
startRow = stepRow/2;
startCol = stepCol/2;
cellsCentroidRows = startRow:stepRow:nRows;
cellsCentroidCols = startCol:stepCol:nCols;
matrixCentroid = [];

for i=1:size(cellsCentroidRows,2)
    for j=1:size(cellsCentroidCols,2)
        
        matrixCentroid = [matrixCentroid; [cellsCentroidRows(i) cellsCentroidCols(j)]];
        
    end
end

matrixCentroidSize = size(matrixCentroid,1);

labelTable = [];
a = 1;
b = 1;
for i=cellsCentroidRows;
    for j=cellsCentroidCols
        value1 = round(rand(1,1)*255);
        value2 = round(rand(1,1)*255);
        value3 = round(rand(1,1)*255);
        labelTable = [labelTable;value1 value2 value3];
        
        labels(i-(stepRow/2)+1:i+(stepRow/2),j-(stepCol/2)+1:j+(stepCol/2),1) = value1;
        labels(i-(stepRow/2)+1:i+(stepRow/2),j-(stepCol/2)+1:j+(stepCol/2)-1,2) = value2;
        labels(i-(stepRow/2)+1:i+(stepRow/2),j-(stepCol/2)+1:j+(stepCol/2)-1,3) = value3;
        
        cellsData{a,b} = I(i-(stepRow/2)+1:i+(stepRow/2),j-(stepCol/2)+1:j+(stepCol/2));
        cellsMG{a,b} = I_MG(i-(stepRow/2)+1:i+(stepRow/2),j-(stepCol/2)+1:j+(stepCol/2));
        b = b +1;
    end
    b = 1;
    a = a + 1;
end



[cRows cCols]= size(cellsMG);

for i=1:cRows
    for j=1:cCols
        %local mins
        [blockRow,blockCol]=size(cellsMG{i,j});
        cellsMGM{i,j} = zeros(blockRow,blockCol);
        maxDiffSoFar = -inf;
        block = double(cellsMG{i,j});
        
        
        globalMinimumCoord = [];
        maxVolume = -inf;
        for ii=2:blockRow-1
            for jj=2:blockCol-1
                
                vec = block(ii-1:ii+1,jj-1:jj+1);
                diff = vec(:) - block(ii,jj);
                numberAbove = diff(diff>=0);
                
                if (size(numberAbove,1) == 9)
                    if(ii == 11 && jj == 13)
                        disp('');
                    end
                    volume = 0;
                    [volume,minHeight,visited] = computeVolume(block,ii,jj,[1 stepRow],0,inf,[]);
                    volume = size(visited,1)*(minHeight-block(ii,jj));
                    %if min(numberAbove) >  maxDiffSoFar
                    %globalMinimumCoord = [ii jj];
                    %maxDiffSoFar = min(numberAbove);
                    %end
                    if volume > maxVolume
                        globalMinimumCoord = [ii jj];
                        maxVolume = volume;
                    end
                    
                end
            end
        end
        %         if(size(globalMinimumCoord,1) == 0)
        %             block = cellsMG{i,j}(2:blockRow-1,2:blockCol-1);
        %             minValue = min(block(:));
        %             [r c]= find(block == minValue);
        %             globalMinimumCoord = [r(1)+1 c(1)+1];
        %         end
        %
        cellsMGMCoord{i,j} = globalMinimumCoord;
        blockPainted = double(cellsMGM{i,j});
        [visited,blockPainted,blockPainted] = paintMinimalRegion(block,globalMinimumCoord(1),globalMinimumCoord(2),[1 stepRow],[],blockPainted);
%         figure(1)
%         imshow(blockPainted)
        cellsMGM{i,j} = blockPainted;
        
    end
end

cellsMG_regularized = cellsMG;
center = [stepRow/2 stepCol/2];
for i=1:cRows
    for j=1:cCols
        [blockRow,blockCol]=size(cellsMG{i,j});
        for ii=1:blockRow
            for jj=1:blockCol
                dist = [ii jj] -  [center];
                d = norm(dist);
                cellsMG_regularized{i,j}(ii,jj) = cellsMG_regularized{i,j}(ii,jj) + (k*2*(d/stepRow));
            end
        end
        
    end
end

for i=1:nRows
    for j=1:nCols
        %local mins
        if(i>1 && i<nRows && j>1 && j<nCols)
            if I_MG(i,j) < I_MG(i-1,j-1) && I_MG(i,j) < I_MG(i-1,j) && I_MG(i,j) < I_MG(i-1,j+1)
                if  I_MG(i,j) < I_MG(i,j-1) && I_MG(i,j) < I_MG(i,j+1)
                    if I_MG(i,j) < I_MG(i+1,j-1) && I_MG(i,j) < I_MG(i+1,j) && I_MG(i,j) < I_MG(i+1,j+1)
                        image.seeds(i,j) = 255;
                    end
                end
            end
        end
    end
end
%
figure()
imshow(labels);
test = labels;
%
% test(:,:,1) = labels(:,:,1)+uint8(image.seeds);
% test(:,:,2) = labels(:,:,2)+uint8(image.seeds);
% test(:,:,3) = labels(:,:,3)+uint8(image.seeds);
%
% figure()
% imshow(test);
%  figure()
%  imshow(image.seeds);
%
%
markers = cell2mat(cellsMGM);
inputImage = cell2mat(cellsMG_regularized);
%
%
figure()
imshow(markers)
%
test(:,:,1) = labels(:,:,1)+uint8(markers);
test(:,:,2) = labels(:,:,2)+uint8(markers);
test(:,:,3) = labels(:,:,3)+uint8(markers);
figure()
imshow(test);

figure()
imshow(inputImage);


