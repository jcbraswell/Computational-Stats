p = [.3 .5 .8];
rnd_binom = zeros(1,1000);
for i = 1:1000
    u = rand(1,5);
    rnd_binom(i) = length(find(u<p(1)));
end

for i = 1:length(p)
    fprintf('For p = %10.2f', p(i))
    fprintf('\n')
    fprintf('The theoretical probabilities for (0,1,2,3,4,5) = ')
    fprintf('\n')
    for ii=0:5
      fprintf('%10.6f    ',binopdf(ii,5,p(i)));
    end 
    fprintf('\n')
    
    rnd_binom = zeros(1,1000);
    for j = 1:1000
        u = rand(1,5);
        rnd_binom(j) = length(find(u<p(i)));
    end
    emp_probs = zeros(1,6);
    for k = 0:5
        emp_probs(k+1) =  length(find(rnd_binom == k))/length(rnd_binom);  
    end 
    fprintf('The empirical frequencies for (0,1,2,3,4,5) = ')
    fprintf('\n')
    for ii=1:6
      fprintf('%10.6f    ', emp_probs(ii));
    end 
    fprintf('\n') 
end
