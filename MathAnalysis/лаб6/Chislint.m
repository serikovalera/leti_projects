clc
clear


n = 10;
a = 0;
b = 1;

%b = inf;

w = 1;
disp("roots= ");
Root = roots(Ort(n,a,b,w));
disp(Root);


%Root = roots(Lagger(n));

A = [];
for i = 1 : length(Root)
    A(i) = Integration(coefficients(Root, i),w, a, b);
    %A(i) = IntegrationL(coefficients(Root, i));
end

Sum = 0;

for i = 1 : length(Root)
    Sum = Sum + A(i) * sin(Root(i));
end


Sum
f = @(x) sin(x);
%w = @(x) exp(-x);
w = @(x) power(x, 0);
%w = @(x) sqrt(x);

SumReal = integral(@(x) f(x) .* w(x), a, b)

alpha = log(abs(SumReal - Sum)) / log(abs(1/n))