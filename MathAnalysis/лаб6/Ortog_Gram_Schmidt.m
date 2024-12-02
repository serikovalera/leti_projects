clc
clear
format short

w = 1/2;

a = -1;
b = 1;
N = 5;

P = zeros(N+1, N+1);
P(1, :) = 1;

for i = 2 : N+1
    P(i,N+2-i) = 1;
    for k = 1 : i-1
        P(i,1:N+1) = P(i,1:N+1) - Integration(conv(P(i,1:N+1),P(k,1:N+1)), w,a,b)/Integration(conv(P(k,1:N+1),P(k,1:N+1)), w,a,b) * P(k,1:N+1);
    end
end
disp ("Orthogonal Polynomials = ");
disp (real(P));
disp ("roots = ");
disp(roots(real(P(N+1,1:N+1))));