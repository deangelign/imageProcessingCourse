function [imageSign] = createSigntureImage(image)
    
    [nRows nCols] = size(image);
    neighbourhood = zeros(3,3);
    
    for i=1:nRows
        for j=1:nCols
            
            neighbourhood = zeros(3,3);
            
            if(i==1 && j==1)
                neighbourhood(2:3,2:3) = image(i:i+1,j:j+1);
            elseif(i==1)
                neighbourhood(2:3,1:3) = image(i:i+1,j-1:j+1);
            elseif(j == 1)
                neighbourhood(1:3,2:3) = image(i-1:i+1,j:j+1);
            elseif(i == nRows && j == nCols)
                neighbourhood(1:2,1:2) = image(i-1:i,j-1:j);
            elseif(i == nRows)
                neighbourhood(1:2,1:3) = image(i-1:i,j-1:j+1);
            elseif(j == nCols)
                neighbourhood(1:3,1:2) = image(i-1:i+1,j-1:j);
            else
                neighbourhood =  image(i-1:i+1,j-1:j+1);
            end
            
            
            
        end
    end

end