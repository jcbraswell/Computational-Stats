p = [ 0.15, 0.22, 0.33, 0.1, 0.2 ]; 
nSamps = 100;  
nDisc = length(p); 
q = 1/nDisc;
c = max( p )/q; 
tsamps = zeros(1,nSamps); indx=1;
while( indx<=nSamps )
  nu = ceil(nDisc*rand);
  theFrac = p(nu)/(c*q);
  if( rand <= theFrac )
    tsamps(indx)=nu;
    indx=indx+1;
  end
end

fprintf('Relative frequencies for each index = '); 
for ii=1:length(p)
  fprintf('%10.2f    ',length(find(tsamps==ii))/nSamps);
end 
fprintf('\n'); 

