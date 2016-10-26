clc;
close all;
%I = imread('AmostrasDigitais\db2a2000\1_4.tif');
I = imread('classe1\35.jpg');
I2 = imread('classe2\35.jpg');
I3 = imread('classe1\47.jpg');
I4 = imread('classe2\47.jpg');


[features, hogVisualization] = extractHOGFeatures(I,'CellSize',[8 8]);
figure();
imshow(I)
hold on
plot(hogVisualization)

[features2, hogVisualization2] = extractHOGFeatures(I2,'CellSize',[8 8]);
figure();
imshow(I2)
hold on
plot(hogVisualization2)

[features3, hogVisualization3] = extractHOGFeatures(I3,'CellSize',[8 8]);
figure();
imshow(I3)
hold on
plot(hogVisualization3)

[features4, hogVisualization4] = extractHOGFeatures(I4,'CellSize',[8 8]);
figure();
imshow(I4)
hold on
plot(hogVisualization4)

