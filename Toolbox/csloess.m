function yhat = csloess(x,y,xo,alpha,deg)
% CSLOESS   Basic loess smoothing
%
%   YHAT = CSLOESS(X,Y,XO,ALPHA,DEG)
%
%   This function performs the basic loess smoothing for univariate data.
%   YHAT is the value of the smooth. X and Y are the observed data. XO
%   is the domain over which to evaluate the smooth YHAT. ALPHA is the 
%   smoothing parameter, and DEG is the degree of the local fit (1 or 2).
%
%
%   EXAMPLE:
%   
%   load salmon
%   x = salmon(:,1);
%   y = salmon(:,2);
%   [xs,inds] = sort(x);
%   ys = y(inds);
%   yhat = csloess(xs,ys,xs,0.5,2);
%   plot(xs,ys,'.',xs,yhat)
%
%   See also CSLOCPOLY, CSLOCLIN, CSNARDWATS, CSLOESSR, CSRMEANSMTH, 
%   CSBINSMTH, CSSPLINESMTH


%   W. L. and A. R. Martinez, May 2007
%   CS Toolbox


if deg ~= 1 & deg ~= 2
	error('Degree of local fit must be 1 or 2')
end
if alpha <= 0 | alpha >= 1
	error('Alpha must be between 0 and 1')
end
if length(x) ~= length(y)
	error('Input vectors do not have the same length.')
end

% get constants needed
n = length(x);
k = floor(alpha*n);

% set up the memory
yhat = zeros(size(xo));

% for each xo, find the k points that are closest
for i = 1:length(xo)
	dist = abs(xo(i) - x);
	[sdist,ind] = sort(dist);
	Nxo = x(ind(1:k));	% get the points in the neighborhood
	Nyo = y(ind(1:k));
	delxo = sdist(k);  %% Check this
	sdist((k+1):n) = [];
	u = sdist/delxo;
	w = (1 - u.^3).^3;
	p = wfit(Nxo,Nyo,w,deg);
	yhat(i) = polyval(p,xo(i));
end

function p = wfit(x,y,w,deg)
% This will perform the weighted least squares
n = length(x);
x = x(:);
y = y(:);
w = w(:);
% get matrices
W = spdiags(w,0,n,n);
A = vander(x);
A(:,1:length(x)-deg-1) = [];
V = A'*W*A;
Y = A'*W*y;
[Q,R] = qr(V,0); 
p = R\(Q'*Y); 
p = p';		% to fit MATLAB convention
