function [b blockRow blockCol] = createBlocks2(image,blockSize)
    blockRow = 1;
    blockCol = 1;
    [nRow nCol nChannels] = size(image);
    
    lastCol = image(:,nCol);
    image2 = [image repmat(lastCol,[1 blockSize])];

    lastRow = image2(nRow,:);
    image3 = [image2 ;repmat(lastRow,[blockSize 1])];

    
    for i=1:blockSize:nRow
        for j=1:blockSize:nCol
            b{blockRow,blockCol} = image3(i:i+blockSize-1,j:j+blockSize-1);
            %figure()
            %imshow(b{blockRow,blockCol});
            blockCol = blockCol + 1;
        end
        blockCol = 1;
        blockRow = blockRow + 1;
    end
    
end