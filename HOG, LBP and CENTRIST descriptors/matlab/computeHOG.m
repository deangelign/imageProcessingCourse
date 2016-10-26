function featureVector = computeHOG(sample)
    
    [Gx,Gy,G,phaseAngle] = computeGradients(sample);
    [cells]=createCells(G,phaseAngle);
    block = createBlocks(cells);
    featureVector = [];
    for i=1:size(block,1)
        for j=1:size(block,2)
            featureVector = [featureVector block{i,j}.histN];
        end
    end
    
    
end