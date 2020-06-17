clear all; 
close all; 
clc; 



addpath('C:\Users\Jon\Documents\Statistics\Computational Stats\Toolbox');
load forearm; 

B = 400; 

% for the skewness: 
[bootstat,bootsam] = btsrp_func( B, @skewness, forearm ); 
bt_est = mean( bootstat ); 
std_err = std( bootstat ); 
fprintf( 'Estimated Skewness: %10.5f\n', skewness(forearm) ); 
fprintf( 'Bootstrap SE of this estimate is: %10.5f\n', std_err ); 
fprintf( 'Bootstrap Bias of this estimate is: %10.5f\n', bt_est - skewness(forearm) ); 

% for the kurtosis: 
[bootstat,bootsam] = btsrp_func( B, @kurtosis, forearm ); 
bt_est  = mean( bootstat ); % <- the bootstrap estimate of the mean ... 
std_err = std( bootstat );  % <- the bootstrap estimate of the standard error ... 
fprintf( 'Estimated kurtosis: %10.5f\n', kurtosis(forearm) ); 
fprintf( 'Bootstrap SE of this estimate is: %10.5f\n', std_err ); 
fprintf( 'Bootstrap Bias of this estimate is: %10.5f\n', bt_est - kurtosis(forearm) ); 

% the standard percentile interval for the sample second moment: 
B = 1000; 
[bootstat,bootsam] = btsrp_func( B, @mom, forearm ); 
alpha = 0.05; 
qhat = quantile( bootstat, [ 0.5*alpha, 1-0.5*alpha ] ); 
fprintf( 'Bootstrap interval estimate of the second moment:\n' );
fprintf( '%10.5f', qhat ); fprintf('\n'); 