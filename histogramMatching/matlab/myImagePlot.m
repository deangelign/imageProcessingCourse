function [] = myImagePlot(image)
    
    %get image resolutions
    [M1 N1 c1] = size(image); 
    
    %image grid size
    numberPixelInGrid =  M1*N1;
    
    
    %double check if the images are greyscale 
    if c1>1
        image = rgb2gray(image);
    end

    figure() 
    subplot(1,3,1)
    imshow(image)
    title('image')
    
    subplot(1,3,2)
    imhist(image);
    title('histogram')
    
    subplot(1,3,3)
    plot(cumsum(imhist(image)/numberPixelInGrid));
    title('cdf')
    axis([0 260 0 1.01])
    
    
end