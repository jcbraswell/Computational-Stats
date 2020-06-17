clear all; 
close all; 
clc; 
addpath('C:\Users\Jon\Documents\Statistics\Computational Stats\Toolbox');
load forearm; 
fn = @mom; 
B = 1000; 
alpha = 0.05; 
[bootstat] = bootstrp( B, fn, forearm ); 
qhat = quantile( bootstat, [ 0.5*alpha, 1-0.5*alpha ] );
fprintf( 'the variance for the forearm data = %10.5f:\n', var(forearm) ); 
fprintf( 'the empirical bootstrap computed estimates percentile interval are given by:\n' );
fprintf( '%10.5f', qhat ); fprintf('\n'); 

