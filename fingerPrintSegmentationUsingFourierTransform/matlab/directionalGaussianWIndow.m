function [blocksOverlap] = directionalGaussianWIndow(blocksOverlap,blockRow,blockCol,windowSize)
    
    
    
    if(blocksOverlap.M <= 1)
        blocksOverlap.G  =                   [0.368 0.607 0.368
                                              0.607 1 0.607
                                              0.368 0.607 0.368];
    end
    
    if(blocksOverlap.M >= 2)
         
         blocksOverlap.G =      [0.018 0.082 0.135 0.082 0.018
                                0.082 0.368 0.607 0.368 0.082
                                0.135 0.607 1 0.607 0.135
                                0.082 0.368 0.607 0.368 0.082
                                0.018 0.082 0.135 0.082 0.018] ;
    end
    
    if(blocksOverlap.M >= 2)
        
        rad2Degree = 180/pi;
        baseAngle = 22.5 * rad2Degree;
        blockAngle = blocksOverlap.theta{blockRow,blockCol}*rad2Degree;
        
        if(blockAngle < 0)
            blockAngle = blockAngle+(180);   
        end
        
        
        
        %1v
        if (blockAngle >= 0 && blockAngle < 22.5)
            blocksOverlap.DTheta{blockRow,blockCol} = [0 0 0 0 0
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       0 0 0 0 0];
        end
        
        %2v
        if (blockAngle >= 22.5 && blockAngle < 45)
            blocksOverlap.DTheta{blockRow,blockCol} = [0 0 0 0 1
                                                       0 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 0
                                                       1 0 0 0 0];
        end
        
        %3v
         if (blockAngle >= 45 && blockAngle < 67.5)
             blocksOverlap.DTheta{blockRow,blockCol} = [0 0 0 1 1
                                                       0 0 1 1 1
                                                       0 1 1 1 0
                                                       1 1 1 0 0
                                                       1 1 0 0 0];
         end
         
         %4v
         if (blockAngle >= 67.5 && blockAngle < 90)
             blocksOverlap.DTheta{blockRow,blockCol} = [0 0 1 1 1
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       1 1 0 0 0];
         end
         
         %5v
         if (blockAngle >= 90 && blockAngle < 112.5)
             blocksOverlap.DTheta{blockRow,blockCol} = [0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0];
         end
         
         %6v
         if (blockAngle >= 112.5 && blockAngle < 135)
             blocksOverlap.DTheta{blockRow,blockCol} = [1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1];
         end
         
         %7v
         if (blockAngle >= 135 && blockAngle < 157.5)
             blocksOverlap.DTheta{blockRow,blockCol} = [1 1 0 0 0
                                                       1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1
                                                       0 0 0 1 1];
         end
         
         %8v
         if (blockAngle >= 157.5)
             blocksOverlap.DTheta{blockRow,blockCol} = [1 0 0 0 0
                                                       1 1 1 1 0
                                                       1 1 1 1 1
                                                       0 1 1 1 1
                                                       0 0 0 0 1];
         end
         
         
    end
    
    if(blocksOverlap.M >= 2)
        blocksOverlap.GO{blockRow,blockCol} =  blocksOverlap.G .* blocksOverlap.DTheta{blockRow,blockCol};
    end
    
    if(blocksOverlap.M <= 1)
        blocksOverlap.GO{blockRow,blockCol} =  blocksOverlap.G ;
    end
    
    %figure()
    %imshow( mat2gray(log(blocksOverlap.GO{blockRow,blockCol} + 1)))
end