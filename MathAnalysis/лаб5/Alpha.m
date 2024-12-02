clc
clear

alpha_Left_Rect = [];
alpha_Middle_Rect = [];
alpha_Trapezoid = [];
alpha_Simpson = [];

a = 0;
b = 10;

index = 1;
for n = 5 : 5000 : 100000
    
    x = linspace(a, b, n);
    h= (b - a)/(n - 1);

    left_Rect = 0;
    for i = 1 : length(x) - 1
       left_Rect = left_Rect + sin(x(i)) * h; 
    end
    alpha_Left_Rect(index) = log(max(abs((-cos(b) + cos(a)) - left_Rect))) / log(h);

    middle_Rect = 0;
    for i = 1 : length(x) - 1
       middle_Rect = middle_Rect + sin((x(i) + x(i + 1)) / 2) * (x(i + 1) - x(i));
    end
    alpha_Middle_Rect(index) = log(max(abs((-cos(b) + cos(a)) - middle_Rect))) / log(h);

    trapezoid = 0;
    for i = 1 : length(x) - 1
       trapezoid = trapezoid + ((sin(x(i)) + sin(x(i + 1))) * h) / 2; 
    end
    alpha_Trapezoid(index) = log(max(abs((-cos(b) + cos(a)) - trapezoid))) / log(h);

    simpson = 0;
    for i = 1 : length(x) - 1
        simpson = simpson + ((x(i+1)-x(i))/6) * (sin(x(i)) + 4*sin((x(i)+x(i+1))/2) + sin(x(i+1)));
    end
    alpha_Simpson(index) = log(max(abs((-cos(b) + cos(a)) - simpson))) / log(h);
    index = index + 1;
end
index = index - 1;
fprintf('alpha_Left_Rect = %g\n',alpha_Left_Rect(index));
fprintf('alpha_Middle_Rect = %g\n',alpha_Middle_Rect(index));
fprintf('alpha_Trapezoid = %g\n',alpha_Trapezoid(index));
fprintf('alpha_Simpson = %g\n',alpha_Simpson(index));

