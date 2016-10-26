clc;
clear;
close all;

image = imread('rice.png');
%figure();
%imshow(image);

[Gx,Gy,G,phaseAngle]=computeGradients(image);
% figure()
% imshow(uint8(abs(Gx)));
% 
% figure()
% imshow(uint8(abs(Gy)));

% figure()
% imshow(uint8(G));
% 
% figure()
% imshow(phaseAngle/(pi/2))

[cells]=createCells(G,phaseAngle);
[block] = createBlocks(cells);