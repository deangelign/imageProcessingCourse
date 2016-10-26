function featureVector = computeFeatureVector(sample,type)
    
    if(type == 1)%HOG
        featureVector = computeHOG(sample);
    end
    
end