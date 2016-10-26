clc;
%clear;
close all;

image = imread('AmostrasDigitais\db2a2000\1_4.tif');
[nrows ncols] = size(image);
[image] = histeq(image);

[nRow nCol]= size(image);
imageSegmented = image;
cellSize = 8;
blockSize = 16;
blocksSize = blockSize*2; 
limitBlock = blocksSize/8;
descriptorType = 1;

%pesos = rand(1,325);

for i=2:8:nRow-(cellSize*4)
    for j=2:8:nCol-(cellSize*4)
        blocks = image(i-1:i+(cellSize*4),j-1:j+(cellSize*4));
        figure(1)
        imshow(blocks)
        x  = [extractHOGFeatures(blocks,'CellSize',[8 8]) 1];
        w_chapeu = (pesos * x');
        w_chapeu = sign(w_chapeu);
        if(w_chapeu <= 0)
            w_chapeu = -1;
        end
        if(i < 200)
        %if(i < 160)
            opcao = 2;
            %opcao = 1;
        else
            %opcao = 9;
            opcao = input('pressione algo: ');
        end
        
        if opcao == 1;
            d = 1;
            e = d - w_chapeu;
            n = 1*(10^-3);
            pesos = pesos + (n*e*x);
           
        elseif opcao == 2
            d = -1;
            e = d - w_chapeu;
            n = 1*(10^-3);
            pesos = pesos + (n*e*x);
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