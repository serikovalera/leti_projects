clc 
clear

 l= 7;
for n = 10000:10010
    a = 0;
    b = 10;
    h = (b-a)/(n-1);
    u = rand(1,n);
    v_r = (b - a)*u + a;
    v_e = -1/l * log(u);
    f = inline("sin(x)");
   
    randI = 0; expI = 0;
    
    for i = 1:n
        randI = randI + (b-a)/n * f(v_r(i));
        expI = expI + (b-a)/n * f(v_e(i));
    end
    disp("alfa_r = ");
    alpha_r = log(abs(-cos(b) + cos(a) - randI))/log(h);
    disp(alpha_r);
    disp("alfa_e = ");
    alfa_e = log(abs(-cos(b) + cos(a) - expI))/log(h);
    disp(alfa_e);

end

fprintf('I_r = %g\n',randI);
fprintf('I_e = %g\n',expI);