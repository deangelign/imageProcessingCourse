function [volume,minHeight,visited] = computeVolume(block,i,j,bounderies,volume,minHeight,visited)


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
    if( block(i+1,j) == block(i,j))
        [volume,minHeight,visited] = computeVolume(block,i+1,j,bounderies,volume,minHeight,visited);
    end
    if( block(i-1,j) == block(i,j))
        [volume,minHeight,visited] =  computeVolume(block,i-1,j,bounderies,volume,minHeight,visited);
    end
    if( block(i,j+1) == block(i,j))
        [volume,minHeight,visited] =  computeVolume(block,i,j+1,bounderies,volume,minHeight,visited);
    end
    if( block(i,j-1) == block(i,j))
        [volume,minHeight,visited] =  computeVolume(block,i,j-1,bounderies,volume,minHeight,visited);
    end
    %%%%%
%     if( block(i+1,j+1) == block(i,j))
%         [volume,minHeight,visited] =  computeVolume(block,i+1,j+1,bounderies,volume,minHeight,visited);
%     end
%     if( block(i+1,j-1) == block(i,j))
%         [volume,minHeight,visited] =  computeVolume(block,i+1,j-1,bounderies,volume,minHeight,visited);
%     end
%     
%     if( block(i-1,j+1) == block(i,j))
%         [volume,minHeight,visited] =  computeVolume(block,i-1,j+1,bounderies,volume,minHeight,visited);
%     end
%     if( block(i-1,j-1) == block(i,j))
%         [volume,minHeight,visited] =  computeVolume(block,i-1,j-1,bounderies,volume,minHeight,visited);
%     end
    
    vec = block(i-1:i+1,j-1:j+1);
    heighst = vec(vec>block(i,j));
    minSoFar = min(heighst);
    if(minSoFar < minHeight);
        minHeight = minSoFar;
    end
end
end