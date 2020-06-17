clear all; 
close all; 
clc; 
addpath('../../Computational Stats/Toolbox')
load elderly;
data = heights;
% Adaptive Density Estimate. Based on histogram guess at 2 distinct groups.
maxterms = 2; 
[pihat_m1,muhat_m1,varhat_m1] = csadpmix(data,maxterms);
xinterp = linspace( min(data)-1.0, max(data)+1.0 ); 
fhat_1 = zeros(1,length(xinterp)); 
for ii=1:length(pihat_m1),
  fhat_1 = fhat_1 + pihat_m1(ii)*normpdf(xinterp,muhat_m1(ii),sqrt(varhat_m1(ii))); 
end
fh=figure; ph1=plot( xinterp, fhat_1, '-og' ); hold on; grid on; 
% Finite Mixture With EM Algo
max_its = 100000; tol = 1e-9; 
[pi_m1_em,mu_m1_em,var_m1_em] = csfinmix(data,muhat_m1,varhat_m1,pihat_m1,max_its,tol); 
xinterp = linspace( min(data)-1.0, max(data)+1.0 ); 
fhat_1 = zeros(1,length(xinterp)); 
for ii=1:length(pi_m1_em),
  fhat_1 = fhat_1 + pi_m1_em(ii)*normpdf(xinterp,mu_m1_em(ii),sqrt(var_m1_em(ii))); 
end
figure(fh); ph2=plot( xinterp, fhat_1, '-xr' ); hold on; grid on; 
%Kernel Desnity Estimation
n = length(data);
t0 = min(data)-1;
tm = max(data)+1;
len = 1000;
xinterp = linspace( min(data)-1.0, max(data)+1.0 ); 
fhatN = zeros(size(xinterp));
hn = 1.06*n^(-1/5)*std(data);
for i=1:n
   f=exp(-(1/(2*hn^2))*(xinterp-data(i)).^2)/sqrt(2*pi)/hn;
   fhatN = fhatN+f/(n);
end
figure(fh); ph3=plot( xinterp, fhatN, '-+m' ); hold on; grid on;
legend( [ph1,ph2,ph3], {'adaptive density estimate','finite mixture model using EM algorithm','kernel density estimate'} ); 