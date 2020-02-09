clc;
clear;
clear all;

hfile = 'mike.wav';                         % This is a string, corresponding to the filename
clear y Fs

[y, Fs] = audioread(hfile);

delayed = delayseq(y, 0.1, Fs); % K = 100 msec (0.1 sec)

noised = y + delayed;

% First Plot Part

result1 = zeros(1,11);
alfavec = 0:0.1:1;
for j=1:11

    alfa = alfavec(j);
    N = 10;
    b = zeros(1,N);
    b(1) = 1;   
    for i=2:N
        b(i) = (-alfa)^(i-1);
    end
    
    output = filter(b,1,noised);
    result1(j) = snr(y,output-y);

end

figure
plot(result1);
title('SNR 1'); 

% Second plot part

clear b ;
alfa2 = 0.5;

% We can use "noised" that we have created since K is the same (0.1)

result2 = zeros(1,50);

for n=1:50
    
    b = zeros(1,n);
    b(1) = 1;   
    for p=2:n
        b(p) = (-alfa2)^(p-1);
    end
    output2 = filter(b,1,noised);
    if n==30
       outputa = output2;
    end
    result2(n) = snr(y,output2-y);
end
figure
plot(result2);
title('SNR 2');

% Third plot part
clear b ;
alfa3 = 0.1;
N3 = 25;
result3 = zeros(1,4);

for q=1:4
    
    delayed = delayseq(y, (q/10), Fs); % K = 100, 200, 300, 400 msec respectively
    noised = y + delayed;
    
    b = zeros(1,N3);
    b(1) = 1;   
    for p=2:N3
        b(p) = (-alfa3)^(p-1);
    end
    output3 = filter(b,1,noised);
    result3(q) = snr(y,output3-y);
    
    clear delayed noised ;
end

figure
plot(result3);
title('SNR 3');

    