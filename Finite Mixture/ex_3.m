sims = 100;
n = 100;
h = [.1,.5,1,1.5,2];
t0   = -4;
tm   = 4; 
MSEs = zeros(1,length(h));
MAEs = zeros(1,length(h));
x0 = 2;  
for j = 1:length(h)
    rng  = tm-t0; 
    nbin = ceil(rng/h(j));
    bins = t0:h(j):(nbin*h(j)+t0);
      
    [k,dist] = dsearchn(bins',x0);
    errors = zeros(1,sims);

    for i = 1:sims
        x = randn(1,n);
        counts = histc(x,bins);
        fhat = counts/sum(counts);
        errors(i) = fhat(k) - normpdf(x0);
    end
    hist(x,bins)
    MSEs(j) = mean(errors.^2);
    MAEs(j) = mean(abs(errors));
end
MSEs
MAEs
T1 = table(h');
T2 = table(MSEs');
T3 = table(MAEs');
T = table(h',MSEs',MAEs');
T.Properties.VariableNames = {'Bin_Width','MSE','MAE'};
T