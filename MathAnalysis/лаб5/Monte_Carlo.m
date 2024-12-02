clc 
clear

a = 0;
b = 10;
n = 1000;
h = (b - a) / (n - 1);
x = zeros(1, n);
f = sin(x);


for i = 1 : n
  x(i) = a + h*(i - 1);
end

u = rand(1, n);
sum = 0;
UU = 0;
U = [];
for i = 1 : n
   U(i) = a + ((b - a) * u(i));
   sum = sum + sin(U(i));
   UU =UU + U(i);
end
monte_Carlo = ((b - a) / n) * sum;
fprintf('monte_Carlo = %g\n',monte_Carlo);
t = 3.891;
D = 0;

USr = 1/n * UU;
fprintf('USr = %g\n',USr);

for i = 1 : n
  D = D + power((U(i) - USr),2);
end
D = D/ n;
down = monte_Carlo - t*sqrt(D)/sqrt(n);
up = monte_Carlo + t*sqrt(D)/sqrt(n);

true = -cos(b) + cos(a);

y = linspace(-1,1,10);
plot([down,down], [-1,1], "g--"); grid on; hold on;
plot([up,up], [-1,1], "g--")
plot(monte_Carlo, 0, "r*");
plot(true,0, "o");

index = 1;
alpha_Monte_Carlo = [];

for n = 10 : 500 : 10000
    h = (b - a) / (n - 1);
    x = zeros(1, n);
    for i = 1 : n
        x(i) = a + h*(i - 1);
    end
    f = sin(x);
    u = rand(1, n);
    sum = 0;

    for i = 1 : n
        sum = sum + sin(a + ((b - a) * u(i) ));
    end
    monte_Carlo = ((b - a) / n) * sum;
    alpha_Monte_Carlo(index) = log(max(abs(cos(a) - cos(b) - monte_Carlo))) / log(h);
    index = index + 1;
end
index = index - 1;


figure;
plot(2:index,alpha_Monte_Carlo(2:index), "o-"); grid on; hold on;
fprintf('alpha_Monte_Carlo = %g\n',alpha_Monte_Carlo(index));