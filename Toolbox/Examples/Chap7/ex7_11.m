% Example 7.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

r = normrnd(3,10,[1,20]);
n = length(r);
alpha = 0.1;
B = 1000;
thetahat = median(r);

[bootreps, bootsam] = bootstrp(B,'median',r);
sehats = zeros(size(bootreps));
SE = std(bootreps);					

for i = 1:B
				xstar = r(bootsam(:,i));
   bvals(i) = mom(xstar);
   % Do bootstrap using that sample to estimate SE.
   sehats(i) = std(bootstrp(25,'median',xstar));
end
zvals = (bootreps - thetahat)./sehats;

% Estimate the SE using the bootstrap.

% Get the quantiles.
k = B*alpha/2;
szval = sort(zvals);
tlo = szval(k);
thi = szval(B-k);
% Get the endpoints of the interval.
blo = thetahat-thi*SE;
bhi = thetahat-tlo*SE;
