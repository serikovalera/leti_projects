clc
clear

h = 0.01;
x = -3 : h : 3;
f = sin(x);
fdiff = cos(x);
n=length(x);
plot (x,fdiff,'--Black'); grid on; hold on;

I1 = zeros(1, n-1);
for i = 1 : n-1
    I1(i) = (f(i+1) - f(i)) / h;
end
maxDevI1 = 0;
for i = 1 : n-1
    dev = max(abs(fdiff(i) - I1(i)));
    if (dev > maxDevI1)
        maxDevI1 = dev;
    end
end
plot(x(1:n-1),I1,'red');
fprintf('maxDevI1 = %g\n',maxDevI1);
alphaI1 = log(maxDevI1) / log(h);
fprintf('alphaI1 = %g\n',alphaI1);
cI1 = maxDevI1 / (h);
fprintf('cI1 = %g\n',cI1);


I_1 = zeros(1, n-1);
for i = 2 : n
     I_1(i-1) = (f(i) - f(i-1))/h;
end
maxDevI_1 = 0;
for i = 2 : n
    dev = max(abs(fdiff(i) - I_1(i-1)));
    if (dev > maxDevI_1)
        maxDevI_1 = dev;
    end
end
plot(x(2:n),I_1,'blue');
fprintf('\nmaxDevI_1 = %g\n',maxDevI_1);
alphaI_1 = log(maxDevI_1) / log(h);
fprintf('alphaI_1 = %g\n',alphaI_1);
cI_1 = maxDevI_1 / (h);
fprintf('cI_1 = %g\n',cI_1);




I2 = zeros(1, n-2);
for i = 1 : n-2
    I2(i) = (4*f(i+1)-3*f(i)-f(i+2)) / (2*h);
end
maxDevI2 = 0;
for i = 1 : n-2
    dev = max(abs(fdiff(i) - I2(i)));
    if (dev > maxDevI2)
        maxDevI2 = dev;
    end
end
plot(x(1:n-2),I2,'green');
fprintf('\nmaxDevI2 = %g\n',maxDevI2);
alphaI2 = log(maxDevI2) / log(h);
fprintf('alphaI2 = %g\n',alphaI2);
cI2 = maxDevI2 / (h^2);
fprintf('cI2 = %g\n',cI2);


I_2 = zeros (1, n-2);
for i = 2 : n-1
    I_2(i-1) = (f(i+1) - f(i-1)) / (2*h);
end
maxDevI_2 = 0;
for i = 2 : n-1
    dev = max(abs(fdiff(i) - I_2(i-1)));
    if (dev > maxDevI_2)
        maxDevI_2 = dev;
    end
end
plot(x(2:n-1),I_2,'yellow');
fprintf('\nmaxDevI_2 = %g\n',maxDevI_2);
alphaI_2 = log(maxDevI_2) / log(h);
fprintf('alphaI_2 = %g\n',alphaI_2);
cI_2 = maxDevI_2 / (h^2);
fprintf('cI_2 = %g\n',cI_2);


I4 = zeros(1, n-4);
for i = 2 : n-3
    I4(i - 1) = (-3 * f(i + 3) + 16 * f(i + 2) - 36 * f(i + 1) + 48 * f(i) - 25 * f(i - 1)) / (12 * h); 
end
maxDevI4 = 0;
for i = 1 : n-4
    dev = max(abs(fdiff(i) - I4(i)));
    if (dev > maxDevI4)
        maxDevI4 = dev;
    end
end
plot(x(2:n-3),I4,'magenta');
fprintf('\nmaxDevI4 = %g\n',maxDevI4);
alphaI4 = log(maxDevI4) / log(h);
fprintf('alphaI4 = %g\n',alphaI4);
cI4 = maxDevI4 / (h^4);
fprintf('cI4 = %g\n',cI4);

I_4 = zeros (1, n-4);
for i = 3 : n-2
    I_4(i - 2) = (f(i - 2) - 8 * f(i - 1) + 8 * f(i + 1) - f(i + 2)) / (12 * h);

end
maxDevI_4 = 0;
for i = 3 : n-2
    dev = max(abs(fdiff(i) - I_4(i-2)));
    if (dev > maxDevI_4)
        maxDevI_4 = dev;
    end
end
plot(x(3:n-2),I_4,'cyan');
fprintf('\nmaxDevI_4 = %g\n',maxDevI_4);
alphaI_4 = log(maxDevI_4) / log(h);
fprintf('alphaI_4 = %g\n',alphaI_4);
cI_4 = maxDevI_4 / (h^4);
fprintf('cI_4 = %g\n',cI_4);




