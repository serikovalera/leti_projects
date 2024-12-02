clc
clear
format long

a = 4;
b = 12;
alpha = 2;
runge = [];
eps = 0.000001;
for n = 5 : 10000
    x = linspace(a, b, n);
    h = (b - a)/(n - 1);

    nn = n * 2;
    hh = (b-a)/(nn - 1);
    xx = linspace(a, b, nn);

    sumx = 0;
    for i = 1 : length(x) - 1
      sumx = sumx + ((sin(x(i)) + sin(x(i + 1))) * h) / 2;
    end

    sumxx = 0;
    for i = 1 : length(xx) - 1
      sumxx = sumxx + ((sin(xx(i)) + sin(xx(i + 1))) * hh) / 2;
    end

    
    runge = abs(sumxx -sumx) / (power(2, alpha) - 1);
    
    if runge < eps
      fprintf('Runge = %g\n',runge); 
      richardson = abs(sumxx*(power(2, alpha)) - sumx) / (power(2, alpha) - 1);
      fprintf('Richardson = %g\n',richardson);
      fprintf('Sumx = %g\n',sumx);
      return
    end
end