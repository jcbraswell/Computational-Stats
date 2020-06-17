function [bootstat, bootsam] = btsrp_func(M, func, data)
ndata = length(data);
mu = mean( data ); 
stdv = std( data ); 
bootsam = normrnd(mu,stdv,ndata,M); 
bootstat = func( bootsam ); 
end

