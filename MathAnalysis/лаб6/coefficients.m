function c = coefficients(x, i)

n = length(x);
c = 1;

for j = 1 : n
    if j ~= i
        c = conv(c, [1, -x(j)]) / (x(i) - x(j));
    end
end
end