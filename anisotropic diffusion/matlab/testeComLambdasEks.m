clc;
clear;
close all;


%input images
img1 = imread('img1.png');
img2 = imread('img2.jpg');
img3 = imread('img2.png');
img4 = imread('img4.jpg');
img5 = imread('img5.jpg');
img6 = imread('img6.jpg');
img7 = imread('img7.jpg');
img8 = imread('img8.jpg');
%%%%%%%%%%%%%%%%%%%%
threshold = 0.1;
numberMaxIterations = 100;


%tuning parameters
k = 100.0;
lambda = 0.05;
typeFunction = 1;
%%%%%%%%%%%%
message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 100.0;
lambda = 0.15;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

%tuning parameters
k = 100.0;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 5;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 15;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 25;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

%tuning parameters
k = 5;
lambda = 0.05;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img7...')
[Inew, erroQuadratico, iter] = difusion(img7, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img7_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img8...')
[Inew, erroQuadratico, iter] = difusion(img8, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img8_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
