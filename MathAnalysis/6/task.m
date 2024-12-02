clear, clc, close;
format longE;

A = [
    0.82    0.34    0.12    -0.15; 
    -0.11   0.77    0.15    -0.32;
    -0.05   0.12    0.86    0.18;
    -0.12   -0.08   -0.06   1.00
];
b = [-1.33;      0.84;      -1.16;     0.57];

Norma_A = norm(A);

C = zeros(4, 1);

for i = 1:4
    C(i,1) = b(i,1) / A(i,i);
end

B = zeros(3, 4);

for i = 1:4
    for j = 1:4
        if (i ~= j)
           B(i,j) = -A(i,j) / A(i,i);
        end
    end
end

Norma_B = norm(B);

xx = [C(1,1); C(2,1); C(3,1); C(4,1)];

c = xx;
buffer = xx(1,1);
xx = c + B * xx;

while round(xx(1,1), 7) ~= round(buffer,7)
    buffer = xx(1,1);
    xx = c + B * xx;
end

fprintf('Полученые решения системы уравнений:\n');
disp(xx);

fprintf('\nПроверка:\n');
[x, n] = jacobi(A, b, 1e-7);
step = 7;
disp(round(x', step));
