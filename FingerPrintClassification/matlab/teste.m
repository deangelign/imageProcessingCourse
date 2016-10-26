clc;
%clear;
close all;

windowSize = 31;
sigma = 6;
numberFeature = 3;
opcao = 1; 
applyGaussian = 1;
%samples training 1_1 and 1_4
%image = imread('AmostrasDigitais\db2a2000\1_2.tif');
%image = imread('AmostrasDigitais\db2a2004\1_3.tif');
%image = imread('AmostrasDigitais\db3a2002\1_4.tif');
%image = imread('AmostrasDigitais\db3a2000\1_4.tif');
%image = imread('AmostrasDigitais\db1a2004\1_4.tif');
image = imread('AmostrasDigitais\db1a2000\1_2.tif');

%figure()
%imshow(image);

[nRows nCols nC]= size(image);

if nC > 1
    image = rgb2gray(image);
end
%contadores = [1 1];
%contadores2 = [1 1];
%contadores3 = [1 1];
%pesos = rand(1,4);
%pesos2 = rand(1,4);
path1 = 'classe1\';
path2 = 'classe2\';
path11 = 'classe11\';
path22 = 'classe22\';
iterMax = 10^6; %numero de epocas

[blocks]= createSamples(image,windowSize,opcao);
%contadores = anotarBase(blocks,contadores);
%pesos = trainingClassifier(pesos,path1,path2,contadores,iterMax);
% sample = imread('classe1\3.jpg');
% classe = classify(pesos,sample,sigma)
% [ImageSeg,blocksSeg]= segmentImage1(blocks,pesos);
% figure()
% imshow(ImageSeg)

%contadores2 = anotarBase2(blocks,contadores2,windowSize);
%[pesos2,erros,pesosP,nIter] = trainingClassifier2(pesos2,path11,path22,contadores2,iterMax);
[ImageSeg]= segmentImage2(image,pesos2,windowSize);
figure()
imshow(ImageSeg);

%clusters = criarClusters(2,4);
iterMax = 10^5;
%clusters = clusteringKmeans(clusters,path1,path2,contadores,iterMax)
%contadores3 = anotarBase2(blocks,contadores3,windowSize);
%[ImageSeg,blocksSeg]= segmentImage3(blocks,clusters);

% figure()
% imshow(ImageSeg);







