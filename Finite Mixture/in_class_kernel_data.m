
% 3A
clf
n=1500;
nx = [200,800,500];
mu=[5 10 15];
sigma=[3 1.5 2];
data = zeros(n,1);

data(1:nx(1)) = normrnd(mu(1),sigma(1),nx(1),1);
data(nx(1)+1:nx(1)+nx(2)) = normrnd(mu(2),sigma(2),nx(2),1);
data(nx(1)+nx(2)+1:n) = normrnd(mu(3),sigma(3),nx(3),1);


% 3B
data = exprnd(1,100,1);
n = length(data);
t0 = min(data)-1;
tm = max(data)+1;
len = 1000;
x = linspace(t0,tm,len);
fhatN = zeros(size(x));
hn = 1.06*n^(-1/5)*std(data);
for i=1:n
   f=exp(-(1/(2*hn^2))*(x-data(i)).^2)/sqrt(2*pi)/hn;
   fhatN = fhatN+f/(n);
end

% 3C
N = 1000;
xs = zeros(1,N);
idx = datasample(data,N);
for i = 1:N
    xs(i) = normrnd(idx(i),hn);
end

hist(xs)
    


% 3D
figure(1)
subplot(121)
[cnt,data]=hist(data,20);
bar(data,cnt/n,1,'w')
title('Original Data')
axis([-5 25 0 .2])
hold on
plot(x,fhatN)
hold off

subplot(122)
[cnt,xs]=hist(xs,20);
bar(xs,cnt/N,1,'w')
title('Random Sample from KDE')
axis([-5 25 0 .2])
hold on
plot(x,fhatN)
hold off