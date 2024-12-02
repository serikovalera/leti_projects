clc
clear

a = 1;
b = 3;
for n = 5:20
    clf;
    x = linspace(a, b, 100);
    y = sin(x);
    plot(x, y,'r'); grid on; hold on;
    h = (b - a)/(n - 1);
    for i = 1 : n - 1
        xx = linspace(a + h*(i-1), a + h*i, 100);
        yy = 0 .*xx + sin(a + h*(i-1));
        plot(xx, yy,'blue--');
        xx = a + h*i;
        yy = linspace(0, sin(a + h*(i-1)), length(xx));  
    
        plot([a+h*i a+h*i], [0 sin(a + h*(i-1))],'blue--');
    end
    in = input('', 's');
end