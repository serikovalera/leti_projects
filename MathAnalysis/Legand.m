function A = Legand(n)
    A = 1;
    for i = 1 : n
        A = conv([1, 0, -1], A);
    end
    sizeA = length(A);
    
    for j = 1:n
        for i = 1 : 2 : sizeA
            A(i) = (sizeA - i)*A(i);
        end
        sizeA = sizeA-1;
        newA = zeros(1, sizeA);
        for i = 1 : 2 : sizeA
            newA(i) = A(i);
        end
        A = newA;
    end

    k = 1/(2^n*fact(n));
    A = A.*k;
end