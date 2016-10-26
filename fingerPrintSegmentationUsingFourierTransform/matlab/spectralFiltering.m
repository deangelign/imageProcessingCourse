function [blocksOverlap] = spectralFiltering(blocksOverlap)
    a = 0;
    while(1)
        qualities = cell2mat(blocksOverlap.Q);
        counts = cell2mat(blocksOverlap.count);

        maxValue = max(max(qualities));
        maxCount = max(max(counts));

        
        
        [row col] = find(maxValue == qualities & maxCount == counts);
        if(size(row,1) < 1)
            [row col] = find(maxValue == qualities);
        end
        
        if(size(row,1) > 1)
            row = row(1);
            col = col(1);
        end
        
        
        if(maxValue == -1 && maxCount == -1)
            break;
        end
        
%         row = 6;
%         col = 6;
        %figure()
        %imshow( blocksOverlap.data{row,col})
        
        blocksOverlap = matchedFilterNoiseSuppression(blocksOverlap,row,col);
        blocksOverlap = circularGaussianBandPassFilter(blocksOverlap,row,col);
        blocksOverlap = directionalGaussianWIndow(blocksOverlap,row,col,blocksOverlap.windowSize);

        HM = blocksOverlap.HM{row,col};
        HB = blocksOverlap.HB{row,col};
        
        H = HM .* HB;
        G = blocksOverlap.GO{row,col};
        HGM = imfilter(H,G,'conv');
        
%         figure()
%         imshow(mat2gray(log(H+1)))
         blocksOverlap.HGM{row,col} = HGM;
%         
%          figure()
%          imshow(mat2gray(log(HGM+1)));
%         
        blocksOverlap.Ff{row,col} = blocksOverlap.F{row,col} .* blocksOverlap.HGM{row,col};
        
%         Ff = (blocksOverlap.Ff{row,col});
%         figure()
%         imshow(mat2gray(log(abs(Ff)+1)));
        
        blocksOverlap = updateNeighbourhood(blocksOverlap,row,col);
        %a = a + 1
        %blocksOverlap.Q
        %blocksOverlap.count
        %row 
        %col
        
    end
    
end