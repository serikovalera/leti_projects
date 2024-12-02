clear, clc, close;
format short;

f = @(x) 3 .^ (acot(2 .* x + pi));
left = -pi / 2;
h = 0.1;
right = pi / 2;

x = left:h:right;
n = length(x);
y = f(x);

I = h * ((y(1) + y(end) / 2) + sum(y(2:end - 1)));
I_matlab = integral(f, left, right);

disp("Численный интеграл функции по формуле трапеций:");
disp(I);
disp("Точное значение интеграла:");
disp(I_matlab);
