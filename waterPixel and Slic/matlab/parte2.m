clc;
close all;



marker = logical(markers);

inputImage2 = inputImage;
%inputImage2 = imimposemin(inputImage,marker);
%figure()
%imshow(inputImage2);
bw = imbinarize(inputImage2);%apenas matlab 2016
% figure()
% imshow(bw);
D = bwdist(bw);
%D = imimposemin(D,marker);
%figure()
% imshow(D);
DL = watershed(bw);
% 
bgm = DL == 0;
% figure()
% imshow(DL)
% % 
% figure()
% imshow(bgm)

comp = imimposemin(inputImage2,  marker);
% figure()
% imshow(comp)

L = watershed(comp);
bgm2 = L == 0;
% figure()
% imshow(bgm2)


Iout = I(:,:) + (uint8(bgm2)*255);

% Iout(:,:,1) = I(:,:,1) + (uint8(bgm2)*255);
% Iout(:,:,2) = I(:,:,2) + (uint8(bgm2)*255);
% Iout(:,:,3) = I(:,:,3) + (uint8(bgm2)*255);

figure()
imshow(Iout)

% 
% 
