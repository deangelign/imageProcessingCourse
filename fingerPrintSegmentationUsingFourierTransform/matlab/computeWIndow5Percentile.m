function [windows] = computeWIndow5Percentile(windows,windowSize)

    [wRow wCol] = size(windows.FM);

    for i=1:wRow
        for j=1:wCol
        
            windows.FM_noDC_noRidge_5th{i,j} = windows.FM_noDC_noRidge{i,j};
            
            for iSpectrum = 1:windowSize
                for jSpectrum = 1:windowSize
                    
                    if(windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum)/windows.MaxNoDc{i,j} > 0.05)
                    %if(windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum)/windows.maxValue{i,j} > 0.05)    
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = 0;
                    else
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = windows.FM_noDC_noRidge{i,j}(iSpectrum,jSpectrum);
                    end
                    
                end
            end
            
             %figure()
             %imshow(mat2gray(log(windows.FM_noDC_noRidge_5th{i,j}+1)))
        
        end
    end

end