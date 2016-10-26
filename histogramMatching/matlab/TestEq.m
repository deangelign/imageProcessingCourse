clc;
clear;
close all;


I1 = imread('img (2).jpg');
I2 = imread('img (1).png');
[M1 N1 c1] = size(I1); 
[M2 N2 c2] = size(I2);

numberPixels1 = M1*N1;
numberPixels2 = M2*N2;


if c1>1
    I1 = rgb2gray(I1);
end

if c2>2
    I2 = rgb2gray(I2);
end


figure();
subplot(3,3,1);
imshow(I1);

subplot(3,3,2);
imhist(I1);

subplot(3,3,3);
plot(cumsum(imhist(I1)/numberPixels1));

subplot(3,3,4);
imshow(I2);

subplot(3,3,5);
imhist(I2);

subplot(3,3,6);
plot(cumsum(imhist(I2)/numberPixels2));

subplot(3,3,7);
B = imhistmatch(I2,I1);
imshow(B);

subplot(3,3,8);
imhist(B);

subplot(3,3,9);
plot(cumsum(imhist(B)));




%imhistmatch()