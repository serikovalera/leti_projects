clc
clear

x=[0, 0.5, 1, 1.5, 2, 2.5, 3];
%y=[4, -3, 2, 7, 5, -2, 1];
y=cos(x);
n=length(x);
L=zeros(1,n);
for k=1:n 
    A=1;
    for j=1:n 
        if j~=k 
            A=conv(A,[1/(x(k) - x(j)), -x(j)/(x(k) - x(j))]);
        end
    end
    L=L+y(k).*A;
end

fprintf('L(x)= %1.4fx^%i',L(1),n);
for k=1:n
    fprintf (' + %1.4fx^%i', L(k), n-k);
    
end

fprintf('\nL     = ');
for k=1:n
    fprintf ('%8.4f     ',L);
end

Lmatlab=polyfit(x,y,n-1);
fprintf('\nLmatlab = ');
for k=1:n
    fprintf ('%8.4f     ',Lmatlab);
end

plot(x,y,'r*');grid on; hold on;



fx = min(x)-1 : 0.001 : max(x)+1;
fy = zeros(size(fx));
for k = 1 : n
      fy = fy + L(k).*fx.^(n-k);
end


plot(fx,fy,'black');
plot(fx,fy,'red--');
legend('Исходные значения','Многочлен Лагранжа','Многочлен Лагранжа Матлаб');
