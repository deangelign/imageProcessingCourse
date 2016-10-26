function [blocksOverlap] = createOverlapCells(image, blockSize,blocks,blocksRow,blocksCol)
    overlapRegion = blockSize/2;
    blocksOverlap.data = blocks;
    
    for i=1:blocksRow
        for j=1:blocksCol
            
           
            
            if(j-1 > 0 && j+1 <= blocksCol && i-1 > 0 && i+1 <= blocksRow)
            A = [blocks{i-1,j-1} blocks{i-1,j} blocks{i-1,j+1} 
                blocks{i,j-1} blocks{i,j} blocks{i,j+1} 
                blocks{i+1,j-1} blocks{i+1,j} blocks{i+1,j+1}];
            
                %if(blocks{i-1,j} == blocks{i-1,j+1} && blocks{i,j-1} == blocks{i-1,j+1} && )
            
            end
            
            if(j-1 > 0 && j+1 <= blocksCol && i+1 <= blocksRow && (i-1 <= 0) )
            A = [zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)
                blocks{i,j-1} blocks{i,j} blocks{i,j+1}
                blocks{i+1,j-1} blocks{i+1,j} blocks{i+1,j+1}];
            end
            
            if(j-1 > 0 && j+1 <= blocksCol && i-1 > 0 && (i+1 > blocksRow) )
            A = [blocks{i-1,j-1} blocks{i-1,j} blocks{i-1,j+1}
                blocks{i,j-1} blocks{i,j} blocks{i,j+1}
                zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)];
            end
            
            %tira a a coluna da esquerda
            if( (j-1 <= 0) && j+1 <= blocksCol && i-1 > 0 && i+1 <= blocksRow)
                A = [zeros(overlapRegion*2,overlapRegion*2) blocks{i-1,j} blocks{i-1,j+1}
                    zeros(overlapRegion*2,overlapRegion*2) blocks{i,j} blocks{i,j+1}
                    zeros(overlapRegion*2,overlapRegion*2) blocks{i+1,j} blocks{i+1,j+1}];
            end 

            %tira a a coluna da direita        
            if(j-1 > 0 && (j+1 > blocksCol) && i-1 > 0 && i+1 <= blocksRow)
                A = [blocks{i-1,j-1} blocks{i-1,j} zeros(overlapRegion*2,overlapRegion*2)
                    blocks{i,j-1} blocks{i,j} zeros(overlapRegion*2,overlapRegion*2)
                    blocks{i+1,j-1} blocks{i+1,j} zeros(overlapRegion*2,overlapRegion*2)];
            end

            %tira a a coluna da direita e a linha de cima        
            if(j-1 <= 0 && i-1 <= 0 &&  j+1 <= blocksCol && i+1 <= blocksRow)
               A = [zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)
                   zeros(overlapRegion*2,overlapRegion*2) blocks{i,j} blocks{i,j+1}
                   zeros(overlapRegion*2,overlapRegion*2) blocks{i+1,j} blocks{i+1,j+1}];
            end
            
            

            %tira a a coluna da direita e a linha de cima        
            if(j-1 > 0 && i-1 > 0 &&  j+1 > blocksCol && i+1 > blocksRow)
                A = [blocks{i-1,j-1} blocks{i-1,j} zeros(overlapRegion*2,overlapRegion*2)
                    blocks{i,j-1} blocks{i,j} zeros(overlapRegion*2,overlapRegion*2)
                    zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)];
            end

             %tira a a coluna da direita e a linha de cima        
            if(j-1 <= 0 && i-1 > 0 &&  j+1 <= blocksCol && i+1 > blocksRow)
                A = [zeros(overlapRegion*2,overlapRegion*2) blocks{i-1,j} blocks{i-1,j+1}
                    zeros(overlapRegion*2,overlapRegion*2) blocks{i,j} blocks{i,j+1}
                    zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)];
            end

             %tira a a coluna da direita e a linha de cima        
            if(j-1 > 0 && i-1 <= 0 &&  j+1 > blocksCol && i+1 <= blocksRow)
                A = [zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2) zeros(overlapRegion*2,overlapRegion*2)
                    blocks{i,j-1} blocks{i,j} zeros(overlapRegion*2,overlapRegion*2)
                    blocks{i+1,j-1} blocks{i+1,j} zeros(overlapRegion*2,overlapRegion*2)];
            end

%            index_i = i;
%            index_i_foward = mod(i+1,blocksRow+1);
%            index_i_backward = mod(i-1,blocksRow+1);
%            
%            if(index_i_foward == 0)
%             index_i_foward = index_i_foward + 1;
%            end
%            
%            if(index_i_backward == 0)
%             index_i_backward = index_i_backward + blocksRow;
%            end
%          
%            index_j = j;
%            index_j_foward = mod(j+1,blocksCol+1);
%            index_j_backward = mod(j-1,blocksCol+1);
%            
%            if(index_j_foward == 0)
%             index_j_foward = index_j_foward + 1;
%            end
%            
%            if(index_j_backward == 0)
%             index_j_backward = index_j_backward + blocksCol;
%            end
%            
%            
%            A = [blocks{index_i_backward,index_j_foward} blocks{index_i_backward,index_j} blocks{index_i_backward,index_j_backward};
%                  blocks{i,index_j_foward} blocks{index_i,index_j} blocks{index_i,index_j_backward} 
%                  blocks{index_i_foward,index_j_foward} blocks{index_i_foward,index_j} blocks{index_i_foward,index_j_backward}];
           
           
            
            blocksOverlap.data{i,j} = A(overlapRegion+1:((overlapRegion*2)*3)-overlapRegion,overlapRegion+1:((overlapRegion*2)*3)-overlapRegion);
            blocksOverlap.dataf{i,j} = blocksOverlap.data{i,j};
            blocksOverlap.u0 = (blockSize/2)+1;
            blocksOverlap.v0 = (blockSize/2)+1;
            
            blocksOverlap.fr{i,j} = 0;
            blocksOverlap.theta{i,j} = 0;
            blocksOverlap.RP{i,j} = 0;
            blocksOverlap.NP{i,j} = 0;
            blocksOverlap.Q{i,j} = 0;
            blocksOverlap.type{i,j} = 3;
            blocksOverlap.count{i,j} = 0;
            blocksOverlap.F{i,j} = [];
            blocksOverlap.F_m{i,j} = [];
            blocksOverlap.u0 = blockSize+1;
            blocksOverlap.v0 = blockSize+1;
            blocksOverlap.M = 0;
            blocksOverlap.HM{i,j} = blocksOverlap.data{i,j};
            blocksOverlap.HB{i,j} = blocksOverlap.data{i,j};
            blocksOverlap.HM{i,j} = zeros(2*blockSize,2*blockSize);
            blocksOverlap.HB{i,j} = zeros(2*blockSize,2*blockSize);
            blocksOverlap.HM{i,j} = zeros(blockSize,blockSize);
            blocksOverlap.HB{i,j} = zeros(blockSize,blockSize);
            
            blocksOverlap.G = [];
            blocksOverlap.GO{i,j} = [];
            blocksOverlap.DTheta{i,j} = [];
            blocksOverlap.windowSize = 2*blockSize/16;
            blocksOverlap.windowSize = blockSize/16;
            blocksOverlap.HGM{i,j} = [];
            blocksOverlap.Ff{i,j} = [];
            
            
            %figure()
            %imshow(blocks{i,j})
            %figure()
            %imshow(A)
            %figure()
            %imshow(blocksOverlap.data{i,j})
            
            
        end
    end
   
end