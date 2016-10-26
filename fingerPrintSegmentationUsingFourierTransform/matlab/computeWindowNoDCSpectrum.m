function [windows]=computeWindowNoDCSpectrum(windows)
    
    [wRow wCol] = size(windows.FM);
    
    for i=1:wRow
        for j=1:wCol
            windows.FM_noDC{i,j} = windows.FM{i,j};
            windows.FM_noDC{i,j}(windows.v0,windows.u0) = 0;
            
            %figure()
            %imshow(mat2gray(log(windows.FM_noDC{i,j}+1)) ) 
        end
    end
    
end