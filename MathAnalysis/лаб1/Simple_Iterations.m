clc
clear

%   Функция
f = inline('sqrt(x)');
df = inline('1./(2*sqrt(x))');

%   График функции
figure;
x=0.1 : 0.001 : 3;
y=x;
plot(x,f(x),'black',x,y,'g'); grid on;hold on;

%   Фиксируем х0, задём эпсилон
x0=2.7;
plot(x0,f(x0),'ro');
degr=5;
eps=10^-degr;

%   Метод
iter=100;
x1=f(x0);
for i=1:iter
    if (abs(df(x0)))>=1
        fprintf('df должна быть меньше 1.\n');
        break;
    end
    if (abs(x1-x0)<=eps)
        break;
    end
    plot(x0,f(x0),'ro');
    x0=x1;
    x1=f(x0);
end
rezult=x1;

%   Результат
plot(rezult,f(rezult),'r*');
fprintf('Корень = %g\n',round(rezult*10^degr)/10^degr);
fprintf('Точность = %g\n',eps);

%   Оценка отклонений, скорость сходимости
x0=2.7;
x1=f(x0);
Variation=zeros(1,iter);
for i=1:iter
    if (abs(x1-x0)<=eps)
        break;
    end
    a = log(x1-rezult)/log(x0-rezult);
    x0=x1;
    x1=f(x0);
    Variation(i)=abs(x1-x0);
    fprintf('x%g=%g\t\t\t',i,x1);
    fprintf('Variation(%g)=%g\t\t\t',i,Variation(i));
    fprintf('a%g=%g\n',i,a);
end
