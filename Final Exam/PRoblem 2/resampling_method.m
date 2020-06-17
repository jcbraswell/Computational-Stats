function [] = resampling_method(lamb,N,L)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x = zeros(1000,1);
for j = 1:1000
    for i = 1:1000
        x(i) = sum((1/lamb)*-log(rand(N,1)));
    end
z(j) = sum(x> L & x <=L+1);
end
figure(1)
histogram(x, 'Normalization', 'probability')
title('Erlang(100,1) Density Histogram')


figure(2)
histogram(z, 'Normalization', 'probability')
hold on
histogram(poissrnd(1,1,1000), 'Normalization', 'probability')
hold off
legend('Z RV','Poisson RV with Rate 1')
title('Resampling Method')

end

