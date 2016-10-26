clc;
%clear;
close all;

image = imread('AmostrasDigitais\db2a2000\1_5.tif');
%imshow(image);
[nrows ncols] = size(image);

startRow = 2;
startCol = 2;
endRow = nrows-1;
endCol = ncols-1;
cellSize = 8;
blockSize = 16;

numberCellsV = (endRow-startRow)/cellSize;
numberCellsC = (endCol-startCol)/cellSize;


str = sprintf('Pressione: \n 1 -> classe 1 \n 2 -> classe 2 \n 9 -> sair');
disp(str);
iter = 1;
iterMax = 10^5;
%contadores = [0 0];

while(iter <= iterMax)
    randomRow = round((rand(1)*(numberCellsV-2))*cellSize)+startRow;
    randomCol = round((rand(1)*(numberCellsC-2))*cellSize)+startCol;
    block = image(randomRow-1:randomRow+blockSize,randomCol-1:randomCol+blockSize);
    strPos = [randomRow randomCol];
    disp(strPos);
    figure(2)
    imshow(block);
    opcao = input('pressione algo: ');
    if(opcao == 1)
            classe = 'classe1\'
            numero = num2str(contadores(1)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(block,filePath);
            contadores(1) = contadores(1) + 1;
    end
   
    if(opcao == 2)
            classe = 'classe2\'
            numero = num2str(contadores(2)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(block,filePath);
            contadores(2) = contadores(2) + 1;
    end
    
    if(opcao == 9)
            disp('saindo');
            break;
    end
    
    if(opcao ~= 9 || opcao ~= 1 || opcao ~= 2)
            disp('opcao invalida!');
            str = sprintf('Pressione: \n 1 -> classe 1 \n 2 -> classe 2 \n 9 -> sair');
            disp(str);
    end
end









