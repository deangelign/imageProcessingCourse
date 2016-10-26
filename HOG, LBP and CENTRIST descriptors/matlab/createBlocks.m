function [blocks] = createBlocks(cells)
    [nRowsCell,nColsCell]= size(cells);
    for i=1:nRowsCell-1
        for j=1:nColsCell-1
            blocks{i,j}.cellsData = [cells{i,j} cells{i,j+1};cells{i+1,j} cells{i+1,j+1}];
            blocks{i,j}.hist = [cells{i,j}.bins cells{i,j+1}.bins cells{i+1,j}.bins cells{i+1,j+1}.bins];
            normalizeFactor = sum(blocks{i,j}.hist);
            if(normalizeFactor > 0)
                blocks{i,j}.histN = blocks{i,j}.hist/normalizeFactor;
            else
                blocks{i,j}.histN = blocks{i,j}.hist;
            end
        end
    end
end