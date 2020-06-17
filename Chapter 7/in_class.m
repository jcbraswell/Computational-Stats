clear all;
r = normrnd(2,1,[1,20]);
n = length(r);
alpha = 0.05;
B = 1000;
thetahat = median(r);
standard_results = zeros(1,10);
percentile_results = zeros(1,10);
boot_t_results = zeros(1,10);
for j = 1:100
    %Standard
    bvals = bootstrp(B,'median',r);
    SE = std(bvals);
    blo = median(bvals) - norminv(1-alpha/2,2,1);
    bhi = median(bvals) + norminv(1-alpha/2,2,1);
    standard_results(j) = all(thetahat >= blo & thetahat <= bhi);
    %Percentile
    bvals = bootstrp(B,'median',r);
    k = B*alpha/2;
    sbval = sort(bvals);
    blo = sbval(k);
    bhi = sbval(B-k);
    percentile_results(j) = all(thetahat >= blo & thetahat <= bhi);
    %Boot T
    [bootreps, bootsam] = bootstrp(B,'median',r);
    sehats = zeros(size(bootreps));
    SE = std(bootreps);				
    for i = 1:B
       xstar = r(bootsam(:,i));
       bvals_t(i) = median(xstar);
       sehats(i) = std(bootstrp(25,'median',xstar));
    end
    zvals = (bootreps - thetahat)./sehats;
    k = B*alpha/2;
    szval = sort(zvals);
    tlo = szval(k);
    thi = szval(B-k);
    blo = thetahat-thi*SE;
    bhi = thetahat-tlo*SE;
    boot_t_results(j) = all(thetahat >= blo & thetahat <= bhi);
end
disp( 'The coverage for the standard method is:' )
sum(standard_results)/length(standard_results)
disp( 'The coverage for the percentile method is:' )
sum(percentile_results)/length(percentile_results)
disp( 'The coverage for the boot T method is:' )
sum(boot_t_results)/length(boot_t_results)
