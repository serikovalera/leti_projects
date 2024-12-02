clear, clc, close;
format short;

syms x;
x_vector = [-1 0 1 2 3];
y_vector = [6 0 2 0 6];

assert(length(x_vector) == length(y_vector))
values = length(x_vector);
L = 0;

for i = 1:values
    coef = 1;
	
    for j = 1:values
        if (j ~= i)
            coef = coef * (x - x_vector(j)) / (x_vector(i) - x_vector(j));
        end
    end
	
    L = L + coef * y_vector(i);
end

disp('Интерполяционный полином Лагранжа:');
disp(simplify(L))
