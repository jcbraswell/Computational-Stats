function [xs] = normal_generator(mu,sig,s_length)
    normal_fn = @(x) exp(-(x-mu).^2/(2*sig^2))/(sig*(sqrt(2*pi)));
    xs = zeros(1,s_length);
    min = mu - 4*sig;
    max = mu + 4*sig;
    x_candidates = min:0.01:max;
    normal_results = cumsum(normal_fn(x_candidates));
    for i = 1:s_length
        u = rand*100;
        xs(i) = x_candidates(find(normal_results >= u,1));
    end
    histogram(xs,s_length/10)

end

