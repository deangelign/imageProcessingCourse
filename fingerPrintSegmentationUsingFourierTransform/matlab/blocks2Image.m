function [image] = blocks2Image(blocks, originalRow, originalCol)
    imagePadding = cell2mat(blocks);
    image = imagePadding(1:originalRow,1:originalCol);
end