function [cellUnit]=computeCellHistogram(cellUnit,cellSize)
    binSize = 20;
    binCenter = [10:binSize:350];
    numberBins = size(binCenter,2);
    cellUnit.bins = zeros(1,numberBins);
    
    for i=1:cellSize
        for j=1:cellSize
        
            if(cellUnit.magnitude(i,j) == 0)
                continue;
            end
            
            if(cellUnit.phase(i,j) < 10)
                distBin350 = abs(-10 - cellUnit.phase(i,j));
                distBin10 = abs(10 - cellUnit.phase(i,j));
                fatorMultiplicativoBin350 = distBin10/binSize;
                fatorMultiplicativoBin10 = distBin350/binSize;
                cellUnit.bins(18) = cellUnit.bins(18) + fatorMultiplicativoBin350*cellUnit.magnitude(i,j);
                cellUnit.bins(1) = cellUnit.bins(1) + fatorMultiplicativoBin10*cellUnit.magnitude(i,j);
            elseif(cellUnit.phase(i,j) > 350)
                distBin350 = abs(350 - cellUnit.phase(i,j));
                distBin10 = abs(370 - cellUnit.phase(i,j));
                fatorMultiplicativoBin350 = distBin10/binSize;
                fatorMultiplicativoBin10 = distBin350/binSize;
                cellUnit.bins(18) = cellUnit.bins(18) + fatorMultiplicativoBin350*cellUnit.magnitude(i,j);
                cellUnit.bins(1) = cellUnit.bins(1) + fatorMultiplicativoBin10*cellUnit.magnitude(i,j);
            else
                    
                    diffs = abs(binCenter - cellUnit.phase(i,j));
                    [d1 index1]= min(diffs);
                    diffs(index1) = inf;
                    [d2 index2]= min(diffs);
                    fatorMultiplicativoBin1 = d2/binSize;
                    fatorMultiplicativoBin2 = d1/binSize;
                    cellUnit.bins(index1) = fatorMultiplicativoBin1*cellUnit.magnitude(i,j);
                    cellUnit.bins(index2) = fatorMultiplicativoBin2*cellUnit.magnitude(i,j);       
            end
            
        end
    end
 
end