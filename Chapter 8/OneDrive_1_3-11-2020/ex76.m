
clear all; 
close all; 
clc; 
M = 1000; 

B_SE = zeros(1,M); 
B_Bias = zeros(1,M); 

J_SE = zeros(1,M); 
J_Bias = zeros(1,M); 

for i=1:M
  n = 100; 
  x = randn(1,n); 
  T = mom(x); 
  B = 1000; 
  [m] = bootstrp( B, @mom, x ); 
  B_SE(i) = std(m); 
  B_Bias(i) = mean(m)-T;
  jack = zeros(1,n); 
  for j=1:n
    jack(j) = mom( x( setdiff(1:n,j) ) ); 
  end
  TJ = mean(jack);  
  jackBias = (n-1)*(TJ-T);
  jackSE = sqrt( ((n-1)/n)*sum( ( jack - TJ ).^2 ) ); 
  J_SE(i) = jackSE;
  J_Bias(i) = jackBias; 
end

figure; 
[N,h] = hist( B_SE ); 
bar(h,N,.25,'g');
hold on; 
[N,h] = hist( J_SE ); 
bar(h,N,.25,'r'); 
title( 'bootstrap (green) and jackknife (red) standard error estimates' )

figure; 
[N,h] = hist( B_Bias ); 
bar(h,N,.25,'g');
hold on; 
[N,h] = hist( J_Bias ); 
bar(h,N,.25,'r'); 
title( 'bootstrap (green) and jackknife (red) bias estimates' )
