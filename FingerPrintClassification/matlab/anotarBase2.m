function [contadores]=anotarBase2(amostras,contadores,windowSize)
    
    [rowBlocks colBlocks] = size(amostras);
    iter = 1;
    iterMax = rowBlocks*colBlocks
    str = sprintf('Pressione: \n 1 -> classe 1 \n 2 -> classe 2 \n 9 -> sair');
    disp(str);
    while(iter <= iterMax)
        randRow = round(rand(1)*(rowBlocks-1))+1;
        randCol = round(rand(1)*(colBlocks-1))+1;
        strPos = [randRow randCol];
        disp(strPos);
        figure(2)
        imshow(amostras{randRow,randCol});
        hold on
        plot((windowSize/2)+1,(windowSize/2)+1,'red*');
       
        opcao = input('pressione algo: ');
        
        if(opcao == 1)
            classe = 'classe11\'
            numero = num2str(contadores(1)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(amostras{randRow,randCol},filePath);
            contadores(1) = contadores(1) + 1;
        end
        
        if(opcao == 2)
            classe = 'classe22\'
            numero = num2str(contadores(2)); 
            extensao = '.jpg'
            filePath = strcat(classe,numero,extensao)
            imwrite(amostras{randRow,randCol},filePath);
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

end