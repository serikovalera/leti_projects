clc
clear

%   Функция
f = inline('x.^2-5*x+6');
df = inline('2*x-5');

%   График функции
figure;
x=-5 : 0.001 : 3;
plot(x,f(x),'black'); grid on;hold on;

%   Фиксируем х0, задём эпсилон
x0=1.5;
plot(x0,0,'ro');
plot(x,f(x0)+df(x0)*(x-x0),'g--');
degr=5;
eps=10^-degr;

%   Метод
iter=100;
x1=x0-(f(x0)/df(x0));
plot(x1,0,'ro');
for i=1:iter
%     if abs(df(x0))>=1 
%         fprintf('df должна быть меньше 1.\n');
%         break;
%     end
    if (f(x1)==0)
        break;
    end
    x0=x1;
    plot(x,f(x0)+df(x0)*(x-x0),'g--');
    x1=x0-(f(x0)/df(x0));
    plot(x1,0,'ro');
end
rezult=x1;

%   Результат
plot(rezult,f(rezult),'r*');
fprintf('Корень = %g\n',round(rezult*10^degr)/10^degr);
fprintf('Точность = %g\n',eps);

%   Оценка отклонений, скоростьсходимости
x0=1.5;
x1=x0-(f(x0)/df(x0));
Variation=zeros(1,iter);
for i=1:iter
    if (f(x1)==0)
        break;
    end
     a = log(x1-rezult)/log(x0-rezult);
    x0=x1;
    x1=x0-(f(x0)/df(x0));
    Variation(i)=abs(x1-x0);
   
    fprintf('x%g=%g\t\t\t',i,x1);
    fprintf('Variation(%g)=%g\t\t\t',i,Variation(i));
    fprintf('a%g=%g\n',i,a);
end

