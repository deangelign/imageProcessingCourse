function [w_chapeu] = classify2(pesos,sample)
    
    %[nRow nCol]=size(sample);
    %windowSize = nRow;
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

end