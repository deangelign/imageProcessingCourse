clc;
%clear;
close all;

path1 = 'classe1\';
path2 = 'classe2\';
%pesos = rand(1,9217);
%pesos = rand(1,1765);
%pesos = rand(1,325);
%pesos = rand(1,37);
%pesos = rand(1,2305);
iter = 1;
tal = 10^4;
n0 = 1*(10^-2);
iterMax = 5*10^4; %numero de epocas
extensao = '.jpg';
seila = 0;
%1 - HOG
%2 - LBP
%3 - CENTRIST
descriptorType = 1;
erros = [0];
nIter = [1];
largeFactor = 1;


while(iter < iterMax)
    
    classType = rand(1);
    if(classType < 0.5)
        d = 1*largeFactor;
        randSample = round(rand(1)*(contadores(1)-1));
        sampleNum  = num2str(randSample);
        filePath = strcat(path1,sampleNum,extensao);
        sample = imread(filePath);
    end
    
    %classe 2
    if(classType >= 0.5)
        d = -1*largeFactor;
        randSample = round(rand(1)*(contadores(2)-2))+1;
        sampleNum  = num2str(randSample);
        filePath = strcat(path2,sampleNum,extensao);
        sample = imread(filePath);
    end
    
    
    %x  = extractHOGFeatures(sample,'cellSize',[8 8]);
    %x = MyextractLBPFeatures(sample,[8 8]);
    x = MyextractCentristFeatures(sample,[8 8]);
    x = [x 1];
    
    w_chapeu = (pesos * x');
    w_chapeu = sign(w_chapeu)*largeFactor;
    
    if(w_chapeu <= 0)
        w_chapeu = -1;
    end
    
    e = d - w_chapeu;
    n = n0/(1 + (iter/tal));
    pesos = pesos + (n*e*x);
    
    
    
    if( mod(iter,10^4) == 0)
        %disp(pesos);
        disp(iter);
        disp(seila);
        erros = [erros seila];
        nIter = [nIter iter];
        seila = 0;
    end
    
    if(e ~= 0)
        seila = seila + 1;
    end
    
    iter = iter + 1;
end
