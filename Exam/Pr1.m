addpath('../../Computational Stats/Toolbox')

% Part One

clear all;close all;
n = 200;
step=.1;, range=[-40,40];
i=(range(2)-range(1))/step;
xs=linspace(range(1),range(2),i);
ys=arrayfun(@(a) ((1-exp(-a.^2/2))/(a.^2*sqrt(2*pi))),xs);

samp = zeros(1,n);
cum_dens = arrayfun(@(a) slash_cdf(a),xs);
% plot(xs,y)

for i = 1:n
    u = rand(1);
    [k,dist] = dsearchn(cum_dens',u);
    samp(i) = xs(k); 
end

figure
histogram(samp,'Normalization','probability')
title('Density Histogram of Random Sample')
figure
plot(xs,cum_dens)

hold on
cdfplot(samp)
hold off
legend('Theoretical CDF', 'Empirical CDF')
title('Empirical and Theoretical CDFs')


% Part Two
med = median(samp);
alpha = .05
% 2. Determin a Psuedo Population
normplot(samp)
% Data is normal around the center and so should share a median with a
% normal distribution.  We will use Normal distribution to generate psuedo
% population.

mc = 1000
medians = zeros(1,length(mc))
for i = 1:mc
% 3. Obtain a random sample of size N from the pseudo-population under H0.
% H0: median = 1.  To generate this sample we will use N(1,1).
    mc_data = normrnd(1,1,1,length(samp));
% 4.  Calculate the median for each of these samples.    
    medians(i) = median(mc_data);
% 5. Repeat 3 and 4 M many times.
end

% 6. Using the M values from the pseudo-population, determin the rejection
% region.
ub = csquantiles(medians,alpha/2)
lb = csquantiles(medians,1-alpha/2)
fprintf('The Upper Bound is %f\n', ub);
fprintf('The Lower Bound is %f\n', lb);

if ((med >= lb) && (med<=ub))
    fprintf('Accept the Null Hypothesis')
else
    fprintf('Reject the Null Hypothesis')
end

    
    ;



