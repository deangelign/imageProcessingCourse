function [visited,block,blockPainted] = paintMinimalRegion(block,i,j,bounderies,visited,blockPainted)

if(i>bounderies(1) && i<bounderies(2) && j>bounderies(1) && j<bounderies(2))
    
    if(size(visited,1) > 0)
        f = size(find(i ==  visited(:,1)),1);
        if(f > 0)
            f = size(find(j ==  visited(:,2)),1);
        end
        if (f > 0)
            return;
        end
    end
    
    visited = [visited;[i j]];
    blockPainted(i,j) = 255;
    if( block(i+1,j) == block(i,j))
        [visited,block,blockPainted] = paintMinimalRegion(block,i+1,j,bounderies,visited,blockPainted);
    end
    if( block(i-1,j) == block(i,j))
        [visited,block,blockPainted] =  paintMinimalRegion(block,i-1,j,bounderies,visited,blockPainted);
    end
    if( block(i,j+1) == block(i,j))
        [visited,block,blockPainted] =  paintMinimalRegion(block,i,j+1,bounderies,visited,blockPainted);
    end
    if( block(i,j-1) == block(i,j))
        [visited,block,blockPainted] =  paintMinimalRegion(block,i,j-1,bounderies,visited,blockPainted);
    end
    %%%%%
%     if( block(i+1,j+1) == block(i,j))
%         [visited,block,blockPainted] =  paintMinimalRegion(block,i+1,j+1,bounderies,visited,blockPainted);
%     end
%     if( block(i+1,j-1) == block(i,j))
%         [visited,block,blockPainted] =  paintMinimalRegion(block,i+1,j-1,bounderies,visited,blockPainted);
%     end
%     
%     if( block(i-1,j+1) == block(i,j))
%         [visited,block,blockPainted] =  paintMinimalRegion(block,i-1,j+1,bounderies,visited,blockPainted);
%     end
%     if( block(i-1,j-1) == block(i,j))
%         [visited,block,blockPainted] =  paintMinimalRegion(block,i-1,j-1,bounderies,visited,blockPainted);
%     end
end

end