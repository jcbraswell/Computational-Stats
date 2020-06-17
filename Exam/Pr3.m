mc = 1000;
est1 = zeros(length(mc));
est2 = zeros(length(mc));
true_val = integral(@(a) exp(a.^2),0,1);
for i = 1:mc
    u = rand(1);
    w = rand(1);
    v = rand(1);
    est1(i) = (exp(u^2)*(1+exp(1-2*u)))/2;
    est2(i) = ((exp(w^2)+exp(v^2)))/2;
    
end
mse_est1 = mean((est1-true_val).^2);
mse_est2 = mean((est2-true_val).^2);