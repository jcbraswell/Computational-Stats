
clear all; 
close all; 
clc; 

addpath('C:\Users\Jon\Documents\Statistics\Computational Stats\Toolbox');
load forearm; 

fn = @mean;
B = 1000; 
alpha = 0.05;  
[bootstat] = bootstrp( B, fn, forearm ); 
qhat = quantile( bootstat, [ 0.5*alpha, 1-0.5*alpha ] );
fprintf( 'Mean = %10.5f:\n', mean(forearm) ); 
fprintf( 'Bootstrap estimates of the percentile interval:\n' );
fprintf( '%10.5f', qhat ); fprintf('\n'); 

mu0 = mean(forearm);   
nd = length(forearm);  
std0 = std(forearm);    
meanStd = std0/sqrt(nd);
qhat = norminv( [ 0.5*alpha, 1-0.5*alpha ], mu0, meanStd ); 
fprintf( 'the theoretical estimates of the percentile interval:\n' );
fprintf( '%10.5f', qhat ); fprintf('\n'); 