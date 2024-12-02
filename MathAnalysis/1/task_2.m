clear, close, clc;
format short;

calculate(0.285, 0.0002, 0.64, 0.004);
calculate(0.2731, 0.0002, 10.8, 0.02);
calculate(5.843, 0.001, 4.17, 0.001);

function [f, f_abs, f_rel] = calculate(h, h_abs, R, R_abs)
    h_rel = h_abs / abs(h);
    R_rel = R_abs / abs(R);

    f = 2 * pi * R^2 * h / 3;
    f_rel = abs(h) * abs(2 * pi * R^2 / 3) / abs(f) * h_rel + ...
        abs(R) * abs(4 * pi * h * R / 3) / abs(f) * R_rel;
    f_abs = abs(f) * f_rel;
   
    disp('Значение функции =');
    disp(f);
    
    disp('Абсолютная погрешность =');
    disp(f_abs);
    
    disp('Относительная погрешность в % =');
    disp(f_rel * 100);
    fprintf('\n');
end
