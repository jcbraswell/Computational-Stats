
% 2a
n=1500;
nx = [200,800,500];
mu=[5 10 15];
sigma=[3 1.5 2];
data = zeros(n,1);
% Now generate 200 random variables. First find
% the number that come from each component.
data(1:nx(1)) = normrnd(mu(1),sigma(1),nx(1),1);
data(nx(1)+1:nx(1)+nx(2)) = normrnd(mu(2),sigma(2),nx(2),1);
data(nx(1)+nx(2)+1:n) = normrnd(mu(3),sigma(3),nx(3),1);


% 2b
muin = [4 12 16];
% Set mixing coefficients equal.
piesin = [.333 .333 .333];
% Set initial variances to 1.
varin = [2 1 2];
max_it = 100;
tol = 0.0001;
% Call the finite mixtures.
[pies,mus,vars]=...
    csfinmix(data,muin,varin,piesin,max_it,tol);




xx=-5:.1:25;
fhat = zeros(size(xx));
for i=1:3
   fhat = fhat+pies(i)*normpdf(xx,mus(i),sqrt(vars(i)));
end
plot(xx,fhat)



% 2c
N=1500;
x = zeros(N,1);
r = rand(N,1);
% Find the number generated from component 1.
ind1 = length(find(r <= pies(1)));
ind2 = length(find(r <= pies(2)));
% Create some mixture data. Note that the 
% component densities are normals.
x(1:ind1) = normrnd(mus(1),sqrt(vars(1)),ind1,1); 
x(ind1+1:ind2) = normrnd(mus(2),sqrt(vars(2)),ind2-ind1,1); 
x(ind2+1:N) = normrnd(mus(3),sqrt(vars(3)),N-ind2,1); 

% 2d
figure(1)
subplot(121)
[cnt,data]=hist(data,20);
bar(data,cnt/n,1,'w')
title('Original Data')
axis([-5 25 0 .2])
hold on
plot(xx,fhat)
hold off

subplot(122)
[cnt,x]=hist(x,20);
bar(x,cnt/N,1,'w')
title('Random Sample from FM')
axis([-5 25 0 .2])
hold on
plot(xx,fhat)
hold off



