clc;
%clear;
close all;

image = imread('AmostrasDigitais\db2a2000\1_4.tif');
[nrows ncols] = size(image);
[image] = histeq(image);
imageSegmented = image;
[nRow nCol]= size(image);

cellSize = 8;
blockSize = 16;
blocksSize = blockSize*2; 
limitBlock = blocksSize/8;
descriptorType = 1;

for i=2:8:nRow-(cellSize*4)
    for j=2:8:nCol-(cellSize*4)
        blocks = image(i-1:i+(cellSize*4),j-1:j+(cellSize*4));
        figure(1)
        imshow(blocks)
        x  = [computeFeatureVector(blocks,descriptorType) 1];
        w_chapeu = (pesos * x');
        w_chapeu = sign(w_chapeu);
        if(w_chapeu <= 0)
            w_chapeu = -1;
        end
         if(i < 200)
             opcao = 2;
         else
             %opcao = 9;
            opcao = input('pressione algo: ');
         end
        
        x  = [computeFeatureVector(blocks,descriptorType) 1];
        w_chapeu = (pesos * x');
        w_chapeu = sign(w_chapeu);
        
        if opcao == 1;
            classe = 'classe1\'
            numero = num2str(contadores(1)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(blocks,filePath);
            contadores(1) = contadores(1) + 1;
           
        elseif opcao == 2
            classe = 'classe2\'
            numero = num2str(contadores(2)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(blocks,filePath);
            contadores(2) = contadores(2) + 1;
            
        elseif opcao == 9
            break;
            
        else
            if(w_chapeu > 0)
                imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 0;
            else
                imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 255;
            end
            figure(2)
            imshow(imageSegmented)
        
            continue;
        end
        
        if(w_chapeu > 0)
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 0;
        else
            imageSegmented(i+(cellSize):i+(cellSize*3)-1,j+(cellSize):j+(cellSize*3)-1) = 255;
        end
        figure(2)
        imshow(imageSegmented)
        
    end
    if opcao == 9
        break;
    end
end