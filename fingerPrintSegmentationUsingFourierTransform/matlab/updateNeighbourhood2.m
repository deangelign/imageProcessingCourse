function windows = updateNeighbourhood2(windows,iWindow,jWindow)
    
    windows.count{iWindow,jWindow} = -1;
    windows.Q{iWindow,jWindow} = -1;
    
    if(iWindow-1 > 0 ) 
        if(windows.count{iWindow-1,jWindow} > -1)
            windows.count{iWindow-1,jWindow} = windows.count{iWindow-1,jWindow} + 1;  
        end
    end
    
    if(iWindow+1 <= size(windows.Q,1))    
        if(windows.count{iWindow+1,jWindow} > -1)
            windows.count{iWindow+1,jWindow} = windows.count{iWindow+1,jWindow} + 1;  
        end
    end
    
    if(jWindow-1 > 0  )
        if(windows.count{iWindow,jWindow-1} > -1)
            windows.count{iWindow,jWindow-1} = windows.count{iWindow,jWindow-1} + 1;  
        end
    end
    
    if(jWindow+1 <= size(windows.Q,2))  
        if(windows.count{iWindow,jWindow+1} > -1 )
            windows.count{iWindow,jWindow+1} = windows.count{iWindow,jWindow+1} + 1;  
        end
    end
    
    if(iWindow-1 > 0 && jWindow-1 > 0)
        if(windows.count{iWindow-1,jWindow-1} > -1)
            windows.count{iWindow-1,jWindow-1} = windows.count{iWindow-1,jWindow-1} + 1;
        end
    end
    
    if(iWindow-1 > 0 && jWindow+1 <= size(windows.Q,2))
        if(windows.count{iWindow-1,jWindow+1} > -1)
            windows.count{iWindow-1,jWindow+1} = windows.count{iWindow-1,jWindow+1} + 1;
        end
    end
    
    if(iWindow+1 <= size(windows.Q,1) && jWindow-1 > 0)
        if(windows.count{iWindow+1,jWindow-1} > -1)
            windows.count{iWindow+1,jWindow-1} = windows.count{iWindow+1,jWindow-1} + 1;
        end
    end
    
    if(iWindow+1 <= size(windows.Q,1) && jWindow+1 <= size(windows.Q,2))
        if(windows.count{iWindow+1,jWindow+1} > -1)
            windows.count{iWindow+1,jWindow+1} = windows.count{iWindow+1,jWindow+1} + 1;
        end
    end
    
end