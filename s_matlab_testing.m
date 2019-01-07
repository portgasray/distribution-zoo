clear; clc;
n=100;
x= -1;
f = studenttpdf(x, -4.8, 2.5, 5.8);
lf = studenttlogpdf(-1, -2, 3, 1);

x = studenttrnd(-4.8, 2.5, 5.8, [n, 1]);
f = cauchypdf(-3, 10, 1);

x = cauchyrnd(100, 1, [10000,1]);

f = halfcauchypdf(3, 10, 1);

x = halfcauchyrnd(0, 1, [100000,1]);

function f = studenttpdf(x, mu, sigma, nu)
    numer = (nu / (nu + ((x - mu) / sigma)^2))^((nu + 1) / 2);
    f = numer / (sqrt(nu) * sigma * beta(nu / 2, 1 / 2));
end

function f = studenttlogpdf(x, mu, sigma, nu)
    numer = (nu / (nu + ((x - mu) / sigma)^2))^((nu + 1) / 2);
    f = numer / (sqrt(nu) * sigma * beta(nu / 2, 1 / 2));
    f = log(f);
end

function x = studenttrnd(mu, sigma, nu, M)
    y = trnd(nu, M);
    x = sigma * y + mu;
end

function f = cauchypdf(x, a, b)
    f = b ./ (pi * (b.^2 + (x - a).^2));
end

function x = cauchyrnd(a, b, M)
    y = trnd(1, M);
    x = b * y + a;
end


function f = halfcauchypdf(x, a, b)
    if x < 0
        f = 0;
    else
        fun = @(y) b ./ (pi * (b.^2 + (y - a).^2));
        c = integral(fun, 0, Inf);
        f = (1 / c) * b ./ (pi * (b.^2 + (x - a).^2));
    end
end

function x = halfcauchysinglernd(a, b)
    x = cauchyrnd(a, b, 1);
    while x < 0
        x = cauchyrnd(a, b, 1);
    end
end

function x = halfcauchyrnd(a, b, M)
    x = zeros(M);
    n = numel(x);
    y = zeros([n, 1]);
    for i = 1:n
        y(i) = halfcauchysinglernd(a, b);
    end
    x = reshape(y, M);
end