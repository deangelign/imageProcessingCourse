function [windows] = circularGaussianBandPassFilter2(windows,windowSize,iWindow,jWindow)
    
    windows.HB{iWindow,jWindow} = ones(windowSize,windowSize);
    for iSpectrum = 1:windowSize
        for jSpectrum = 1:windowSize
            
            u = (jSpectrum-windows.u0);
            v = (iSpectrum-windows.v0);
            d = sqrt((v^2) + (u^2));
            d_square = d^2;
            
            fr = windows.fr{iWindow,jWindow};
            BW = windows.M;
            
            num = (-1/2)*d_square;
            denshift = (fr+BW)^2;
            den = (fr)^2;
            
            factoShift = exp(num/denshift);
            factor = exp(num/den);
            
            windows.HB{iWindow,jWindow}(iSpectrum,jSpectrum) = factoShift*(1 - factor);
        end
    end

    %figure()
    %imshow(mat2gray(windows.HB{iWindow,jWindow}))
    
    
end