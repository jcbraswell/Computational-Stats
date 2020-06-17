% Example 14.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% 1) Generate r.s of n=3000 using M-H, burn in the first 10%
n = 3000;
a = 2; b = 3; sig = sqrt(a*b^2);
X1 = zeros(1,n);
rate=0;
X1(1) = 2;
for i = 2:n
	y = normrnd(X1(i-1),sig);
	u = rand(1);
   alpha = min([1, gampdf(y, a, b)*normpdf(X1(i-1), y, sig)/...
        (gampdf(X1(i-1), a, b)*normpdf(y, X1(i-1), sig))]);
	if u <= alpha
		X1(i) = y; rate=rate+1;
	else
		X1(i) = X1(i-1);
	end
end  

norm_rate_18 = rate/n

% Burn in 10%
n1=.1*n;
X1=X1(n1+1:n);


%2 Plot the MCMC After Burn-In
figure(1)
plot(X1)
title('MCMC With Normal Candidate Distribution')
X1_Bar = mean(X1)
true_mean = a*b
X1_std = std(X1)
true_std = sqrt(a*b^2)

norm_rate_18 = rate/n
%3 Provide the Normal Kernel Density Estimation

n = length(X1);
hn = 1.06*n^(-1/5)*min(std(X1),iqr(X1)/1.348);
xx = linspace(0, max(X1)+1, 10000);
fhatN = zeros(size(xx));

for i=1:n
   f=exp(-(1/(2*hn^2))*(xx-X1(i)).^2)/sqrt(2*pi)/hn;
   fhatN = fhatN+f/(n);
end
gam = gampdf(xx, a, b);

figure(2)
histogram(X1, 'Normalization', 'probability')
title('Histogram of Sample with Kernel density and True density')

hold on

plot(xx, fhatN, '--g')
plot(xx, gam, '--r')
legend('MCMC Sample (Normal Candidate)', 'Kernel Density', 'Gamma pdf')

hold off

% Find out how the variance affects the mix rate
n = 3000;
a = 2; b = 3; sig = 100;
X1 = zeros(1,n);
rate=0;
X1(1) = 2;
for i = 2:n
	y = normrnd(X1(i-1),sig);
	u = rand(1);
   alpha = min([1, gampdf(y, a, b)*normpdf(X1(i-1), y, sig)/...
        (gampdf(X1(i-1), a, b)*normpdf(y, X1(i-1), sig))]);
	if u <= alpha
		X1(i) = y; rate=rate+1;
	else
		X1(i) = X1(i-1);
	end
end  

norm_rate_1 = rate/n


n = 3000;
a = 2; b = 3; sig = sqrt(50);
X1 = zeros(1,n);
rate=0;
X1(1) = 2;
for i = 2:n
	y = normrnd(X1(i-1),sig);
	u = rand(1);
   alpha = min([1, gampdf(y, a, b)*normpdf(X1(i-1), y, sig)/...
        (gampdf(X1(i-1), a, b)*normpdf(y, X1(i-1), sig))]);
	if u <= alpha
		X1(i) = y; rate=rate+1;
	else
		X1(i) = X1(i-1);
	end
end  

norm_rate_50 = rate/n



%Repeat 1-5 With Exponential Candidate



% 1) Generate r.s of n=3000 using M-H, burn in the first 10%
n = 3000;
a = 2; b = 3;
X2 = zeros(1,n);
rate=0;
X2(1) = 2;
for i = 2:n
	y = exprnd(X2(i-1));
	u = rand(1);
   alpha = min([1, gampdf(y,a,b)*exppdf(X2(i-1),y)/...
       (gampdf(X2(i-1),a,b)*exppdf(y,X2(i-1)))]);
	if u <= alpha
		X2(i) = y; rate=rate+1;
	else
		X2(i) = X2(i-1);
	end
end  

exp_rate = rate/n

% Burn in 10%
n1=.1*n;
X2=X2(n1+1:n);

%2 Plot the MCMC After Burnin
figure(3)
plot(X2)
title('MCMC With Exponential Candidate Distribution')
X2_Bar = mean(X2)
true_mean = a*b
X2_std = std(X2)
true_std = sqrt(a*b^2)
exp_rate
%3 Provide the Normal Kernel Density Estimation


n = length(X2);
hn = 1.06*n^(-1/5)*min(std(X2),iqr(X2)/1.348);
xx = linspace(0, max(X2)+1, 10000);
fhatN = zeros(size(xx));

for i=1:n
   f=exp(-(1/(2*hn^2))*(xx-X2(i)).^2)/sqrt(2*pi)/hn;
   fhatN = fhatN+f/(n);
end
gam = gampdf(xx, a, b);

figure(4)
histogram(X2, 'Normalization', 'probability')
title('Histogram of Sample with Kernel density and True density')

hold on

plot(xx, fhatN, '--g')
plot(xx, gam, '--r')
legend('MCMC Sample (Exponential Candidate)', 'Kernel Density', 'Gamma pdf')



% 
% 
% X2 = zeros(1,n);
% rate=0
% X2(1) = 2;						% generate the starting point
% for i = 2:n
% 	% generate a candidate from the proposal distribution
% 	% which is the normal in this case. This will be a 
% 	% normal with mean given by the previous value in the
% 	% chain and standard deviation of 'sig'
% 	y = exprnd(X2(i-1));
% 	% generate a uniform for comparison
% 	u = rand(1);
% 	alpha = min([1, gam(y,a,b)*exp(X2(i-1),y)/...
%        (gam(X2(i-1),a,b)*exp(y,X2(i-1)))]);
% 	if u <= alpha
% 		X2(i) = y; rate=rate+1;
% 	else
% 		X2(i) = X2(i-1);
% 	end
% end  
% exp_rate = rate/n
% 
% figure(1)
% subplot(2,1,1)
% plot(X1)
% title('MCMC With Normal Candidate')
% subplot(2,1,2)
% plot(X2)
% title('MCMC With Exponential Candidate')
% 
% 
% n1=.1*n;
% X1=X1(n1+1:n);
% X2=X2(n1+1:n);
% 
% 
% figure(2)
% subplot(2,1,1)
% hist(X1)
% title('MCMC With Normal Candidate')
% subplot(2,1,2)
% hist(X2)
% title('MCMC With Exponential Candidate')