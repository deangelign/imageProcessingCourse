function blocksOverlap = updateNeighbourhood(blocksOverlap,blockRow,blockCol)
    
    blocksOverlap.count{blockRow,blockCol} = -1;
    blocksOverlap.Q{blockRow,blockCol} = -1;
    
    if(blockRow-1 > 0 ) 
        if(blocksOverlap.count{blockRow-1,blockCol} > -1)
            blocksOverlap.count{blockRow-1,blockCol} = blocksOverlap.count{blockRow-1,blockCol} + 1;  
        end
    end
    
    if(blockRow+1 <= size(blocksOverlap.Q,1))    
        if(blocksOverlap.count{blockRow+1,blockCol} > -1)
            blocksOverlap.count{blockRow+1,blockCol} = blocksOverlap.count{blockRow+1,blockCol} + 1;  
        end
    end
    
    if(blockCol-1 > 0  )
        if(blocksOverlap.count{blockRow,blockCol-1} > -1)
            blocksOverlap.count{blockRow,blockCol-1} = blocksOverlap.count{blockRow,blockCol-1} + 1;  
        end
    end
    
    if(blockCol+1 <= size(blocksOverlap.Q,2))  
        if(blocksOverlap.count{blockRow,blockCol+1} > -1 )
            blocksOverlap.count{blockRow,blockCol+1} = blocksOverlap.count{blockRow,blockCol+1} + 1;  
        end
    end
    
    if(blockRow-1 > 0 && blockCol-1 > 0)
        if(blocksOverlap.count{blockRow-1,blockCol-1} > -1)
            blocksOverlap.count{blockRow-1,blockCol-1} = blocksOverlap.count{blockRow-1,blockCol-1} + 1;
        end
    end
    
    if(blockRow-1 > 0 && blockCol+1 <= size(blocksOverlap.Q,2))
        if(blocksOverlap.count{blockRow-1,blockCol+1} > -1)
            blocksOverlap.count{blockRow-1,blockCol+1} = blocksOverlap.count{blockRow-1,blockCol+1} + 1;
        end
    end
    
    if(blockRow+1 <= size(blocksOverlap.Q,1) && blockCol-1 > 0)
        if(blocksOverlap.count{blockRow+1,blockCol-1} > -1)
            blocksOverlap.count{blockRow+1,blockCol-1} = blocksOverlap.count{blockRow+1,blockCol-1} + 1;
        end
    end
    
    if(blockRow+1 <= size(blocksOverlap.Q,1) && blockCol+1 <= size(blocksOverlap.Q,2))
        if(blocksOverlap.count{blockRow+1,blockCol+1} > -1)
            blocksOverlap.count{blockRow+1,blockCol+1} = blocksOverlap.count{blockRow+1,blockCol+1} + 1;
        end
    end
    
end