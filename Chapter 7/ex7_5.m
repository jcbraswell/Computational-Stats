close all; 
clc; 

addpath('C:\Users\Jon\Documents\Statistics\Computational Stats\Toolbox');
n = length(mcdata); 
sigma = 7.8; 
sigma_xbar = sigma/sqrt(n);
Tobs = (mean(mcdata)-454)/sigma_xbar; 
disp( 'Observed T test statistic:' ); 
Tobs 

M  = 1000; 
Tm = zeros(1,M); 
for i=1:M,
  xs = sigma*randn(1,n) + 454; 
  Tm(i) = (mean(xs)-454)/sigma_xbar;
end

alpha = 0.05; 
disp( 'At significance level alpha = .05, the esitmated quantiles are...' ); 
qhat = csquantiles(Tm,[alpha/2, 1-alpha/2])


