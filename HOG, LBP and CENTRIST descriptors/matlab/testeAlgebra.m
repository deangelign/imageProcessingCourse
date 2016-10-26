clc;
close all;
path1 = 'classe1\';
path2 = 'classe2\';

samplesHOG = [];
samplesLBP = [];
samplesCEN = [];
labels = [];
for i=1:contadores(1)
        
        %classe 1
        d = 1*largeFactor;
        sampleNum  = num2str(i-1);
        filePath = strcat(path1,sampleNum,extensao);
        sample = imread(filePath);
        
        xHOG  = [extractHOGFeatures(sample,'cellSize',[8 8])];
        xHOG  = [xHOG 1];
        xLBP  = MyextractLBPFeatures(sample,[8 8]);
        xLBP  = [xLBP 1];
        xCEN  = MyextractCentristFeatures(sample,[8 8]);
        xCEN  = [xCEN 1];
        samplesHOG = [samplesHOG;xHOG];
        samplesLBP = [samplesLBP;xLBP];
        samplesCEN = [samplesCEN;xCEN];
        labels = [labels; d];
        %classe 2
end

for i=1:contadores(2)
        
        %classe 2
        d = -1*largeFactor;
        sampleNum  = num2str(i-1);
        filePath = strcat(path2,sampleNum,extensao);
        sample = imread(filePath);
        
        xHOG  = [extractHOGFeatures(sample,'cellSize',[8 8])];
        xHOG  = [xHOG 1];
        xLBP  = MyextractLBPFeatures(sample,[8 8]);
        xLBP  = [xLBP 1];
        xCEN  = MyextractCentristFeatures(sample,[8 8]);
        xCEN  = [xCEN 1];
        samplesHOG = [samplesHOG;xHOG];
        samplesLBP = [samplesLBP;xLBP];
        samplesCEN = [samplesCEN;xCEN];
        labels = [labels; d];
end

classifierHOG = fitcecoc(samplesHOG, labels);
classifierLBP = fitcecoc(samplesLBP, labels);
classifierCEN = fitcecoc(samplesCEN, labels);




    