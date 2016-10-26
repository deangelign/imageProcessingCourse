function [blocks] = unOverlapBlocks(blocksOverlap, blockSize, overlap)
    blocks = blocksOverlap.data;
    [nrow ncol] = size(blocksOverlap.data);
    
    if(overlap == 1)
        for i=1:nrow
            for j=1: ncol
                blocks{i,j} =  blocksOverlap.dataf{i,j}(1+(blockSize/2):blockSize+(blockSize/2),1+(blockSize/2):blockSize+(blockSize/2));
            end
        end
    else
        for i=1:nrow
            for j=1: ncol
                blocks{i,j} = blocksOverlap.dataf{i,j};
            end
        end
    end
    
    
    
end