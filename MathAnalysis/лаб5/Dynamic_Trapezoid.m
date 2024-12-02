clc 
clear

a = 0;
b = 10;
n=3;
x=a:0.01:b;
while(n < 50)
    pause();
    clf;
    plot(x, abs(cos(x)),'r'); grid on; hold on;
        h=(b - a)/(n - 1);
        xx=zeros(1,n);
        for i = 1 : n
            xx(i)=a + h*(i-1);
        end
        yy=zeros(1,n);
        for i=1:n
            yy(i)=abs(cos(xx(i)));
        end  
        for i=1:length(xx)-1
            patch([xx(i),xx(i),xx(i+1),xx(i+1)], [0,yy(i),yy(i + 1),0],"blue")
        end
    n = n+2;
end
