
clear all; 
close all; 
clc; 


n = 25; 

x = randn(1,n); 
B = 1000; 
[m] = bootstrp( B, @mean, x ); 
fprintf( 'The bootstrap estimated standard error of XBar: %10.5f\n', std(m) );

jack = zeros(1,n); 
for i=1:n
  jack(i) = mean( x( setdiff(1:n,i) ) ); 
end

jackmean = mean(jack);  
jackEstStdError = sqrt( ((n-1)/n)*sum( ( jack - jackmean ).^2 ) ); 
fprintf( 'The jackknifed estimated standard error of XBar: %10.5f\n', jackEstStdError ); 

SE = 1/sqrt(n); 
fprintf( 'The theoretical estimated standard error of XBar: %10.5f\n', SE ); 