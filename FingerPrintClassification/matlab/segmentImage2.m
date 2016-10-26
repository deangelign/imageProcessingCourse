function [ImageSeg]= segmentImage2(image,pesos,windowSize)
    
    
     [nRows nCols] = size(image);
     ImageSeg = image;
     myShift =  floor(windowSize/2);
     for i=1+myShift:nRows-myShift
         for j=1+myShift:nCols-myShift
            sample = image(i-myShift:i+myShift,j-myShift:j+myShift);
            classe = classify2(pesos,sample);
            
            if(classe > 0)
                ImageSeg(i,j) = image(i,j);
            else
                ImageSeg(i,j) = 255;
            end
            
         end
     end
     
end