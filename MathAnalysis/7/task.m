clear, clc, close;
format short;

A = [
    2       1.5     4.5     5.5;
    1.5     3       2       1.6;
    4.5     2       3       1.7;
    5.5     1.6     1.7     3;
];

y = [1; 1; 1; 1];

for i = 1:60
    u = y ./ norm(y);
    y = A * u;
end

lambda = dot(y, u);
str = sprintf("Значение наибольшего по модулю собственного числа, полученного степенным методом = %d", lambda);
disp(str);
fprintf("Собственные значения матрицы А, полученные средствами MatLab:\n")
disp(eig(A));

x = [1; 1; 1; 1];

for i=1:20
    y = (A - lambda * eye(4)) \ x;
    x = y ./ norm(y);
end

fprintf("Собственный вектор, вычисленный методом обратных итераций и соответствующий полученному ранее собственному числу:\n")
disp(x);

[V, D, W] = eig(A);
fprintf("Собственные векторы матрицы А, полученные средствами MatLab:\n")
disp(V);
