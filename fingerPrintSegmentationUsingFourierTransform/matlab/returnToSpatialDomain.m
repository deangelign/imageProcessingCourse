function [blocksOverlap] = returnToSpatialDomain(blocksOverlap)
    
   [nrow ncol] = size(blocksOverlap.dataf);
   [row col] = size(blocksOverlap.dataf{1,1});
   
   for i=1:nrow
        for j=1:ncol
            blocksOverlap.dataf{i,j} = real(ifft2(fftshift(blocksOverlap.Ff{i,j})));
            blocksOverlap.dataf{i,j} = uint8(blocksOverlap.dataf{i,j});
            
%             if(i == 6 && j == 6)
%             figure()
%             imshow(blocksOverlap.dataf{i,j});
%             end
        end
   end
   
   
    
end