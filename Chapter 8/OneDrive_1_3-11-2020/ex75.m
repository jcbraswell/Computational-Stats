
clear all; 
close all; 
clc; 

n = 15; 

x = rand(1,n); 
B = 1000; 
[m] = bootstrp( B, @mean, x ); 
fprintf( 'The bootstrap estimated standard error is:  %10.5f\n', std(m) );

jack = zeros(1,n);
for i=1:n
  jack(i) = mean( x( setdiff(1:n,i) ) ); 
end

TJ = mean(jack);  
jackEstStdError = sqrt( ((n-1)/n)*sum( ( jack - TJ ).^2 ) ); 
fprintf( 'The jackknifed estimated standard error is: %10.5f\n', jackEstStdError ); 

SE = (1/sqrt(12))/sqrt(n); 
fprintf( 'The theoretical estimated standard error is: %10.5f\n', SE ); 