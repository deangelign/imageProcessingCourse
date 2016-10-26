function [cells]=createCells(imageGradient,phaseAngle)
    cellSize = 8;
    [nRows, nCols]= size(imageGradient);
    rad2degree = (180/pi);
    for i=2:8:nRows-1
        for j=2:8:nCols-1
            
%             if(i+cellSize-1 > nRows || j+cellSize-1 > nCols)
%                 continue;                
%             end
%             
            cells{ceil(i/8),ceil(j/8)}.magnitude = imageGradient(i:i+cellSize-1,j:j+cellSize-1);
            cells{ceil(i/8),ceil(j/8)}.phase = phaseAngle(i:i+cellSize-1,j:j+cellSize-1)*rad2degree;
            [cells{ceil(i/8),ceil(j/8)}]=computeCellHistogram(cells{ceil(i/8),ceil(j/8)},cellSize);
            
        end
    end
    
end