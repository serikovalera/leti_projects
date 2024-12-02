clc
clear

x = -1:0.01:1;
grid on;hold on;
plot(x, arrayfun(@(x) polyval(chebyshev(3), x), x), 'b');
plot(x, arrayfun(@(x) polyval(chebyshev(4), x), x), 'm');
plot(x, arrayfun(@(x) polyval(chebyshev(5), x), x), 'c');
 
function [T] = chebyshev(n)
    t0 = 1;
    t1 = [1 0];
    
    for i = 1:n - 1
        T = conv([2 0], t1);
        
        for k = 1:length(t0)
            index = length(T) - length(t0) + k;
            T(index) = T(index) - t0(k);
        end
   
        t0 = t1;
        t1 = T;
    end
    disp(T);
end