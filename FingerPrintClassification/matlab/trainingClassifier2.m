function [pesos,erros,pesosP,nIter] = trainingClassifier2(pesos,path1,path2,contadores,iterMax)
    
    pesos = pesos/norm(pesos);
    iter = 1;
    tal = 10^4;
    n0 = 10^-4;
    extensao = '.jpg';
    sigma = 6;
    seila = 0;
    pesosP = [pesos];
    erros = [0];
    nIter = [1];
     while(iter < iterMax)
        classType = rand(1);
        
        %classe1
        if(classType < 0.5)
            d = 1;
            randSample = round(rand(1)*(contadores(1)-2))+1;
            sampleNum  = num2str(randSample);
            filePath = strcat(path1,sampleNum,extensao);
            sample = imread(filePath);
        end
        
        %classe 2
        if(classType >= 0.5)
            d = -1;
            randSample = round(rand(1)*(contadores(2)-2))+1;
            sampleNum  = num2str(randSample);
            filePath = strcat(path2,sampleNum,extensao);
            sample = imread(filePath);
        end
        
        %windowSize = size(sample,1);
        %h_gauss = fspecial('gaussian', windowSize, sigma);
        %sample = imfilter(sample,h_gauss,'replicate');
            
        [Gx, Gy] = imgradientxy(sample);
        Gxx = sum(Gx(:) .* Gx(:));
        Gyy = sum(Gy(:) .* Gy(:));
        Gxy = sum(Gx(:) .* Gy(:));
        aux1 = Gxx - Gyy;
        aux2 = 4*(Gxy^2);
        aux3 = Gxx + Gyy;
        num = sqrt((aux1^2) + aux2);
        den = aux3;
        Coh = num/den;
        meanB = mean(sample(:));
        varB = var(double(sample(:)));
        x = [Coh meanB varB 1];
        w_chapeu = (pesos * x');
        w_chapeu = sign(w_chapeu);
        if(w_chapeu <= 0)
            w_chapeu = -1;
        end
        
        e = d - w_chapeu;
        n = n0/(1 + (iter/tal));
        pesos = pesos + (n*e*x);
        pesos = pesos/norm(pesos);
        if( mod(iter,10^4) == 0)
            disp(pesos);
            disp(iter);
            disp(seila);
            erros = [erros seila];
            nIter = [nIter iter];
            pesosP = [pesosP; pesos];
            seila = 0;
        end
        if(e ~= 0)
            seila = seila + 1;
        end
            
        iter = iter + 1;
    end

end