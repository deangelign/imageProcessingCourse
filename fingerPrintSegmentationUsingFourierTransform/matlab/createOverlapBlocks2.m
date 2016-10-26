function [windows] = createOverlapBlocks2(blocks,blockSize,windowSize)
    [rowBlocks colBlocks]=size(blocks);
    

    
     for i=2:rowBlocks-1
         for j=2:colBlocks-1

             windows.data{i-1,j-1} = [blocks{i-1,j-1} blocks{i-1,j} blocks{i-1,j+1}
                                 blocks{i,j-1} blocks{i,j} blocks{i,j+1}
                                 blocks{i+1,j-1} blocks{i+1,j} blocks{i+1,j+1}];

            windows.data{i-1,j-1} = windows.data{i-1,j-1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
            windows.Q{i-1,j-1} = 1;
            windows.count{i-1,j-1} = 0;
         end
     end


end