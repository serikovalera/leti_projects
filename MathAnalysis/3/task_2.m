clear, clc, close;

syms x;
format short;

xt = 2.000;
xv = [1.15      1.55        1.95        2.35        2.75        3.15        3.55        3.95        4.35        4.75];
yv = [66.1659   63.9989     61.9658     60.0551     58.2558     56.5583     54.6807     52.7220     50.5229     48.1091];

f1 = div_diff(yv, xv, 1);
f2 = div_diff(f1, xv, 2);
f3 = div_diff(f2, xv, 3);
f4 = div_diff(f3, xv, 4);
f5 = div_diff(f4, xv, 5);
f6 = div_diff(f5, xv, 6);
f7 = div_diff(f6, xv, 7);
f8 = div_diff(f7, xv, 8);
f9 = div_diff(f8, xv, 9);

P = yv(1) ...
    + f1(1) * product(x, xv, 1) ...
    + f2(1) * product(x, xv, 2) ...
    + f3(1) * product(x, xv, 3) ...
    + f4(1) * product(x, xv, 4) ...
    + f5(1) * product(x, xv, 5) ...
    + f6(1) * product(x, xv, 6) ...
    + f7(1) * product(x, xv, 7) ... 
    + f8(1) * product(x, xv, 8) ... 
    + f9(1) * product(x, xv, 9);

disp('Интерполяционный многочлен Ньютона P(x) = ');
disp(simplify(P));
fprintf('\nP(%f) = %f\n', xt, double(subs(P, x, xt)));
