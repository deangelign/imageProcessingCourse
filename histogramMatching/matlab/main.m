clc;
clear;
close all;


%reading input images
sourceImage = imread('img (2).jpg');
TargetImage = imread('img (1).png');

[Iout map] = myHistogramMatching(sourceImage, TargetImage);
myImagePlot(sourceImage);
figure()
stem(map(:,1))
title('mapping')



