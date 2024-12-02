clear, close, clc;
format short;

c = 0.004;
c_rel = 0.001;

alpha = 15;
alpha_rel = 0.01;

p = 0.95;
p_rel = 0.01;

v = 215;
v_rel = 0.01;

s = 20;
s_abs = 0.04;
s_rel = s_abs / abs(s);

f = c * alpha * p * v^2 * s
f_rounded = round(f / 1000, 1) * 1000
f_rel = c_rel + alpha_rel + p_rel + 2 * v_rel + s_rel
f_abs = abs(f) * f_rel
f_abs_rounded = round(f_abs / 1e2, 1) * 1e2

disp('Величина подъемной силы крыла самолета =');
disp(f_rounded);

disp('Абсолютная погрешность =');
disp(f_abs_rounded);

disp('Относительная погрешность в % =');
disp(f_rel * 100);




