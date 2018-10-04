function y = conv_rt(x,h)
    Lx = length(x);
    Lh = length(h);
    y = [];
    h_hat = h(end:-1:1);
    x_hat = [zeros(1,Lh-1) x zeros(1, Lh-1)];
    for i = 1:1:Lx+Lh-1
        y = [y sum(h_hat .* x_hat(i:i+Lh-1))];
    end
end