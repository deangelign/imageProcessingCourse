function [windows]=updateWindowRidge(windows,windowSize,row,col)

     maxValue = max(windows.FM{row,col}(:));
             windows.maxValue{row,col} = maxValue;
             maxValueNoDC = max(windows.FM_noDC{row,col}(:));
             [rowMax colMax]= find(maxValueNoDC == windows.FM_noDC{row,col});
             rowMax = rowMax(1);
             colMax = colMax(1);
             windows.vp{row,col} = rowMax;
             windows.up{row,col} = colMax;
             v = windows.vp{row,col} - windows.v0;
             u = windows.up{row,col} - windows.u0;
             windows.fr{row,col} = sqrt((v^2) + (u^2));
             windows.theta{row,col} = atan2(v,u);
             windows.MaxNoDc{row,col} = maxValueNoDC;
             
             windows.FM_noDC_noRidge{row,col} = windows.FM_noDC{row,col};
             windows.FM_noDC_noRidge_5th{row,col} = windows.FM_noDC_noRidge{row,col};
             
             
             for iSpectrum = 1:windowSize
                for jSpectrum = 1:windowSize
                    
                    v = iSpectrum - windows.v0;
                    u = jSpectrum - windows.u0;
                    d = sqrt((v^2) + (u^2));
                    
                    if(d >=  windows.fr{row,col} && d <=  windows.fr{row,col} + windows.M)
                        windows.FM_noDC_noRidge{row,col}(iSpectrum,jSpectrum) = 0;
                        windows.FM_noDC_noRidge_5th{row,col}(iSpectrum,jSpectrum) = 0;
                    else
                        windows.FM_noDC_noRidge{row,col}(iSpectrum,jSpectrum) = windows.FM_noDC{row,col}(iSpectrum,jSpectrum);
                        windows.FM_noDC_noRidge_5th{row,col}(iSpectrum,jSpectrum) = windows.FM_noDC{row,col}(iSpectrum,jSpectrum);
                    end
                    
                    %%5th
                    if(windows.FM_noDC_noRidge_5th{row,col}(iSpectrum,jSpectrum)/windows.MaxNoDc{row,col} > 0.05)
                    %if(windows.FM_noDC_noRidge_5th{i,j}(iSpectrum,jSpectrum)/windows.maxValue{i,j} > 0.05)    
                        windows.FM_noDC_noRidge_5th{row,col}(iSpectrum,jSpectrum) = 0;
                    else
                        windows.FM_noDC_noRidge_5th{row,col}(iSpectrum,jSpectrum) = windows.FM_noDC_noRidge{row,col}(iSpectrum,jSpectrum);
                    end
                    
                end
             end

end