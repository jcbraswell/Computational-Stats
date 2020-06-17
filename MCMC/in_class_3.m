
% 1. Use MH Sampler

% Generate 100 Samples From Bernoulli with p = 0.2
x = rand(100,1);
data = x>.8;


%Liklihood function
strg = 'theta^y*(1-theta)^(100-y)';
L = inline(strg,'y','theta');

%MCMC
n = 2000;
theta1 = zeros(1,n);
theta1(1) = rand();
y = sum(data);
rate=0;
for i = 2:n
		% Generate variate from proposal distribution.
		v = rand(1);
		% Generate variate from uniform.
		u = rand(1);
        
        
		% Calculate alpha.
		alpha = min([1,L(y,v)/L(y,theta1(i-1))]);
		if u <= alpha
			% Then set the chain to the y.
			theta1(i) = v; rate=rate+1;
		else
			theta1(i) =theta1(i-1);
		end
end

accept_rate_1=rate/n;
n1=.25*n;
theta1=theta1(n1+1:n);
MC_MH_Mean = mean(theta1);
MC_MH_Var = var(theta1);

figure(1)
subplot(2,1,1)
title('MCMC Using M-H Sampler')
plot(theta1)
subplot(2,1,2)
histogram(theta1, 'Normalization', 'probability');
title('Data Generated with the M-H Sampler')

%2 Use known posterior to form a RW MH

theta2 = zeros(1,n);
theta2(1) = rand();
rate = 0;
for i = 2:n
    % Generate variate via random walk
	v = theta2(i-1) + (rand()-0.5)*(1/sqrt(12));
	% Generate variate from uniform.
	u = rand(1);
    a = y + 1; b = 101 - y ;
    alpha = min([1,betapdf(v,a,b)/betapdf(theta2(i-1),a,b)]);

    if u <= alpha
        % Then set the chain to the y.
        theta2(i) = v; rate=rate+1;
    else
        theta2(i) = theta2(i-1);
    end
end
 
accept_rate_2=rate/n
n1=.25*n;
theta2=theta2(n1+1:n)
MC_RW_Mean = mean(theta2)
MC_RW_Var = var(theta2)

figure(2)
subplot(2,1,1)
plot(theta2)
subplot(2,1,2)
histogram(theta2, 'Normalization', 'probability');