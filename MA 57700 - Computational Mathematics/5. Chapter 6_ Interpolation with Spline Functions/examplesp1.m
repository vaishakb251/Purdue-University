f=@(x) log(x)-cos(2*x)+2*sin(2*pi*x)-0.1*x;
x=linspace(1,5,20);
y=f(x);
plot (x,y,'*')
title ('Piecewise Linear Interpolation')
xlabel('x-axis')
ylabel('y-axis')
grid on
pause
hold on
spl1graph(x,y)
pause
hold on
fplot(f,[1 5],'b--')
hold off