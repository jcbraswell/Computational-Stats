% Example 14.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Generate 500 exponential random 
	% variables with lambda = 1.
% This is a Statistics Toolbox function.
x = gamrnd(3,2,1,200);								

% Square Root of X
xroot = sqrt(x);
exp_root_x = mean(xroot);


% Trimmed Mean
srt_x = sort(x);