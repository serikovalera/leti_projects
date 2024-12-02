clear, clc, close;

syms x;

xt = 0.137;
xv = [0.01    0.11    0.16    0.23    0.28    0.39    0.46    0.50];
yv = [9.9182  9.5194  9.1365  8.8769  8.4164  8.0779  7.7530  7.4412];
assert(length(xv) == length(yv));

f1 = div_diff(yv, xv, 1);
f2 = div_diff(f1, xv, 2);
f3 = div_diff(f2, xv, 3);
f4 = div_diff(f3, xv, 4);
f5 = div_diff(f4, xv, 5);
f6 = div_diff(f5, xv, 6);
f7 = div_diff(f6, xv, 7);

P = yv(1) ...
    + f1(1) * product(x, xv, 1) ...
    + f2(1) * product(x, xv, 2) ...
    + f3(1) * product(x, xv, 3) ...
    + f4(1) * product(x, xv, 4) ...
    + f5(1) * product(x, xv, 5) ...
    + f6(1) * product(x, xv, 6) ...
    + f7(1) * product(x, xv, 7);

disp('Интерполяционный многочлен Ньютона P(x) = ');
disp(simplify(P));
fprintf('\nP(%f) = %f\n', xt, double(subs(P, x, xt)));
