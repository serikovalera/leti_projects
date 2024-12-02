clear
clc

a = 0;
b = pi;

n = 200;
x = linspace(a,b,n);
f = sin(x);
h = (b-a)/n;

xrand = a + (b-a)*rand(1,n);
yrand = rand(1,n);

sum = 0;
plot(x,f); grid on; hold on;
for i = 1:n
    height = sin(xrand(i));
    area = height*h;
    if yrand(i) <= height
      sum = sum + area;
      color = 'b';
    else
      color = 'r';
    end
    if (color ~='b')
      rectangle('Position', [xrand(i)-h/2 0 h height], 'FaceColor', color, 'EdgeColor', 'none');
    end
end