%%peform the histogram matching(specification)
%%by Deangeli Gomes Never
function [outputImage map] = myHistogramMatching(sourceImage,TargetImage)
    
    %get images resolutions
    [M1 N1 c1] = size(sourceImage); 
    [M2 N2 c2] = size(TargetImage);

    %image grid size
    numberPixelInSourceGrid =  M1*N1;
    numberPixelInTargetGrid =  M2*N2;

    %number of pixel intesities
    numberIntensities = 256;
    
    %double check if the images are greyscale 
    if c1>1
        sourceImage = rgb2gray(sourceImage);
    end
    if c2>2
        TargetImage = rgb2gray(TargetImage);
    end


    %Store mapping - Cast to uint8 to respect data type
    map = zeros(256,1,'uint8'); 

    %Compute histograms
    histogramSource = imhist(sourceImage); 
    histogramTarget = imhist(TargetImage);

    %compute CDFs
    cdf1 = cumsum(histogramSource) / numel(sourceImage);  
    cdf2 = cumsum(histogramTarget) / numel(TargetImage);

    %Compute the inverse mapping 
    for index = 1 : numberIntensities
        [minumumValue,indexMinimumElement] = min(abs(cdf1(index) - cdf2));
        map(index) = indexMinimumElement-1;
    end

    %apply the mapping  in order to the source image distribution looks like the distribution of the target image
    outputImage = map(double(sourceImage)+1);
end