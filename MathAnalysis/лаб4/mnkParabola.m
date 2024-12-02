clc
clear

x = 0 : 0.1: 2;
n = length(x);
yfirst = 5*(x.^2) - 2*x + 8;
sigma = 0.3;
u = randn(1,n);

y = zeros(1, length(yfirst));
for i = 1 : length(y)
    y(i) = yfirst(i) + sigma*u(i);
end

A = [n sum(x) sum(x.^2); sum(x) sum(x.^2) sum(x.^3); sum(x.^2) sum(x.^3) sum(x.^4)];
B = [sum(y); sum(x.*y); sum(x.^2.*y)];
X = A\B;
a = X(3);
b = X(2);
c = X(1);

yfit = a*x.^2 + b*x + c;
plot(x,y,'o',x,yfit,'-'); grid on; hold on;
