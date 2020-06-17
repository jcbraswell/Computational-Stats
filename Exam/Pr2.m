clc;
clear all;close all;
% 300 random variables
n=300; a=2; b=6;
ymax=0.5; n = 300;
x = zeros(1,n);xy = zeros(1,n);						
rej = zeros(1,n);rejy = zeros(1,n);
irv=1; irej=1;
q=0;
while irv < n
    u1=rand(1,1);
    u2=rand(1,1);
    x1=a+u1*(b-a);
    y1=ymax*u2;
    
    if x1 < 3
        f=(x1-2)/2;
    else
        f=(2-(x1/3))/2;
    end
    
    if y1<=f
         x(irv)=x1;
         xy(irv)=y1;
         irv = irv + 1;
         q = q + 1;
    else
        rej(irej) = x1;
        rejy(irej) = y1;
        irej = irej +1;
        q = q + 1;
    end
end
hold on
plot(x,xy,'+')
plot(rej,rejy,'*')
fplot(@(x) (x-2)/2, [2 3])
fplot(@(x) (2-(x/3))/2, [3 6])
xlim([2 6])
hold off
rej_prob = 1 - 300/q
hist(x)