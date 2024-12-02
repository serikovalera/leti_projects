function [expr] = product(var, x, to)
    expr = 1;
    for i = 1:to
        expr = expr * (var - x(i));
    end
end
