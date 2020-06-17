function [out] = slash(in)
% 
%     if in == 0
%         out = 1/(2*sqrt(2* pi));
%     else
%         out = ((1-exp(-in^2/2))/(in^2*sqrt(2*pi)));
%     end
% end

if in == 0
    out = .5;
else
    out = integral(@(x)((1-exp(-x.^2/2))/(x.^2*sqrt(2*pi))),...
        -inf,in, 'ArrayValued',true);
end