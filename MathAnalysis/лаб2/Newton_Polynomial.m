clc
clear

x=0:1:10;
f=cos(x);
h=x(2)-x(1);

n=length(x)-1;
Deltaf=zeros(1,n-1);
ff=f;
for i=1:length(Deltaf)
    for j=1:length(ff)-i
        ff(j)=ff(j+1)-ff(j);
    end
    Deltaf(i)=ff(1);
end
        

N=zeros(1,n+1);
N(end)=f(1);

for k=1:n-1
     A=1;
    for j=1:k
        A=conv(A,[1,-x(j)]);
    end
    A = A .*Deltaf(k)/(factorial(k) * h^k);
    for i=1:length(A)
          index = n + 1 - length(A) + i;
          N(index) = N(index) + A(i);
    end
end

fprintf('N(x)= %1.4fx^%i',N(1),n);
for k=2:length(N)
    fprintf (' + %1.4fx^%i', N(k), k);
end

fprintf('\nN     = ');
for k=1:n-1
     fprintf ('%8.4f     ',N);
end

xx = 0:0.02:10;
NN = polyval(N, xx);

plot(x,f,'r*');grid on; hold on;

x = 0:0.02:10;
f = cos(x);
NN = arrayfun(@(x) polyval(N, x), x);

Nmatlab=polyfit(x,f,n);
fprintf('\nNmatlab = ');
for k=1:n
    fprintf ('%8.4f     ',Nmatlab);
end

%мфдугы = arrayfun(@(x) polyval(Nmatlab, x), x); 
plot(xx,NN,'black');
plot(x,f,'red--');
legend('Исходные значения','Многочлен Ньютона','Многочлен Ньютона Матлаб');