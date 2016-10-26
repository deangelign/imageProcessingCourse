function [Inew, erroQuadratico, iter]= difusion(image, lambda, k, typeFunction, threshold, numberMaxIterations)
    
    [nrow ncol nchannels] = size(image);
    if(nchannels > 1)%make sure image is grayscale
        image = rgb2gray(image);
    end
    numberPixels = nrow * ncol;
    
    %init variables
    northGradientImage = (zeros(nrow,ncol));
    cN = (zeros(nrow,ncol));

    southGradientImage = (zeros(nrow,ncol));
    cS = (zeros(nrow,ncol));

    eastGradientImage = (zeros(nrow,ncol));
    cE = (zeros(nrow,ncol));

    westGradientImage = (zeros(nrow,ncol));
    cW = (zeros(nrow,ncol));

    Iold = double(image);
    Inew = Iold;
    iter = 1;
    erroQuadratico = [9999999];
    %%%%%%%%%%%%%%%%

    
    
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
        erroQuadratico = [erroQuadratico (sum( (Inew(:)-Iold(:)) .^ 2))/numberPixels];
        iter = iter + 1; 
        %erroQuadratico(iter)
        %erroQuadratico(iter) = 99999;
        Iold = Inew;
    end
    %erroQuadratico = erroQuadratico/
    
    
    
end