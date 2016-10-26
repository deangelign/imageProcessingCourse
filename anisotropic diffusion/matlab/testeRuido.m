clc;
clear;
close all;


%input images
img1 = imread('ruido\img1.jpg');
img2 = imread('ruido\img1.png');
img3 = imread('ruido\img2.png');
img4 = imread('ruido\img4.jpg');
img5 = imread('ruido\img5.jpg');
img6 = imread('ruido\img3.jpg');
%img7 = imread('img7.jpg');
%img8 = imread('img8.jpg');
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
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));
disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 100.0;
lambda = 0.15;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 100.0;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 5;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));



%tuning parameters
k = 15;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultados\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));



%tuning parameters
k = 25;
lambda = 0.25;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));


%tuning parameters
k = 5;
lambda = 0.05;
typeFunction = 1;
%%%%%%%%%%%%

message = strcat('computing for k=', num2str(k), ' lambda=',num2str(lambda), ' erro:', num2str(threshold));
disp(message)

disp('img1...')
[Inew, erroQuadratico, iter] = difusion(img1, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img1_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img2...')
[Inew, erroQuadratico, iter] = difusion(img2, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img2_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img3...')
[Inew, erroQuadratico, iter] = difusion(img3, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img3_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img4...')
[Inew, erroQuadratico, iter] = difusion(img4, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img4_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img5...')
[Inew, erroQuadratico, iter] = difusion(img5, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img5_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

disp('img6...')
[Inew, erroQuadratico, iter] = difusion(img6, lambda, k, typeFunction, threshold, numberMaxIterations);
imwrite(uint8(Inew), strcat('resultadosRuido\','img6_','eye_k=',num2str(k),'_l=',num2str(lambda),'_iter=',num2str(iter),'_erro=',num2str(threshold),'.png'));

