sims = 100;
n = 100;
h = 1;
t0   = -4;
tm   = 4; 
% 
% MSEs = zeros(1,length(h));
% MAEs = zeros(1,length(h));

x0 = 2;  


    rng  = tm-t0; 
    nbin = ceil(rng/h);
    bins = t0:h:(nbin*h+t0);
      
    [k,dist] = dsearchn(bins',x0);
    errors = zeros(1,sims);

    for i = 1:sims
        x = randn(1,n);
        counts = histc(x,bins);
        fhat = counts/sum(counts);
        errors(i) = fhat(k) - normpdf(x0);
    end
    
mean(abs(errors))
%     hist(x,bins)
%     MSE = mean(errors.^2)
%     MAE = mean(abs(errors))
