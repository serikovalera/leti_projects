function Answer = Ort(n,a,b,w)
n = n + 1;
P = zeros(n,n);
P(1,n) = 1;
for i = 2 : n
  P(i,n+1-i) = 1;
  for j = 1:i-1
    P(i,1:n) = P(i,1:n) - Integration(conv(P(i,1:n),P(j,1:n)), w,a,b)/Integration(conv(P(j,1:n),P(j,1:n)), w,a,b) * P(j,1:n);
  end
   
end
Answer = P(n, 1:n);
roots(P(i,1:n));
end
