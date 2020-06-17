function [z] = poisson_bootstrap(lam,i,l)
%   How often does it take between time l-1 and time l for i events to
%   occur in a process with wait times that are exponentially
%   distributed with intensity lam.
y = exprnd(lam,i,1);
x = bootstrp(1000,@sum,y);
z = sum(x> l & x <=l+1)
end
