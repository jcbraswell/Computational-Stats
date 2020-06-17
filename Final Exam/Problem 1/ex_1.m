
% Part One

clear all;close all;
n = 100;
step=.1;, range=[0,10];
i=(range(2)-range(1))/step;
xs=linspace(range(1),range(2),i);
ys=arrayfun(@(a) exp(-(a-2)/1)*exp(-exp(-(a-2)/1)),xs);


samp = zeros(1,n);
cum_dens = arrayfun(@(a) extreme_cdf(a),xs);
% 

for i = 1:n
    u = rand(1);
    [k,dist] = dsearchn(cum_dens',u);
    samp(i) = xs(k); 
end

figure(1)
histogram(samp, 'Normalization', 'probability')
hold on
plot(xs,ys)
title('Density Histogram of Random Sample')
legend('Density Histogram of Sample','Theoretical Distribution')


figure(2)
plot(xs,cum_dens)
hold on
cdfplot(samp)
hold off
legend('Theoretical CDF', 'Empirical CDF')
title('Empirical and Theoretical CDFs')



% % % % % % % % % % % % % % % % % % % % % % 

% strg = 'exp(a-sum(x)-sum(exp(a-x)))';
strg = 'prod(exp((a-x)-exp(a-x)))';
L = inline(strg,'x','a');


n = 2000;
theta1 = zeros(1,n);
theta1(1) = rand();
y = samp;
rate=0;
for i = 2:n
        % Generate variate from proposal distribution.
        v = exprnd(theta1(i-1));
        % Generate variate from uniform.
        u = rand(1);
        
        
        % Calculate alpha.
        alpha = min([1,L(y,v)/L(y,theta1(i-1))]);
        
        if u <= alpha
            % Then set the chain to the y.
            theta1(i) = v; rate=rate+1;
        else
            theta1(i) = theta1(i-1);
        end
end


rate
n1=.25*n;
theta1=theta1(n1+1:n);
figure(3)
subplot(2,1,1)
plot(theta1)
title('MCMC of Location Parameter')
subplot(2,1,2)
histogram(theta1, 'Normalization', 'probability')
title('Density Histogram of Location Parameter');


mean = mean(theta1)
stdev = std(theta1)
lower = csquantiles(theta1,.025) 
upper = csquantiles(theta1,.975)
mix_rate = rate/n


t = table; t.mean = [mean]; t.std_dev = [stdev]; t.CI_95 = [lower upper];
t.Mix_rate = [mix_rate]
disp(t)
