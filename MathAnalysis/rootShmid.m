function rootsShmid = rootShmid(n, a, b)
    n = n + 1;
    A = zeros(n, n);
    for i = 1:n
        A(n-i+1, i) = 1;
    end
    
    A = grShmid(A);
    
    polShmid = A(:,n)';
    roo = roots(polShmid);
    rootsShmid = sort(newRoots([0, 1], [a, b], roo));
end

