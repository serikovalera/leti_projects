clc
clear

hh = zeros (1, 10);
maxDev = zeros(1,10);
for k = 1:20
    x = linspace(-3, 3, 2000*k);
    f = sin(x);
    fdiff = cos(x);
    n = length(x);
    h = x(2) - x(1);

    maxDevI_4 = 0;
    I_4 = zeros(1, n-4);
    for i = 3:n-2
        I_4(i-2) = (f(i-2) - 8*f(i-1) + 8*f(i+1) - f(i+2))/(12*h);
        maxDevI_4 = max(abs(fdiff(i) - I_4(i-2)), maxDevI_4);
    end
    
    hh(k) = h;
    maxDev(k) = maxDevI_4;
end

plot(hh,maxDev); grid on; 
