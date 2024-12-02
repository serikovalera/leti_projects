% Используем упрощенный метод Ньютона

clear, clc, close;
format short;

syms x y;

% Функции преобразованные к виду f(x, y) = 0
F1 = sin(x + y) - 1.6 * x;
F2 = x^2 + y^2 - 1;
F = [F1; F2];

% Начальное приближение
x0 = 0.1;
y0 = 2;

hold on;
grid on;
plot(x0, y0, '*k');

J = jacobian(F);
J_0 = eval(subs(J, {x, y}, {x0, y0}));
J_inv = inv(J_0);

eps = 1e-10;
diff = 2 * eps;
prev = [x0; y0];
i = 1;

while diff > eps
    fprintf("Итерация %d\n", i);
    current = prev - J_inv * eval(subs(F, {x, y}, {prev(1), prev(2)}));
    diff = norm(current - prev);
    line([prev(1), current(1)], [prev(2), current(2)], 'LineStyle', '--');
    prev = current;
    i = i + 1;
end

ezplot(F1);
ezplot(F2);
plot(current(1), current(2), '*k');
fprintf("Решение системы: (%.3g, %.3g)\n", current(1), current(2));
