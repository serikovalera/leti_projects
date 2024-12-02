function [diff] = div_diff(f, x, shift)
    diff = zeros(1, length(f) - 1);

    for i = 1:length(diff)
        diff(i) = (f(i + 1) - f(i)) / (x(i + shift) - x(i));
    end
end
