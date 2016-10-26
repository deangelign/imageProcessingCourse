

    a = sumImage{1};


    for i=1:9
        diff{i} = double(sumImage{1}) - double(sumImage{(i+1)});
    end
    
    for k=1:9
        for row=1:size(diff{1},1)
             for col=1:size(diff{1},2)
                 if(diff{k}(row,col) > 127 )
                     a(row,col) = 0;
                 end
             end
        end
        figure()
        imshow(a);
    end