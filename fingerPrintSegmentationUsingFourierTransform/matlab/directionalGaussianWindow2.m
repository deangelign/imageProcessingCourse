function [windows] = directionalGaussianWindow2(windows,iWindow,jWindow)
    
    if(windows.M <=  1)
        windows.G{iWindow,jWindow} = [0.368 0.607 0.368
                                              0.607 1 0.607
                                              0.368 0.607 0.368];
       windows.GO{iWindow,jWindow} =  windows.G{iWindow,jWindow} ;
    else
        windows.G =      [0.018 0.082 0.135 0.082 0.018
                                0.082 0.368 0.607 0.368 0.082
                                0.135 0.607 1 0.607 0.135
                                0.082 0.368 0.607 0.368 0.082
                                0.018 0.082 0.135 0.082 0.018] ;
        rad2Degree = 180/pi;
        blockAngle = windows.theta{iWindow,jWindow}*rad2Degree;
        
        if(blockAngle < 0)
            blockAngle = blockAngle+(180);   
        end
        
         %1v
        if (blockAngle >= 0 && blockAngle < 22.5)
            windows.DTheta{iWindow,jWindow} = [0 0 0 0 0
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       0 0 0 0 0];
        end
        
        %2v
        if (blockAngle >= 22.5 && blockAngle < 45)
            windows.DTheta{iWindow,jWindow} = [0 0 0 0 1
                                                       0 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 0
                                                       1 0 0 0 0];
        end
        
        %3v
         if (blockAngle >= 45 && blockAngle < 67.5)
             windows.DTheta{iWindow,jWindow} = [0 0 0 1 1
                                                       0 0 1 1 1
                                                       0 1 1 1 0
                                                       1 1 1 0 0
                                                       1 1 0 0 0];
         end
         
         %4v
         if (blockAngle >= 67.5 && blockAngle < 90)
             windows.DTheta{iWindow,jWindow} = [0 0 1 1 1
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       1 1 0 0 0];
         end
         
         %5v
         if (blockAngle >= 90 && blockAngle < 112.5)
             windows.DTheta{iWindow,jWindow} = [0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0];
         end
         
         %6v
         if (blockAngle >= 112.5 && blockAngle < 135)
             windows.DTheta{iWindow,jWindow} = [1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1];
         end
         
         %7v
         if (blockAngle >= 135 && blockAngle < 157.5)
             windows.DTheta{iWindow,jWindow} = [1 1 0 0 0
                                                       1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1
                                                       0 0 0 1 1];
         end
         
         %8v
         if (blockAngle >= 157.5)
             windows.DTheta{iWindow,jWindow} = [1 0 0 0 0
                                                       1 1 1 1 0
                                                       1 1 1 1 1
                                                       0 1 1 1 1
                                                       0 0 0 0 1];
         end
         
         windows.GO{iWindow,jWindow} =  windows.G .* windows.DTheta{iWindow,jWindow};
        
    end
    
    %figure();
    %imshow(mat2gray(windows.GO{iWindow,jWindow}));

end