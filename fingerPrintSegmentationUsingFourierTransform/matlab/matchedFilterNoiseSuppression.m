function [blocksOverlap] = matchedFilterNoiseSuppression(blocksOverlap,blockRow,blockCol)
    [row col] = size(blocksOverlap.data{blockRow,blockCol});
    for i=1:row
        for j=1:col
            if(blocksOverlap.F_m{blockRow,blockCol}(i,j) <= blocksOverlap.NP{blockRow,blockCol})
                blocksOverlap.HM{blockRow,blockCol}(i,j) = 0;   
            else
                blocksOverlap.HM{blockRow,blockCol}(i,j) = blocksOverlap.F_m{blockRow,blockCol}(i,j);
            end
        end
    end
    
    %figure()
    %imshow( mat2gray(log(blocksOverlap.HM{blockRow,blockCol} + 1)) )
    
end