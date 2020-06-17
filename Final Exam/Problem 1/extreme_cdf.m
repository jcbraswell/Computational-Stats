function [out] = extreme_cdf(in)
    out = integral(@(x)(exp(-(x-2)/1)*exp(-exp(-(x-2)/1))),...
        -100,in, 'ArrayValued',true);
end