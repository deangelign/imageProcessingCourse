clc;
%clear;
close all;


image = imread('AmostrasDigitais\db3a2000\1_2.tif');
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
        %figure(1)
        %imshow(blocks)
        %x  = [extractHOGFeatures(blocks) 1];
        %x = [MyextractLBPFeatures(blocks,[8 8]) 1];
        x = [MyextractCentristFeatures(blocks,[8 8]) 1];
        w_chapeu = (pesos * x');
        w_chapeu = sign(w_chapeu);
        if(w_chapeu <= 0)
            w_chapeu = -1;
        end
        
        if(w_chapeu > 0)
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 0;
        else
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 255;
        end
        %          figure(2)
        %          imshow(imageSegmented);
        %          if(mod(iter,8) == 0)
        %              numS = num2str(iter);
        %              filePath = strcat(folder,numS,extension);
        %              imageSegmentedResized = imresize(imageSegmented,0.25);
        %              imwrite(imageSegmentedResized,filePath);
        %          end
        %          iter = iter + 1;
    end
end
figure(2)
imshow(imageSegmented);
%imwrite(imageSegmented,'resultados/CEN5.jpg');
