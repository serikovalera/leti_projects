function test
clc;
% значения данных
a=0;b=1;n=20;
h=(b-a)/n;
x=a:h:b;
n=length(x);
y=ones(1,n);
y=x.^3;
c=0;
for j=1:n
    z=1;
    for i=1:n
        if j~=i
            z=z.*(x-x(i))/(x(j)-x(i));
        end
    end
    c=c+z*y(j);
end
plot(x,y,'b',x,c,'r--');grid on;
legend('Теоретические значения','Интерполяция Лагранжа');
