% Example 4.4

clear all;close all;
c = 2.109;   % constant 
n=100;  % generate 100 rv's
% set up the arrays to store variates
x = zeros(1,n);  						% random variates
xy = zeros(1,n);						% corresponding y values
rej = zeros(1,n);						% rejected variates
rejy = zeros(1,n); % corresponding y values
irv=1;			
irej=1;
while irv <= n
   y = rand(1);  % random number from g(y)
   u = rand(1);  % random number for comparison
   if u <= 20*y*(1-y)^(3)/c;
      x(irv)=y;
      xy(irv) = u*c;
      irv=irv+1
   else
             rej(irej)= y;
      rejy(irej) = u*c; % really comparing u*c<=2*y
      irej = irej + 1
   end
end
hold on
plot(x,xy,'+')
plot(rej,rejy,'*')
fplot(@(x) 20*x.*(1-x)^(3), [0 1])
hold off