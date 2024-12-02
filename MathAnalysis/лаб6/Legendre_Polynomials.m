clc
clear

 n = 10; 
    L = 1;
    if (~n==0)
        for i = 1 : n
            L = conv([1,0,-1],L);
        end
        for i = 1 : n
            for k = length(L) : -1 : 2
                L(k) =  (length(L)-k+1) * L(k-1);
            end
            L(1) = [];
        end
    x = linspace(-1, 1, 1000);
    plot (x,polyval(L,x)); grid on; hold on; 
    fprintf ("roots of %d Legendre Polynomial = \n", n );
    disp(roots(L));
    end