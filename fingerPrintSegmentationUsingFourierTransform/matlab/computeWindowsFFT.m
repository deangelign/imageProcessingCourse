function [windows] = computeWindowsFFT(windows,blockSize)

    [wRow wCol] = size(windows.data);
    windows.u0 = (blockSize+1);
    windows.v0 = (blockSize+1);
    
    for i=1:wRow
        for j=1:wCol
            
            windows.F{i,j} = fftshift(fft2(windows.data{i,j}));
            windows.FM{i,j} = abs(windows.F{i,j});
            
        end
    end

end