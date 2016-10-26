function [windows] = updateWindowsQuality2(windows,row,col)
    
            windowVariance = var(double(windows.data{row,col}(:)));
            if(windowVariance <= 10)
                windows.Q{row,col} = -1;
                return;
            end
            
            if(windows.Q{row,col} < 0)
                return;
            end
            
            if(windows.MaxNoDc{row,col} <= 0)
                windows.Q{row,col} = 1 ;
                return
            else
                windows.Q{row,col} = 1 - (windows.NP{row,col}/windows.MaxNoDc{row,col});
                return
            end
            
            if(windows.Q{row,col} > 0.75)
                windows.Q{row,col} = 1;
                return
            end
            
            if(windows.Q{row,col} >= 0.5 &&  windows.Q{row,col} <= 0.75)
                windows.Q{row,col} = 0.75;
                return
            end
            
            if(windows.Q{row,col} < 0.5 && windows.Q{row,col} >= 0)
                windows.Q{row,col} = 0;
                return
            end


end