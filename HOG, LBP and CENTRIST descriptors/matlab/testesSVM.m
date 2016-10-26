clc;
close all;

% Make class predictions using the test features.
clc;
%clear;
close all;


image = imread('AmostrasDigitais\db2a2000\1_5.tif');
[image] = histeq(image);

[nRow nCol]= size(image);
imageSegmented = image;
cellSize = 8;
blockSize = 16;
blocksSize = blockSize*2;
limitBlock = blocksSize/8;
descriptorType = 1;
iter = 0;
extension = '.jpg';
folder = 'animacao\'

for i=2:8:nRow-(cellSize*4)
    for j=2:8:nCol-(cellSize*4)
        blocks = image(i-1:i+(cellSize*4),j-1:j+(cellSize*4));
        %x  = [extractHOGFeatures(blocks) 1];
        %w_chapeu = predict(classifierHOG, x);
        
        %x = [MyextractLBPFeatures(blocks,[8 8]) 1];
        %w_chapeu = predict(classifierLBP, x);
        
        x = [MyextractCentristFeatures(blocks,[8 8]) 1];
        w_chapeu = predict(classifierCEN, x);
        
        if(w_chapeu > 0)
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 0;
        else
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 255;
        end
%         figure(2)
%         imshow(imageSegmented);
%         if(mod(iter,8) == 0)
%             numS = num2str(iter);
%             filePath = strcat(folder,numS,extension);
%             imageSegmentedResized = imresize(imageSegmented,0.25);
%             imwrite(imageSegmentedResized,filePath);
%         end
%         iter = iter + 1;
    end
end
figure(2)
imshow(imageSegmented);

imwrite(imageSegmented,'resultados/SVMCEN5.jpg');
