function [x, n] = jacobi(A, B, eps)
    x = [0 0 0 0];
    n = 4;
    normVal = Inf;
    tol = eps;
    iter = 0;

    while normVal > tol
        xOld = x;
        
        for i = 1:n
            sigma = 0;
            
            for j = 1:n
                if j ~= i
                    sigma = sigma + A(i,j) * x(j);
                end 
            end
            
            x(i) = (1 / A(i,i)) * (B(i) - sigma);
        end
        
        iter = iter + 1;
        normVal = abs(xOld - x);
    end
end
