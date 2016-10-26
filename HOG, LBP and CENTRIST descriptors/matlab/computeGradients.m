function [Gx,Gy,G,phaseAngle]=computeGradients(image)
    [nRows,nCols] = size(image);
    image = double(image);
    Gx = zeros(nRows,nCols);
    Gy = zeros(nRows,nCols);
    G = zeros(nRows,nCols);
    phaseAngle = zeros(nRows,nCols);
    almostZero = 0.000001;
    
    for i=2:nRows-1
        for j=2:nCols-1
            
            
            Gy(i,j) = image(i,j+1) - image(i,j-1);   
            Gx(i,j) = image(i+1,j) - image(i-1,j);
            G(i,j) = sqrt((Gy(i,j)*Gy(i,j)) + (Gx(i,j)*Gx(i,j)));
            if(Gx(i,j) == 0)
                phaseAngle(i,j) = atan2(Gy(i,j),almostZero);
            else
                phaseAngle(i,j) = atan2(Gy(i,j),Gx(i,j));
            end
            
            
            if(phaseAngle(i,j) < 0)
                phaseAngle(i,j) = phaseAngle(i,j)+(2*pi);
            end
            
            
        end
    end

end
