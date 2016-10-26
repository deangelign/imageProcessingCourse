function [windows] = computeWindowNP(windows)
    
    [wRow wCol] = size(windows.FM);
    for i=1:wRow
        for j=1:wCol
            windows.NP{i,j} = max(windows.FM_noDC_noRidge_5th{i,j}(:));
        end
    end

end