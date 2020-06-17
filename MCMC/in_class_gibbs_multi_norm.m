
mu = [3;2]; vars = [1.5;1]; stv = sqrt(vars); rho = 0.6/(prod(stv));
xgibbs = zeros(n,2);


n = 5000;


% 
% x1 = mu(1) + stv(1)*normrnd(1,0);
% x2 = mu(2) + rho*(stv(2)/stv(1))*(x1-mu(1))+stv(2)*sqrt(1-rho^2)*normrnd(0,1);
% xgibbs(1,:) = [x1,x2];

for i = 1:n
    if i == 1
        x1 = mu(1) + stv(1)*normrnd(1,0);
    else
        x1 = mu(1) + rho*(stv(1)/stv(2))*(x2-mu(2))+stv(1)*sqrt(1-rho^2)*normrnd(0,1);
    end
    x2 = mu(2) + rho*(stv(2)/stv(1))*(x1-mu(1))+stv(2)*sqrt(1-rho^2)*normrnd(0,1);
    xgibbs(i,:) = [x1,x2];
end
figure(1)
histogram(xgibbs(:,1))
figure(2)
histogram(xgibbs(:,2))
figure(3)
scatter(xgibbs(:,1),xgibbs(:,2))