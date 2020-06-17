% Example 4.4

clear all;close all;
c = 2.109;
n=100;
x = zeros(1,n);  					
xy = zeros(1,n);						
rej = zeros(1,n);						
rejy = zeros(1,n); 
irv=1;			
irej=1;
while irv <= n
   y = rand(1);  
   u = rand(1);  
   if u <= 20*y*(1-y)^(3)/c;
      x(irv)=y;
      xy(irv) = u*c;
      irv=irv+1
   else
             rej(irej)= y;
      rejy(irej) = u*c; 
      irej = irej + 1
   end
end
hold on
plot(x,xy,'+')
plot(rej,rejy,'*')
fplot(@(x) 20*x.*(1-x)^(3), [0 1])
hold off