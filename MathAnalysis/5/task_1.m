clear, clc, close;
format short;

f = @(x) 3 .^ (acot(2 .* x + pi));
df = @(x) 3 .^ (acot(2 .* x + pi)) .* log(3) .* (-1 ./ (1 + (2 .* x + pi) .^ 2)) .* 2; 
ddf = @(x) -2 .* log(3) * (-4 .* (2 .* x + pi) .* 3 .^ (acot(2 .* x + pi)) - 2 .* log(3) .* 3 .^ (acot(2 .* x + pi))) ./ ((2 .* x + pi).^2 + 1) .^ 2;

left = -pi / 2;
h = 0.1;
right = pi / 2;

x = left:h:right;
n = length(x);
y = f(x);

% Первые разностные производные

dy_left = zeros(1, n - 1);
for i = 2:n
   dy_left(i - 1) = (y(i) - y(i - 1)) / h; 
end

dy_right = zeros(1, n - 1);
for i = 1:n - 1
    dy_right(i) = (y(i + 1) - y(i)) / h;
end

dy_center = zeros(1, n - 2);
for i = 2:n - 1
    dy_center(i - 1) = (y(i + 1) - y(i - 1)) / (2 * h);
end

figure;
hold on;
grid on;

plot(x(2:end), dy_left, '--r');
plot(x(1:end - 1), dy_right, ':b');
plot(x(2:end - 1), dy_center, '-.m');
plot(x, df(x), '-k');

title("Сравнение первых разностных производных");
hold off;

% Вторая разностная производная

compare_ddy(left, pi / 5, right, f, ddf);
compare_ddy(left, pi / 25, right, f, ddf);

function [] = compare_ddy(left, h, right, f, ddf)
    x = left:h:right;
    y = f(x);
    n = length(x);
    ddy = zeros(1, n - 2);

    for i = 2:n - 2
        ddy(i - 1) = (y(i - 1) - 2 * y(i) + y(i + 1)) / (h^2);
    end

    figure;
    hold on;
    grid on;
    plot(x(2:end - 1), ddy, '--r');
    plot(x, ddf(x), '-k');
    title(sprintf("Вторая разностная производная с шагом %.g", h))
    hold off;
end
