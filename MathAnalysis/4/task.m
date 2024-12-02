clear, clc, close;
format short;

matrix_Xi = 0.1:0.2:3.8;
matrix_Fx = [
    -9.0   -7.01   -7.19   -7.11   -7.31   -7.78    -7.64 ...
    -7.85   -8.18   -8.39   -8.79   -9.02   -9.48   -9.93 ...
    -10.26  -10.91  -11.41  -11.91  -12.30
];

Sum_Y = sum(matrix_Fx);
Sum_X = sum(matrix_Xi);

Sum_x2 = sum(matrix_Xi .^ 2);
Sum_x3 = sum(matrix_Xi .^ 3);
Sum_x4 = sum(matrix_Xi .^ 4);

Sum_xy = sum(matrix_Xi .* matrix_Fx);
Sum_x2y = sum((matrix_Xi.^2) .* matrix_Fx);

matrix_line = [20 Sum_X; Sum_X Sum_x2];
matrix_line_rez = [Sum_Y; Sum_xy];
matrix_line_koeff = (matrix_line^(-1)) * matrix_line_rez;

matrix_2 = [20 Sum_X Sum_x2; Sum_X Sum_x2 Sum_x3; Sum_x2 Sum_x3 Sum_x4];
matrix_2_rez = [Sum_Y; Sum_xy; Sum_x2y];
matrix_2_koeff = matrix_2^(-1) * matrix_2_rez;

sum_line = 0;
sum2 = 0;

for n = 1:19
    sum_line = sum_line + (matrix_line_koeff(1,1) + matrix_line_koeff(end,1) * matrix_Xi(1,n) - matrix_Fx(1,n)) .^ 2;
    sum2 = sum2 + (matrix_2_koeff(1,1) + matrix_2_koeff(2,1) * matrix_Xi(1,n) + matrix_2_koeff(3,1) * (matrix_Xi(1,n)^2) - matrix_Fx(1,n)) .^ 2;
end

delta1 = (sum_line / 20) ^ (1 / 2);
delta2 = (sum2 / 20) ^ (1 / 2);

disp(['Многочлен наилучшего приближения Р(х) = ', num2str(matrix_2_koeff(1,1)), ' + ',num2str(matrix_2_koeff(2,1)), 'x + ', num2str(matrix_2_koeff(3,1)), 'x^2']);
disp('Среднее квадратическое уклонение линейной модели:');
disp(delta1);
disp('Среднее квадратическое уклонение квадратичной модели:');
disp(delta2);
