function [featureVector] = MyextractCentristFeatures(image,cellSize)


[nRows, nCols]= size(image);
w = [128 64 32;16 0 8;4 2 1];
featuresMatrix = uint8(zeros(nRows, nCols));
for i=2:1:nRows-1
    for j=2:1:nCols-1
        
        %cells{ceil(i/8),ceil(j/8)} = image(i:i+cellSize(1)-1,j:j+cellSize(2)-1);
        neighbourhood = image(i-1:i+1,j-1:j+1);
        neighbourhood = logical(neighbourhood <= neighbourhood(2,2));
        vec1 = neighbourhood(:)';
        vec2 = w(:);
        featuresMatrix(i,j) = vec1 * vec2;
        
    end
end
featuresMatrix = featuresMatrix(2:nRows-1,2:nCols-1);

block11 = featuresMatrix(1:16,1:16);
block12 = featuresMatrix(1:16,9:24);
block13 = featuresMatrix(1:16,17:32);

block21 = featuresMatrix(9:24,1:16);
block22 = featuresMatrix(9:24,9:24);
block23 = featuresMatrix(9:24,17:32);

block31 = featuresMatrix(17:32,1:16);
block32 = featuresMatrix(17:32,9:24);
block33 = featuresMatrix(17:32,17:32);

[counts11] = imhist(block11);
[counts12] = imhist(block12);
[counts13] = imhist(block13);

[counts21] = imhist(block21);
[counts22] = imhist(block22);
[counts23] = imhist(block23);

[counts31] = imhist(block31);
[counts32] = imhist(block32);
[counts33] = imhist(block33);

counts11 = counts11/256;
counts12 = counts12/256;
counts13 = counts13/256;
counts21 = counts21/256;
counts22 = counts22/256;
counts23 = counts23/256;
counts31 = counts31/256;
counts32 = counts32/256;
counts33 = counts33/256;

featureVector = [counts11' counts12' counts13' counts21' counts22' counts23' counts31' counts32' counts33'];
end