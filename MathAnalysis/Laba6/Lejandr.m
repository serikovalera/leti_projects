function L = Lejandr(n)

    if n == 0
        L = 1
        x = linspace(-1, 1, 1000);
        plot(x, L);
    else  
        L = [1,0,-1];
        for i = 1 : n-1
            L = conv(L, [1,0,-1]);
        end

        factorialN = 1;

        for i = 1 : n
            maxStep = length(L);
            for k = maxStep : -1 : 2
                L(k) =  L(k-1) * (maxStep-k+1);
            end
            L(1) = [];
            factorialN = factorialN * i;
        end
        L = L.* 1/(power(2,n) * factorialN)
        x = linspace(-1, 1, 1000);
        plot(x, polyval(L, x));
    end
    x = linspace(-1, 1, 1000);
    plot(x, polyval(L, x));
    roots(L)
end

