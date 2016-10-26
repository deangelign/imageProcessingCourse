function [blocks] = createSamples(image,windowSize,opcao)
    
    [nRows nCols nC]= size(image);

    if nC > 1
        image = rgb2gray(image);
    end
    
    %overlapBlocks
    if(opcao == 1)
        a = 1;
        b = 1;
        myShift =  floor(windowSize/2);
        for i=1+myShift:nRows-myShift
            for j=1+myShift:nCols-myShift
                blocks{a,b} = image(i-myShift:i+myShift,j-myShift:j+myShift);
                b = b + 1;
            end
            a = a + 1;
            b = 1;
        end
    end
    
    %blocks
    if(opcao == 2)
        a = 1;
        b = 1;
        for i=1:windowSize:nRows - mod(nRows,windowSize)
            for j=1:windowSize:nCols - mod(nCols,windowSize)
                blocks{a,b} = image(i:i+windowSize-1,j:j+windowSize-1);
                b = b + 1;
            end
            a = a + 1;
            b = 1;
        end
        
    end
    
end
