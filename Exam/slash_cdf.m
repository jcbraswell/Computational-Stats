function [out] = slash_cdf(in)
if in == 0
    out = .5;
else
    out = integral(@(x)((1-exp(-x.^2/2))/(x.^2*sqrt(2*pi))),...
        -inf,in, 'ArrayValued',true);
end