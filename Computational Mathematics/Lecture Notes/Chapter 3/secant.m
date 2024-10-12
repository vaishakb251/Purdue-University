function [c,iter]=secant(f,x0,x1,tol,n)
% The secant method for solving the equation f(x)=0. 
% The input consits of the function f (input the function in vectorized form), 
% initial quesses x_0 and x_1, error tolerance tol, and maximum number of
% iterrations n.
% The output includes the last approximation od f the root, 
% the number of iterrations to get there, and the graph of the function.
iter=0;
u=f(x0);
v=f(x1);
err=abs(x1-x0);
disp('______________________________________________________________')
disp('iter     xn          f(xn)      f(xn+1)-f(xn)    |xn+1-xn|')
disp('______________________________________________________________')
fprintf('%2.0f  %12.6f  %12.6f\n',iter,x0,u)
fprintf('%2.0f  %12.6f  %12.6f  %12.6f  %12.6f\n',iter,x1,v,v-u,err)
while (err>tol)&&(iter<=n)&&((v-u)~=0)
      x=x1-v*(x1-x0)/(v-u);
      x0=x1;
      u=v;
      x1=x;
      v=f(x1);
      err=abs(x1-x0);
      iter=iter+1;
      fprintf('%2.0f  %12.6f  %12.6f  %12.6f  %12.6f\n',iter,x1,v,v-u,err)
end
if ((v-u)==0)
      disp('Division by zero')
end
if (iter>n)
      disp('Method failed to converge')
end 
c=x1;
% Plot f(x) in the interval [a,b].
fplot(f, [c-5 c+5])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(c,0,'r*')
hold off
grid on
end
 

  
 
      
         
   