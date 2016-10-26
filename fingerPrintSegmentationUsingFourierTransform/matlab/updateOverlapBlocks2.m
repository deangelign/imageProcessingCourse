function [windows] = updateOverlapBlocks2(blocks,blockSize,windowSize,windows,row,col)

    [wRows wCols]=size(windows.data);

     %for i=2:rowBlocks-1
     %    for j=2:colBlocks-1

     %        windows.data{i-1,j-1} = [blocks{i-1,j-1} blocks{i-1,j} blocks{i-1,j+1}
     %                            blocks{i,j-1} blocks{i,j} blocks{i,j+1}
     %                            blocks{i+1,j-1} blocks{i+1,j} blocks{i+1,j+1}];

     %       windows.data{i-1,j-1} = windows.data{i-1,j-1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
     %    end
     %end
     
     
%       windows.data{row,col} =     [blocks{row,col} blocks{row,col+1} blocks{row,col+2}
%                                   blocks{row+1,col} blocks{row+1,col+1} blocks{row+1,col+2}
%                                   blocks{row+2,col} blocks{row+2,col+1} blocks{row+2,col+2}];
%                               
%      windows.data{row,col} = windows.data{row,col}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
%      
     
     if(row-1 > 0)
        windows.data{row-1,col} = [blocks{row-1,col} blocks{row-1,col+1} blocks{row-1,col+2}
                                 blocks{row,col} blocks{row,col+1} blocks{row,col+2}
                                 blocks{row+1,col} blocks{row+1,col+1} blocks{row+1,col+2}];
        
        windows.data{row-1,col} = windows.data{row-1,col}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
        
        windows.F{row-1,col} = fftshift(fft2(windows.data{row-1,col}));
        windows.FM{row-1,col} = abs(windows.F{row-1,col});
        windows.FM_noDC{row-1,col} = windows.FM{row-1,col};
        windows.FM_noDC{row-1,col}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row-1,col);
        windows.NP{row-1,col} = max(windows.FM_noDC_noRidge_5th{row-1,col}(:));
        windows = updateWindowsQuality2(windows,row-1,col);
        
     end
     
     if(row+1 <= wRows)
        windows.data{row+1,col} = [blocks{row+1,col} blocks{row+1,col+1} blocks{row+1,col+2}
                                 blocks{row+2,col} blocks{row+2,col+1} blocks{row+2,col+2}
                                 blocks{row+3,col} blocks{row+3,col+1} blocks{row+3,col+2}];
        windows.data{row+1,col} = windows.data{row+1,col}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
        
        windows.F{row+1,col} = fftshift(fft2(windows.data{row+1,col}));
        windows.FM{row+1,col} = abs(windows.F{row+1,col});
        windows.FM_noDC{row+1,col} = windows.FM{row+1,col};
        windows.FM_noDC{row+1,col}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row+1,col);
        windows.NP{row+1,col} = max(windows.FM_noDC_noRidge_5th{row+1,col}(:));
        windows = updateWindowsQuality2(windows,row+1,col);
     end
     
     if(col-1 > 0)
        windows.data{row,col-1} = [blocks{row,col-1} blocks{row,col} blocks{row,col+1}
                                 blocks{row+1,col-1} blocks{row+1,col} blocks{row+1,col+1}
                                 blocks{row+2,col-1} blocks{row+2,col} blocks{row+2,col+1}];
        
        windows.data{row,col-1} = windows.data{row,col-1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
        
        windows.F{row,col-1} = fftshift(fft2(windows.data{row,col-1}));
        windows.FM{row,col-1} = abs(windows.F{row,col-1});
        windows.FM_noDC{row,col-1} = windows.FM{row,col-1};
        windows.FM_noDC{row,col-1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row,col-1);
        windows.NP{row,col-1} = max(windows.FM_noDC_noRidge_5th{row,col-1}(:));
        windows = updateWindowsQuality2(windows,row,col-1);
     end
     
     if(col+1 <= wCols)
         windows.data{row,col+1} = [blocks{row,col+1} blocks{row,col+2} blocks{row,col+3}
                                  blocks{row+1,col+1} blocks{row+1,col+2} blocks{row+1,col+3}
                                  blocks{row+2,col+1} blocks{row+2,col+2} blocks{row+2,col+3}];
       
        windows.data{row,col+1} = windows.data{row,col+1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
        
        windows.F{row,col+1} = fftshift(fft2(windows.data{row,col+1}));
        windows.FM{row,col+1} = abs(windows.F{row,col+1});
        windows.FM_noDC{row,col+1} = windows.FM{row,col+1};
        windows.FM_noDC{row,col+1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row,col+1);
        windows.NP{row,col+1} = max(windows.FM_noDC_noRidge_5th{row,col+1}(:));
        windows = updateWindowsQuality2(windows,row,col+1);
     end
     
     
      if(row-1 > 0 && col-1 > 0)
        windows.data{row-1,col-1} = [blocks{row-1,col-1} blocks{row-1,col} blocks{row-1,col+1}
                                 blocks{row,col-1} blocks{row,col} blocks{row,col+1}
                                 blocks{row+1,col-1} blocks{row+1,col} blocks{row+1,col+1}];
        
         windows.data{row-1,col-1} = windows.data{row-1,col-1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
      
        windows.F{row-1,col-1} = fftshift(fft2(windows.data{row-1,col-1}));
        windows.FM{row-1,col-1} = abs(windows.F{row-1,col-1});
        windows.FM_noDC{row-1,col-1} = windows.FM{row-1,col-1};
        windows.FM_noDC{row-1,col-1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row-1,col-1);
        windows.NP{row-1,col-1} = max(windows.FM_noDC_noRidge_5th{row-1,col-1}(:));
        windows = updateWindowsQuality2(windows,row-1,col-1);
      end
     
      if(row-1 > 0 && col+1 <= wCols)
        windows.data{row-1,col+1} = [blocks{row-1,col+1} blocks{row-1,col+2} blocks{row-1,col+3}
                                 blocks{row,col+1} blocks{row,col+2} blocks{row,col+3}
                                 blocks{row+1,col+1} blocks{row+1,col+2} blocks{row+1,col+3}];
        
        windows.data{row-1,col+1} = windows.data{row-1,col+1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
      
        windows.F{row-1,col+1} = fftshift(fft2(windows.data{row-1,col+1}));
        windows.FM{row-1,col+1} = abs(windows.F{row-1,col+1});
        windows.FM_noDC{row-1,col+1} = windows.FM{row-1,col+1};
        windows.FM_noDC{row-1,col+1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row-1,col+1);
        windows.NP{row-1,col+1} = max(windows.FM_noDC_noRidge_5th{row-1,col+1}(:));
        windows = updateWindowsQuality2(windows,row-1,col+1);
      end
     
     if(row+1 <= wRows && col-1 > 0)
        windows.data{row+1,col-1} = [blocks{row+1,col-1} blocks{row+1,col} blocks{row+1,col+1}
                                 blocks{row+2,col-1} blocks{row+2,col} blocks{row+2,col+1}
                                 blocks{row+3,col-1} blocks{row+3,col} blocks{row+3,col+1}];
        
         windows.data{row+1,col-1} = windows.data{row+1,col-1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
         
        windows.F{row+1,col-1} = fftshift(fft2(windows.data{row+1,col-1}));
        windows.FM{row+1,col-1} = abs(windows.F{row+1,col-1});
        windows.FM_noDC{row+1,col-1} = windows.FM{row+1,col-1};
        windows.FM_noDC{row+1,col-1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row+1,col-1);
        windows.NP{row+1,col-1} = max(windows.FM_noDC_noRidge_5th{row+1,col-1}(:));
        windows = updateWindowsQuality2(windows,row+1,col-1);
     end
     
     if(row+1 <= wRows && col+1 <= wCols)
        windows.data{row+1,col+1} = [blocks{row+1,col+1} blocks{row+1,col+2} blocks{row+1,col+3}
                                 blocks{row+2,col+1} blocks{row+2,col+2} blocks{row+2,col+3}
                                 blocks{row+3,col+1} blocks{row+3,col+2} blocks{row+3,col+3}];
        
        windows.data{row+1,col+1} = windows.data{row+1,col+1}((blockSize/2)+1:(blockSize/2)+windowSize,(blockSize/2)+1:(blockSize/2)+windowSize);
        
        windows.F{row+1,col+1} = fftshift(fft2(windows.data{row+1,col+1}));
        windows.FM{row+1,col+1} = abs(windows.F{row+1,col+1});
        windows.FM_noDC{row+1,col+1} = windows.FM{row+1,col+1};
        windows.FM_noDC{row+1,col+1}(windows.v0,windows.u0) = 0;
        windows = updateWindowRidge(windows,windowSize,row+1,col+1);
        windows.NP{row+1,col+1} = max(windows.FM_noDC_noRidge_5th{row+1,col+1}(:));
        windows = updateWindowsQuality2(windows,row+1,col+1);
     end
    
     
    
end