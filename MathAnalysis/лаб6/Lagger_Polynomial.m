clc
clear

N = 5;

P = zeros(N+1,N+1);
P(1,N+1) = 1;
for i = 2 : N+1
  P(i,N+2-i) = 1;
  for j = 1:i-1
    P(i,1: N+1) = P(i,1: N+1) - IntegrationL(conv(P(i,1: N+1),P(j,1: N+1)))/IntegrationL(conv(P(j,1: N+1),P(j,1: N+1))) * P(j,1: N+1);
  end
   P(i,1: N+1) = P(i,1: N+1)/sqrt(IntegrationL(conv(P(i,1: N+1),P(i,1: N+1))));
   
end
disp ("Lagger Polynomial = ");
disp(P( N+1, 1: N+1));
disp ("roots = ");
disp(roots(P(i,1: N+1)));