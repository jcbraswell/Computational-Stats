% Example 14.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


strg = '1./(1+x.^2)';
cauchy = inline(strg,'x');

% Get the variances for the proposal distributions.
sig1 = .1;
sig2 = .5;
sig3 = 3;
% We will generate 500 iterations of the chain.
n = 500;
% Set up the vectors to store the samples.
X1 = zeros(1,n);
X2 = X1;
X3 = X1;
% Get the starting values for the chains.
X1(1) = 0;
X2(1) = 0;
X3(1) = 0;
rate=0;
% Run the first chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig1 + X1(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = cauchy(y)/cauchy(x(i-1));
		if u <= alpha
			% Then set the chain to the y.
			X1(i) = y; rate=rate+1;
		else
			X1(i) = X1(i-1);
		end
end
rate1=rate/n
rate=0;
% Run second chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig2 + X2(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = cauchy(y)/cauchy(x(i-1));
%         alpha = cauchy(y)/cauchy(X1(i-1));
		if u <= alpha
            			% Then set the chain to the y.
			X2(i) = y; rate=rate+1;
		else
			X2(i) = X2(i-1);
		end
end
rate2=rate/n
rate=0;
% Run the third chain.
for i = 2:n
		% Generate variate from proposal distribution.
		y = randn(1)*sig3 + X3(i-1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = cauchy(y)/cauchy(x(i-1));
		if u <= alpha
			% Then set the chain to the y.
			X3(i) = y; rate=rate+1;
		else
			X3(i) = X3(i-1);
		end
end

rate3=rate/n
figure(1)
subplot(311)
plot(X1)
subplot(312)
plot(X2)
subplot(313)
plot(X3)

n1=.1*n;
X1=X1(n1+1:n);
X2=X2(n1+1:n);
X3=X3(n1+1:n);

%hist(x,30)
n = length(X1);
% Use Normal Reference Rule for bin width.
h = 3.5*std(X1)*n^(-1/3);
% Get the bin mesh. Put some extra space on the ends.
t0 = min(X1) - 1;
tm = max(X1) + 1;
rng = tm - t0;
nbin = ceil(rng/h);
bins = t0:h:(nbin*h + t0);
% Get the bin counts vk.
vk = histc(x,bins);
% Normalize to make it a bona fide density.
fhat = vk/(n*h);
fhat(end) = [];
% To plot this, use bar with the bin centers.
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);
figure(2)
subplot(131)
bar(bc,fhat,1,'w')
axis([-15 15 0 5]);

%hist(x1)
n = length(X2);
% Use Normal Reference Rule for bin width.
h = 3.5*std(X2)*n^(-1/3);
% Get the bin mesh. Put some extra space on the ends.
t0 = min(X2) - 1;
tm = max(X2) + 1;
rng = tm - t0;
nbin = ceil(rng/h);
bins = t0:h:(nbin*h + t0);
% Get the bin counts vk.
vk = histc(x,bins);
% Normalize to make it a bona fide density.
fhat = vk/(n*h);
fhat(end) = [];
% To plot this, use bar with the bin centers.
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);
figure(2)
subplot(132)
bar(bc,fhat,1,'w')
axis([-15 15 0 5]);

%hist(x3)
n = length(X3);
% Use Normal Reference Rule for bin width.
h = 3.5*std(X3)*n^(-1/3);
% Get the bin mesh. Put some extra space on the ends.
t0 = min(X3) - 1;
tm = max(X2) + 1;
rng = tm - t0;
nbin = ceil(rng/h);
bins = t0:h:(nbin*h + t0);
% Get the bin counts vk.
vk = histc(x,bins);
% Normalize to make it a bona fide density.
fhat = vk/(n*h);
fhat(end) = [];
% To plot this, use bar with the bin centers.
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);
figure(2)
subplot(133)
bar(bc,fhat,1,'w')
axis([-15 15 0 5]);
