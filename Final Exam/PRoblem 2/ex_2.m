l = 74;

for j = 1:1000
    for i = 1:1000
        x(i) = sum(-log(rand(100,1)));
    end
z(j) = sum(x> l & x <=l+1);
end
figure(1)
histogram(x, 'Normalization', 'probability')
title('Erlang(100,1) Density Histogram')

resampling_method(1,100,74)
figure(2)
histogram(z, 'Normalization', 'probability')
hold on
histogram(poissrnd(1,1,1000), 'Normalization', 'probability')
hold off
legend('Z RV','Poisson RV with Rate 1')
title('Resampling Method')


% 3C
data = zeros(100,1);
for i = 1:100
    x = bootstrp(100,@sum,exprnd(1,100,1));
    data(i) = sum(x>79 & x<=80);
end

hn = 1.06*n^(-1/5)*std(data);
N = 1000;
xs = zeros(1,N);
idx = datasample(data,N);
for i = 1:N
    xs(i) = normrnd(idx(i),hn);
end
xs=round(xs(xs>=0));
histogram(xs, 'Normalization', 'probability')


figure(3)
histogram(xs, 'Normalization', 'probability')
hold on
histogram(poissrnd(1,1,1000), 'Normalization', 'probability')
hold off
legend('Z RV','Poisson RV with Rate 1')
title('Resampling Method')

% resampling_method(1,100,74)
% 
% l = length(z);
% t0 = min(z);
% tm = max(z);
% len = 1000;
% x = linspace(t0,tm,len);
% fhatN = zeros(size(x));
% hn = 1.06*l^(-1/5)*std(z);
% for i=1:l
%    f=exp(-(1/(2*hn^2))*(x-z(i)).^2)/sqrt(2*pi)/hn;
%    fhatN = fhatN+f/(l);
% end
% 
% figure(3)
% plot(x,fhatN)
% hold on
% histogram(poissrnd(1,1,1000), 'Normalization', 'probability')
% hold off
% legend('Kernel Density Estimation','Poisson PDF')
% title('Kernel Density Estimation Method')