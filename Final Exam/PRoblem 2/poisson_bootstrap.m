function [z] = poisson_bootstrap(l,data)
%   How often does it take between time l-1 and time l for i events to
%   occur in a process with wait times that are exponentially
%   distributed with intensity lam.
% y = exprnd(lam,i,1);
x = bootstrp(100,@sum,data);
z = sum(x> l & x <=l+1);
end
