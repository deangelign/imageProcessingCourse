function [windows]= matchedFilterNoiseSuppression2(windows,windowSize,iWindow,jWindow)
    
            windows.HM{iWindow,jWindow} = windows.FM{iWindow,jWindow} ;
        
            for iSpectrum = 1:windowSize
                for jSpectrum = 1:windowSize
                    
                    if(windows.FM{iWindow,jWindow}(iSpectrum,jSpectrum) > windows.NP{iWindow,jWindow})
                        windows.HM{iWindow,jWindow}(iSpectrum,jSpectrum) = windows.FM{iWindow,jWindow}(iSpectrum,jSpectrum);
                    else
                        windows.HM{iWindow,jWindow}(iSpectrum,jSpectrum) = 0;
                    end
            
                end
            end
            
            %figure()
            %imshow(mat2gray(log(windows.HM{iWindow,jWindow}+1)))
            

end