%Generate Data
x = gamrnd(3,2,1,200);								

% Square Root of X
root_x = sqrt(x);
exp_root_x = mean(root_x);
var_root_x = var(root_x);

% Trimmed Mean
tr_mean = zeros(1,1000);

for i = 1:1000
    x = gamrnd(3,2,1,200);
    tr_mean(i) = trimmean(x,20);
end

exp_tr_mean= mean(tr_mean);
var_tr_mean = var(tr_mean);


%Third Quartile
q3 = zeros(1,1000);
for i= 1:1000
    x = gamrnd(3,2,1,200);
    quarts = quartiles(x);
    q3(i) = quarts(3);
end

exp_q3= mean(q3);
var_q3 = var(q3);

exp_root_x
var_root_x
exp_tr_mean
var_tr_mean
exp_q3
var_q3