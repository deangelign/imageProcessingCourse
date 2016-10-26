function [windows] = computeWindowsQuality2(windows)
    
    [wRow wCol] = size(windows.data);
    
    for i=1:wRow
        for j=1:wCol
            
            windowVariance = var(double(windows.data{i,j}(:)));
            if(windowVariance <= 10)
                windows.Q{i,j} = -1;
                continue;
            end
            
            if(windows.MaxNoDc{i,j} <= 0)
                windows.Q{i,j} = 1 ;
            else
                windows.Q{i,j} = 1 - (windows.NP{i,j}/windows.MaxNoDc{i,j});
            end
            
            if(windows.Q{i,j} > 0.75)
                windows.Q{i,j} = 1;
            end
            
            if(windows.Q{i,j} >= 0.5 &&  windows.Q{i,j} <= 0.75)
                windows.Q{i,j} = 0.75;
            end
            
            if(windows.Q{i,j} < 0.5 && windows.Q{i,j} >= 0)
                windows.Q{i,j} = 0;
            end
            
        end
    end
    

end