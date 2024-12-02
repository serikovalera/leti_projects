function Answer = Lagger(n)
n = n + 1;
P = zeros(n,n);
P(1,n) = 1;
for i = 2 : n
  P(i,n+1-i) = 1;
  for j = 1:i-1
    P(i,1:n) = P(i,1:n) - IntegrationL(conv(P(i,1:n),P(j,1:n)))/IntegrationL(conv(P(j,1:n),P(j,1:n))) * P(j,1:n);
  end
   P(i,1:n) = P(i,1:n)/sqrt(IntegrationL(conv(P(i,1:n),P(i,1:n))));
   
end
P
Answer = P(n, 1:n);
roots(P(i,1:n))
end
