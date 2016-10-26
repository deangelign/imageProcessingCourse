clc;
clear;
close all;

%reading and displaying input image
img = imread('img1.bmp');
[nrow ncol nchannels] = size(img);
if(nchannels > 1)%make sure image is grayscale
    img = rgb2gray(img);
end
numberPixels = nrow*ncol;
figure()
imshow(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%init variables
northGradientImage = (zeros(nrow,ncol));
cN = (zeros(nrow,ncol));

southGradientImage = (zeros(nrow,ncol));
cS = (zeros(nrow,ncol));

eastGradientImage = (zeros(nrow,ncol));
cE = (zeros(nrow,ncol));

westGradientImage = (zeros(nrow,ncol));
cW = (zeros(nrow,ncol));

Iold = double(img);
Inew = Iold;
%%%%%%%%%%%%%%%%


%tuning parameters
k = 100.0;
lambda = 0.05;
numberMaxIterations = 1;
typeFunction = 1;
%%%%%%%%%%%%


%tuning output
printGradientAndWeights = 1;
printFiltredImage = 0;
printSubtractedImage = 0;
printLastOutput = 1;
%%%%%%%%%%%%%%%%

erroQuadratico = [9999999];
threshold = 1;
iter = 1;

while( iter <= numberMaxIterations && erroQuadratico(iter) > threshold )
    
    for y=1:nrow
        for x=1:ncol

            if(y-1 > 0)
                northGradientImage(y,x) = Iold(y-1,x) - Iold(y,x);
  
                if(typeFunction == 1)
                    cN(y,x) = 1.0 ./(1.0 + ( (northGradientImage(y,x)/k) ^ 2)  );
                elseif(typeFunction == 2)
                    cN(y,x) = exp(- ((abs((northGradientImage(y,x)))/k)^2) );
                elseif(typeFunction == 3)
                    cN(y,x) = 1/(1  + log( (abs(northGradientImage(y,x)) + 1  )));
                end
            end

            if(y+1 <= nrow)
                southGradientImage(y,x) = Iold(y+1,x) - Iold(y,x);
                
                if(typeFunction == 1)
                    cS(y,x) = 1.0 ./(1.0 + ( (southGradientImage(y,x)/k) ^ 2) );
                elseif(typeFunction == 2)
                    cS(y,x) = exp(- ((abs((southGradientImage(y,x)))/k)^2) );
                elseif(typeFunction == 3)
                    cS(y,x) = 1/(1  + log( (abs(southGradientImage(y,x)) + 1  )));
                end
            end

            if(x-1 > 0)
                eastGradientImage(y,x) = Iold(y,x-1) - Iold(y,x);
            
                if(typeFunction == 1)
                    cE(y,x) = 1.0 ./(1.0 + ( (eastGradientImage(y,x)/k) ^ 2)  );
                elseif(typeFunction == 2)
                    cE(y,x) = exp(- ((abs((eastGradientImage(y,x)))/k)^2) );
                elseif(typeFunction == 3)
                    cE(y,x) = 1/(1  + log( (abs(eastGradientImage(y,x)) + 1  )));
                end
            end

            if(x+1 <= ncol)
                westGradientImage(y,x) = Iold(y,x+1) - Iold(y,x);
                
                if(typeFunction == 1)
                    cW(y,x) = 1.0 ./(1.0 + ( (westGradientImage(y,x)/k) ^ 2)  );
                elseif(typeFunction == 2)
                    cW(y,x) = exp(- ((abs((westGradientImage(y,x)))/k)^2) );
                elseif(typeFunction == 3)
                    cW(y,x) = 1/(1  + log( (abs(westGradientImage(y,x)) + 1  )));
                end
            end
            a = lambda*( (northGradientImage(y,x)*cN(y,x)) + (southGradientImage(y,x)*cS(y,x)) + (eastGradientImage(y,x)*cE(y,x)) + (westGradientImage(y,x)*cW(y,x)) );
            Inew(y,x) = Iold(y,x) + a;
            
        end
    end
    
    if(printGradientAndWeights == 1)
        figure()
        subplot(1,2,1)
        imshow(uint8(northGradientImage));
        title(strcat('north gradient', num2str(iter)));
        subplot(1,2,2)
        imshow(cN);
        imwrite(uint8(northGradientImage), 'north.png');
        imwrite(cN, 'nWeight.png');
       

        figure()
        subplot(1,2,1)
        imshow(uint8(southGradientImage));
        title(strcat('south gradient', num2str(iter)));
        subplot(1,2,2)
        imshow(cS);
        imwrite(uint8(southGradientImage), 'south.png');
        imwrite(cS, 'sWeight.png');
        

        figure()
        subplot(1,2,1)
        imshow(uint8(eastGradientImage));
        title(strcat('east gradient', num2str(iter)));
        subplot(1,2,2)
        imshow(cE);
        imwrite(uint8(eastGradientImage), 'east.png');
        imwrite(cE, 'eWeight.png');
      

        figure()
        subplot(1,2,1)
        imshow(uint8(westGradientImage));
        title(strcat('west gradient', num2str(iter)));
        subplot(1,2,2)
        imshow(cW);
        imwrite(uint8(westGradientImage), 'west.png');
        imwrite(cW, 'wWeight.png');
        
    end

    if(printFiltredImage == 1)
        figure()
        imshow(uint8(Inew));
        title(strcat('filtred image ', num2str(iter)));
    end
    
    if(printSubtractedImage == 1)
        figure()
        imshow(uint8(Inew-Iold));
        title(strcat('subtracted image ', num2str(iter)));
    end
    erroQuadratico = [erroQuadratico sum( (Inew(:)-Iold(:)) .^ 2)];
    iter = iter + 1 
    %erroQuadratico(iter) = 99999;
    Iold = Inew;
    
    

end
 erroQuadratico =  erroQuadratico/numberPixels;
if(printLastOutput == 1)
    figure()
    imshow(uint8(Inew));
    title(strcat('number of iterations: ', num2str(iter-1)));
end








