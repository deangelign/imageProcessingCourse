function [cells] = createCells(image,numberRows,numberCols, blockSize,zeroPadding)
    A = image;
    numberCelVertical = floor(numberRows/blockSize);
    numberCelHorizontal = floor(numberCols/blockSize);

    reimenderCellSizeVertical = mod(numberRows,blockSize);
    reimenderCellSizeHorizontal = mod(numberCols,blockSize);
    
    blockDimensionVertical = [];
    blockDimensionHorizontal = [];
    
    for i=1:numberCelVertical
        blockDimensionVertical = [blockDimensionVertical blockSize];
    end
    
    for i=1:numberCelHorizontal
        blockDimensionHorizontal = [blockDimensionHorizontal blockSize];
    end
    
    if(zeroPadding == 1)
        if(reimenderCellSizeVertical > 0)
            extraRows = blockSize-reimenderCellSizeVertical;
            blockDimensionVertical = [blockDimensionVertical blockSize];
        else
            extraRows = 0;
            blockDimensionVertical = [blockDimensionVertical];
        end
        
        A = [A;zeros(extraRows,numberCols)];
        
        if(reimenderCellSizeHorizontal > 0)
            extraCols = blockSize-reimenderCellSizeHorizontal;
            blockDimensionHorizontal = [blockDimensionHorizontal blockSize];
        else
            extraCols = 0;
            blockDimensionHorizontal = [blockDimensionHorizontal];
        end
        A = [A zeros(numberRows+extraRows,extraCols)];
       
        
        
    else
        blockDimensionVertical = [blockDimensionVertical reimenderCellSizeVertical];
        blockDimensionHorizontal = [blockDimensionHorizontal reimenderCellSizeHorizontal];
    end
    cells = mat2cell(A, blockDimensionVertical,blockDimensionHorizontal);
end