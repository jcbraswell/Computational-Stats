u1 = 0; u2 = -2; v1 = 15; v2 = 10;
a1 = 3; c1 = 1; b1 = 3;
a2 = 2; c2 = 1; b2 = 2;
mu1 = [u1; u2]; mu2 = [v1; v2];

sig1 = [a1 c1 ; c1 b1]; sig2 = [a2 c2 ; c2 b2];

p = 0.3;
n = 5000;

xgibbs = zeros(n,2);

if rand(1) < .3
    mu = mu1; sig = sig1;
else
    mu = mu2; sig = sig2;
end

vars = [sig(1,1);sig(2,2)];
stv=sqrt(vars);
rho = sig(1,2)/(prod(stv));

rho = sig(1,2)/(sqrt(sig(1,1))*sqrt(sig(2,2)));
xgibbs(1,1)=normrnd(mu(1),stv(1));
xgibbs(1,2)=normrnd(mu(2)+rho*stv(2)/stv(1),stv(2)*sqrt(1-rho^2));

for i = 2:n
    x = xgibbs(i-1,1);
    y = xgibbs(i-1,2);
     wx = p*(a1)^(-1/2)*exp(-(x-u1)^2/(2*a1))/(p*(a1)^(-1/2)...
         *exp(-(x-u1)^2/(2*a1))+(1 -p)*(a2)^(-1/2)*exp(-(x-v1)^2/(2*a2)));
    wy = p*(b1)^(-1/2)*exp(-(y-u2)^2/(2*b1))/(p*(b1)^(-1/2)...
        *exp(-(y-u2)^2/(2*b1))+(1-p)*(b2)^(-1/2)*exp(-(y-v2)^2/(2*b2)));
    xgibbs(i,1) = wy*normrnd(u1 + (y-u2)*c1/b1, det(sig1)/b1)...
        +(1-wy)*normrnd(v1+(y-v2)*c2/b2, det(sig2)/b2);
    x = xgibbs(i,1);
    xgibbs(i,2) = wx*normrnd(u2 + (x-u1)*c1/a1, det(sig1)/a1)...
        +(1-wx)*normrnd(v2+(x-v1)*c2/a2, det(sig2)/a2);
end

burn=n*.1;
nMC=n-burn;
MCx=xgibbs(burn+1:n,1);
MCy=xgibbs(burn+1:n,2);


figure(1)
subplot(2,1,1)
plot(MCx)
title('MCMC of X')
subplot(2,1,2)
plot(MCy)
title('MCMC of Y')

figure(2)
subplot(2,1,1)
histogram(MCx, 'Normalization','probability')
title('Density Histogram of X')
subplot(2,1,2)
histogram(MCy, 'Normalization','probability')
title('Density Histogram of Y')

figure(3)
scatter(MCx,MCy)
xlabel('X');ylabel('Y')
title('Scatter Plot of X and Y')

% 
% figure(1)
% plot(xgibbs(:,1))
% figure(2)
% plot(xgibbs(:,2))
% ;
% 
% mean(xgibbs(:,1))
% mean(xgibbs(:,2))
