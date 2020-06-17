r = gamrnd(2,3,1000,1);
n = length(r);
xbar = mean(r);
tol = .0000001;
beta = 1.5;
delta = 1;
iter = 0;
while (abs(delta) > tol )
    I = (2*n)/beta^2;
    U = (n*xbar)/beta^2-((2*n)/beta);
    beta_new = beta + inv(I)*U;
    delta = beta_new - beta;
    beta = beta_new;
    iter = iter + 1;
end

beta