function [blocks] = updateBlocks(blocks,blockSize,windows,row,col)
    blocks{row+1,col+1} = windows.data{row,col}((blockSize/2)+1:(blockSize/2)+blockSize,(blockSize/2)+1:(blockSize/2)+blockSize);
    
    
    
    %blocks{row+1,col}(1:blockSize,(blockSize/2)+1:blockSize) = windows.data{row,col}((blockSize/2)+1:(blockSize/2)+blockSize,1:(blockSize/2));
    %blocks{row+1,col+2}(1:blockSize,1:(blockSize/2)) = windows.data{row,col}((blockSize/2)+1:(blockSize/2)+blockSize,(blockSize/2)+blockSize+1:(blockSize)+blockSize);
    %blocks{row,col+1}((blockSize/2)+1:blockSize,1:blockSize) = windows.data{row,col}(1:(blockSize/2),(blockSize/2)+1:(blockSize/2)+blockSize);
    %blocks{row+2,col+1}(1:(blockSize/2),1:blockSize) =  windows.data{row,col}((blockSize/2)+blockSize+1:(blockSize)+blockSize,(blockSize/2)+1:(blockSize/2)+blockSize);
    
    %blocks{row,col}((blockSize/2)+1:blockSize,(blockSize/2)+1:blockSize) = windows.data{row,col}(1:(blockSize/2),1:(blockSize/2));
    %blocks{row,col+2}((blockSize/2)+1:blockSize,1:(blockSize/2)) = windows.data{row,col}(1:(blockSize/2),(blockSize/2)+blockSize+1:(blockSize)+blockSize);
    %blocks{row+2,col}(1:(blockSize/2),(blockSize/2)+1:blockSize) = windows.data{row,col}((blockSize/2)+blockSize+1:(blockSize)+blockSize,1:(blockSize/2));
    %blocks{row+2,col+2}(1:(blockSize/2),1:(blockSize/2)) = windows.data{row,col}((blockSize/2)+blockSize+1:(blockSize)+blockSize,(blockSize/2)+blockSize+1:(blockSize)+blockSize);
end