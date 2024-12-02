clear, clc, close;
format short;

x = [0.45   0.47    0.52    0.61    0.66    0.70    0.74    0.79];
y = [2.5742 2.3251  2.0934  1.8620  1.7493  1.6210  1.3418  1.1212];
xt = 0.665;

P1 = zeros(1, length(x) - 1);

for i = 1:length(P1)
    P1(i) = 1 / (x(i + 1) - x(i)) * det([ ...
            y(i)        (x(i) - xt); ...
            y(i + 1)    (x(i + 1) - xt) ...
        ]);
end
    
P2 = zeros(1, length(P1) - 1);

for i = 1:length(P2)
    P2(i) = 1 / (x(i + 2) - x(i)) * det([ ...
            P1(i)       (x(i) - xt); ...
            P1(i + 1)   (x(i + 2) - xt) ...
        ]);
end

fprintf('f(%f) = %.3f\n', xt, P2(1));
