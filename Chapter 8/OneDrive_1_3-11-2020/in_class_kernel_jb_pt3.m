
clf
data = exprnd(5,1,100);
n = length(data);

h = 2.15*sqrt(var(data))*n^(-1/5);
t0 = 0;
tm = max(data)+1;
bins = t0:h:tm;
vk = histc(data,bins);
vk(end) = [];

fhat = vk/(n*h);

bc2=(t0-h/2):h:(tm+h/2);
binh = [0 fhat 0];

xinterp = linspace(min(bc2),max(bc2));
fp = interp1(bc2, binh, xinterp);
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);
bar(bc,fhat,1,'w')
hold on



% axis([30 120 0 0.035])
area = trapz(xinterp,fp);


len = 1000;
x = linspace(0,tm,len);
fhatN = zeros(size(x));
hn = 1.06*n^(-1/5)*std(data);
idx = interp1(x,1:length(x),5,'nearest');
PE_N = zeros(1,100);
for k = 1:100
    fhatN = 0;
    data = exprnd(5,1,100);
    for i=1:n
       f=exp(-(1/(2*hn^2))*(x-data(i)).^2)/sqrt(2*pi)/hn;
       fhatN = fhatN+f/(n);
    end
    PE_N(k) = fhatN(idx);
end
plot(x,fhatN);
fhatE = zeros(size(x));
he = hn*(30*sqrt(pi))^(1/5);

PE_E = zeros(1,100);

for k = 1:100
    fhatE = 0;
    data = exprnd(5,1,100);
    for i=1:n
        dom = (x-data(i))/he;
        for j = 1:len
            if abs(dom(j)) <= 1
                f(j) = (3/4)*(1-((x(j)-data(i))/he).^2)/he;
            else
                f(j) = 0;
            end
        end
       fhatE = fhatE+f/(n);
    end
    PE_E(k) = fhatE(idx);
 
end

% 
% plot(x,fhatN,'b',x,fhatE,'r')
MSE_N = sum((exppdf(5,5) - PE_N).^2)/100;
MSE_E = sum((exppdf(5,5) - PE_E).^2)/100;
fprintf( 'The MSE for the Normal Kernel Density Estimation:  %10.5f\n', MSE_N)
fprintf( 'The MSE for the Epan Kernel Density Estimation:  %10.5f\n', MSE_E)

