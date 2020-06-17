% Generate Data
major_pop_size = sum(rand(1,200)<=.7);
data = normrnd(10,1,1,major_pop_size);
data = [data, normrnd(5,1,1,200-major_pop_size)];

histogram(data)

% [pies,mus,vars]=csfinmix(data,muin,varin,piesin,max_it,tol);


strg = 'a*normpdf(x,mu1,sig1) + (1-a)*normpdf(x,mu2,sig2)';
L = inline(strg,'x','a','mu1','mu2','sig1','sig2');

n = 2000;
X1 = zeros(1,n);
X1(1) = .5;

rate=0;

mu1 = 5; mu2 = 10; sig1 = 1; sig2 = 1;
for i = 2:n
		% Generate variate from proposal distribution.
		y = rand(1);
		% Generate variate from uniform.
		u = rand(1);
		% Calculate alpha.
		alpha = min([1,prod(L(data,y,mu1,mu2,sig1,sig2))/prod(L(data,X1(i-1),mu1,mu2,sig1,sig2))]);
		if u <= alpha
			% Then set the chain to the y.
			X1(i) = y; rate=rate+1;
		else
			X1(i) =X1(i-1);
		end
end

rate_unif=rate/n;
n1=.1*n;
X1=X1(n1+1:n);


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
axis([-20 20 0 1]);


