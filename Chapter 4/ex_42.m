p = [ 0.15, 0.22, 0.33, 0.1, 0.2 ]; 
nSamps = 500;  
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

figure; [N,h] = hist( tsamps, 0:length(p) ); 
bar( h, N/nSamps ); axis( [ 0 6 0 0.5 ] ); grid on; 

