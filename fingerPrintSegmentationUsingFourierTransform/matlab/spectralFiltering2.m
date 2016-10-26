function [windows,row,col] = spectralFiltering2(windows,windowSize)
    
    qualities = cell2mat(windows.Q);
    counts = cell2mat(windows.count);
    
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
    
    if(maxValue  == -1 && maxCount == -1)
        disp('all blocks')
        windows.allBlocks = 1;
    end
    
    %figure()
    %imshow(windows.data{row,col})
    
    
    windows = matchedFilterNoiseSuppression2(windows,windowSize,row,col);
    windows = circularGaussianBandPassFilter2(windows,windowSize,row,col);
    windows = directionalGaussianWindow2(windows,row,col);
   
    HM = windows.HM{row,col};
    HB = windows.HB{row,col};    
    H = HM .* HB;
    
    G = windows.GO{row,col};
    HGM = imfilter(H,G,'conv');
    
    %figure()
    %imshow(mat2gray(log(HGM+1)))
    
    windows.HGM{row,col} = HGM;
    windows.F{row,col} = windows.F{row,col} .* windows.HGM{row,col};
    %figure()
    %imshow(mat2gray((HGM+1)))
    
    windows.data{row,col} = real(ifft2(fftshift(windows.F{row,col})));
    windows.data{row,col} = uint8(windows.data{row,col});
    windows = updateNeighbourhood2(windows,row,col);
    
    %windows.count
    
    %figure()
    %imshow(windows.data{row,col})
    
end