clc;
clear;
close all;

%image = imread('AmostrasDigitais/db4a2004/1_5.tif');
%image = imread('img/2.jpg');
image =  imread('AmostrasDigitais/db2a2000/1_1.tif');
[nRow nCol nChannels] = size(image);

if(nChannels > 1)
    image=rgb2gray(image);
end
figure()
imshow(image);

zeroPadding = 0;
blockSize = 16;
currentRow = 1;
currentCol = 1;
numberBlocks = 0;
blocks = [];
window.M = blockSize/16;
u0 = blockSize+1;
v0 = blockSize+1;


iter = 0;
iterMax = 30;
while(iter < iterMax)
blockRow = 1;
blockCol = 1;
    
extendedImage = [image image image;image image image;image image image];
%figure()
%imshow(extendedImage);       
for i=nRow+1:blockSize:(2*nRow)+1
    for j=nCol+1:blockSize:(2*nCol)+1
        
        %b{blockRow,blockCol} = extendedImage(i:i+blockSize-1,j:j+blockSize-1);
        
        
        window.data{blockRow,blockCol} = [    extendedImage((i-1)-((blockSize/2)-1):(i-1),(j-1)-((blockSize/2)-1):j-1) extendedImage((i-1)-((blockSize/2)-1):(i-1),j:j+blockSize-1) extendedImage((i-1)-((blockSize/2)-1):(i-1),(j+blockSize):(j+blockSize)+(blockSize/2)-1)
                                                    extendedImage(i:i+blockSize-1,(j-1)-((blockSize/2)-1):j-1) extendedImage(i:i+blockSize-1,j:j+blockSize-1) extendedImage(i:i+blockSize-1,(j+blockSize):(j+blockSize)+(blockSize/2)-1)
                                                    extendedImage((i+blockSize):(i+blockSize)+(blockSize/2)-1,(j-1)-((blockSize/2)-1):j-1) extendedImage((i+blockSize):(i+blockSize)+(blockSize/2)-1,j:j+blockSize-1) extendedImage((i+blockSize):(i+blockSize)+(blockSize/2)-1,(j+blockSize):(j+blockSize)+(blockSize/2)-1)]; 
        
         
       
        window.f{blockRow,blockCol} = fftshift(fft2(  window.data{blockRow,blockCol} ));
        window.fm{blockRow,blockCol} = abs(window.f{blockRow,blockCol});
        %figure()
        %imshow(mat2gray(log(window.fm{blockRow,blockCol} + 1)));
        
        window.fm_nodc{blockRow,blockCol} = window.fm{blockRow,blockCol};
        window.fm_nodc{blockRow,blockCol}(v0,u0) = 0;
        %figure()
        %imshow(mat2gray(log(window.fm{blockRow,blockCol}+1)))
        maxValue = max(window.fm_nodc{blockRow,blockCol}(:));
        [vp up] = find(window.fm_nodc{blockRow,blockCol} == maxValue);
        vp = vp(1);
        up = up(1);
        window.vp{blockRow,blockCol} = vp;
        window.up{blockRow,blockCol} = up;
        
        u = (window.up{blockRow,blockCol}-u0);
        v = (window.vp{blockRow,blockCol}-v0);
        
        window.fr{blockRow,blockCol} = sqrt((u^2) + (v^2));
        window.theta{blockRow,blockCol} = atan(v/u);
        window.fm_nodc_noridge{blockRow,blockCol} = window.fm_nodc{blockRow,blockCol};
        
        for row=1:blockSize*2
            for col=1:blockSize*2
                
                 u = (col-u0)^2;
                 v = (row-v0)^2;
                 d = sqrt(u+v);
                 if( d >= window.fr{blockRow,blockCol} && d <= window.fr{blockRow,blockCol} + window.M )
                    window.fm_nodc_noridge{blockRow,blockCol}(row,col) = 0;
                 end
                 
                 if(window.fm_nodc_noridge{blockRow,blockCol}(row,col)/maxValue > 0.05)
                     window.fm_nodc_noridge{blockRow,blockCol}(row,col) = 0;
                 end
                 
            end
        end
        
        window.NP{blockRow,blockCol} = max(window.fm_nodc_noridge{blockRow,blockCol}(:));
        window.RP{blockRow,blockCol} = window.fm_nodc{blockRow,blockCol}(vp,up);
        if(window.RP{blockRow,blockCol} <= 0)
            window.RP{blockRow,blockCol} = 0.00001;
        end
        window.Q{blockRow,blockCol} = 1 - (window.NP{blockRow,blockCol}/window.RP{blockRow,blockCol});
        %figure()
        %imshow(mat2gray(log(window.fm_nodc{blockRow,blockCol}+1) ));
        %hold on
        %plot(up,vp,'r*')
        %figure()
        %imshow( mat2gray(log(window.fm_nodc_noridge{blockRow,blockCol}+1)) );
        window.count{blockRow,blockCol} = 0;
        
        
        blockCol = blockCol + 1;
        
    end
    blockCol = 1;
    blockRow = blockRow + 1;
   
end

a = 0;
while(1)
   
    qualities = cell2mat(window.Q);
    counts = cell2mat(window.count);
    
    maxValue = max(max(qualities));
    maxCount = max(max(counts));
    
    [CblockRow CblockCol] = find(maxValue == qualities & maxCount == counts);
    if(size(CblockRow,1) < 1)
        [CblockRow CblockCol] = find(maxValue == qualities);
    end
    
    if(size(CblockRow,1) > 1)
        CblockRow = CblockRow(1);
        CblockCol = CblockCol(1);
    end
    
    if(maxValue == -1 && maxCount == -1)
        break;
    end

    %%HM
    for row=1:blockSize*2
        fm = window.fm{CblockRow,CblockCol};
        for col=1:blockSize*2
            if(fm(row,col) <= window.NP{CblockRow,CblockCol})
                window.HM{CblockRow,CblockCol}(row,col) = 0;
            else
                window.HM{CblockRow,CblockCol}(row,col) = window.fm{CblockRow,CblockCol}(row,col);
            end
        end
    end
    
    
    %%HB
     for row=1:blockSize*2
         for col=1:blockSize*2
              
            v = (row-v0)^2;
            u = (col-u0)^2;
            D_square = u+v;
            
            num = (-1/2)*D_square;
            denshift = (window.fr{CblockRow,CblockCol} + window.M)^2;
            den = (window.fr{CblockRow,CblockCol} )^2;
            
            factoShift = exp(num/denshift);
            factor = exp(num/den);
            
            window.HB{CblockRow,CblockCol}(row,col) = factoShift*(1 - factor);  
        end
     end
     
    %figure()
    %imshow(mat2gray(log(window.HB{blockRow,blockCol}+1)));
   
    %GO
    if(window.M <= 1)
        window.G  =                   [0.368 0.607 0.368
                                              0.607 1 0.607
                                              0.368 0.607 0.368];
        window.GO{CblockRow,CblockCol} =  window.G .* [1 1 1;1 1 1;1 1 1];
    end
    
    if(window.M >= 2)
         
         window.G =      [0.018 0.082 0.135 0.082 0.018
                                0.082 0.368 0.607 0.368 0.082
                                0.135 0.607 1 0.607 0.135
                                0.082 0.368 0.607 0.368 0.082
                                0.018 0.082 0.135 0.082 0.018] ;
    
        rad2Degree = 180/pi;
        baseAngle = 22.5 * rad2Degree;
        blockAngle = window.theta{CblockRow,CblockCol}*rad2Degree;
        
        if(blockAngle < 0)
            blockAngle = blockAngle+(180);   
        end
        
        
        %1v
        if (blockAngle >= 0 && blockAngle < 22.5)
            window.DTheta{CblockRow,CblockCol} = [0 0 0 0 0
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 1
                                                       0 0 0 0 0];
        end
        
        %2v
        if (blockAngle >= 22.5 && blockAngle < 45)
            window.DTheta{CblockRow,CblockCol} = [0 0 0 0 1
                                                       0 1 1 1 1
                                                       1 1 1 1 1
                                                       1 1 1 1 0
                                                       1 0 0 0 0];
        end
        
        %3v
         if (blockAngle >= 45 && blockAngle < 67.5)
             window.DTheta{CblockRow,CblockCol} = [0 0 0 1 1
                                                       0 0 1 1 1
                                                       0 1 1 1 0
                                                       1 1 1 0 0
                                                       1 1 0 0 0];
         end
         
         %4v
         if (blockAngle >= 67.5 && blockAngle < 90)
             window.DTheta{CblockRow,CblockCol} = [0 0 1 1 1
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       1 1 0 0 0];
         end
         
         %5v
         if (blockAngle >= 90 && blockAngle < 112.5)
             window.DTheta{CblockRow,CblockCol} = [0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0];
         end
         
         %6v
         if (blockAngle >= 112.5 && blockAngle < 135)
             window.DTheta{CblockRow,CblockCol} = [1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1];
         end
         
         %7v
         if (blockAngle >= 135 && blockAngle < 157.5)
             window.DTheta{CblockRow,CblockCol} = [1 1 0 0 0
                                                       1 1 1 0 0
                                                       0 1 1 1 0
                                                       0 0 1 1 1
                                                       0 0 0 1 1];
         end
         
         %8v
         if (blockAngle >= 157.5)
             window.DTheta{CblockRow,CblockCol} = [1 0 0 0 0
                                                       1 1 1 1 0
                                                       1 1 1 1 1
                                                       0 1 1 1 1
                                                       0 0 0 0 1];
         end
        
        window.GO{CblockRow,CblockCol} =  window.G .* window.DTheta{CblockRow,CblockCol};
    end
    
    
    %figure()
    %imshow(window.GO{blockRow,blockCol})
    
    H = window.HB{CblockRow,CblockCol} .* window.HM{CblockRow,CblockCol};
    G = window.GO{CblockRow,CblockCol};
    HGM = imfilter(H,G);
    
    
    window.HGM{CblockRow,CblockCol} = HGM;
    window.Ff{CblockRow,CblockCol} = window.f{CblockRow,CblockCol} .* window.HGM{CblockRow,CblockCol};
    
    %figure()
    %imshow(mat2gray(log(HGM+1)));
    
    window = updateNeighbourhood(window,CblockRow,CblockCol);
    
%     window.Q;
%     window.count;
%     a = a + 1
end


for i=1:size(window.Ff,1)
    for j=1:size(window.Ff,2)
        
        window.dataf{i,j} = real(ifft2(fftshift(window.Ff{i,j})));
        window.dataf{i,j} = uint8(window.dataf{i,j});
        bf{i,j} = window.dataf{i,j}( (blockSize/2)+1:(blockSize/2)+blockSize,(blockSize/2)+1:(blockSize/2)+blockSize);
        
    end
end


b = cell2mat(bf);
b = b(1:nRow,1:nCol);
figure()
imshow(b);
image = b;
iter = iter + 1;
end

%figure()
%imshow(extendedImage);
