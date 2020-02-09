clc;
clear;
clear all;

M = load("exampleSignal.csv");

numOfPeaks = zeros(1,30);

numOfPeaks(1) = numel(findpeaks(M));  %%Without filter one

for i = 2:30
    
    movingfilter = (1/i) * ones(i,1);  %%Moving Average Filter
    output = filter(movingfilter, 1, M); %%Apply the filter
    numOfPeaks(i) = numel(findpeaks(output)); %%Assign the values
    clear output movingfilter ;
    
end

plot(numOfPeaks); %%Plot the figure (Starting from 1, to 30)
