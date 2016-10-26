function [windows]=computeWindowRidge(windows,windowSize)
    
    [wRow wCol] = size(windows.FM);
    windows.M = windowSize/16;
    
    for i=1:wRow
        for j=1:wCol
            
             maxValue = max(windows.FM{i,j}(:));
             windows.maxValue{i,j} = maxValue;
             maxValueNoDC = max(windows.FM_noDC{i,j}(:));
             [rowMax colMax]= find(maxValueNoDC == windows.FM_noDC{i,j});
             rowMax = rowMax(1);
             colMax = colMax(1);
             windows.vp{i,j} = rowMax;
             windows.up{i,j} = colMax;
             v = windows.vp{i,j} - windows.v0;
             u = windows.up{i,j} - windows.u0;
             windows.fr{i,j} = sqrt((v^2) + (u^2));
             windows.theta{i,j} = atan2(v,u);
             windows.MaxNoDc{i,j} = maxValueNoDC;
             
             windows.FM_noDC_noRidge{i,j} = windows.FM_noDC{i,j};
             windows.FM_noDC_noRidge_5th{i,j} = windows.FM_noDC_noRidge{i,j};
             
             for iSpectrum = 1:windowSize
                for jSpectrum = 1:windowSize
                    
                    v = iSpectrum - windows.v0;
                    u = jSpectrum - windows.u0;
                    d = sqrt((v^2) + (u^2));
                    
                    if(d >=  windows.fr{i,j} && d <=  windows.fr{i,j} + windows.M)
                        windows.FM_noDC_noRidge{i,j}(iSpectrum,jSpectrum) = 0;
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = 0;
                    else
                        windows.FM_noDC_noRidge{i,j}(iSpectrum,jSpectrum) = windows.FM_noDC{i,j}(iSpectrum,jSpectrum);
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = windows.FM_noDC{i,j}(iSpectrum,jSpectrum);
                    end
                    
                    %%5th
                    if(windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum)/windows.MaxNoDc{i,j} > 0.05)
                    %if(windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum)/windows.maxValue{i,j} > 0.05)    
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = 0;
                    else
                        windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum) = windows.FM_noDC_noRidge{i,j}(iSpectrum,jSpectrum);
                    end
                    
                end
             end
             
             %figure()
             %imshow(mat2gray(log(windows.FM_noDC_noRidge{i,j}+1)))
             
        end
    end

end