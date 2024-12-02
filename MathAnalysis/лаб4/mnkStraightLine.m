clc
clear

x = 0 : 0.1 : 3;
n = length(x);
yfirst = 5*x + 2;
sigma = 0.3;
u = randn(1,n);

y = zeros(1, length(yfirst));
for i = 1 : length(y)
    y(i) = yfirst(i) + sigma*u(i);
end

A = [n sum(x); sum(x) sum(x.^2)];
B = [sum(y); sum(x.*y)];
X = A\B;
a = X(2);
b = X(1);


yfit = a*x + b;
plot(x,y,'o',x,yfit,'-'); grid on; hold on;

m_x = sum(x) / n;
m_y = sum(y) / n;
K = sum((x - m_x) .* (y - m_y)) / (n - 1); 
d = sum((x - m_x) .^ 2) / n;

Yn1 = m_y + K / d * (x - m_x);
R = Yn1 - y; 
SN = sqrt(sum(R.^2) / (n - 2));
fprintf("SN = %g",SN);
t095 = 1.960;
delta = t095 * SN * (((1 + (x-m_x).^2 / d)) / n).^(1/2);
f1 = Yn1 - delta; 
f2 = Yn1 + delta;
plot(x, f1, 'b--', x, f2, 'b--');
