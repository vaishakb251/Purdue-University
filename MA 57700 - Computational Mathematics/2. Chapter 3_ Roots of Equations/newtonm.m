function newtonm(f,x0,tol,n,m)
% Newton's method for solving the nonlinear
% equation f(x)=0. Inputs are; function f, its derivative f',
% an initial guess p0, tolerance tol, and the maximum number
% of iterations n. Here, m is the multiplicity of the root.
f=sym(f);
df=diff(f);
df=matlabFunction(df);
f=matlabFunction(f);
iter=0;
u=f(x0);
v=df(x0);
err=abs(m*u/v);
disp('__________________________________________________________________')
disp(' iter      x_n            f(x_n)          df(x_n)      |x_n+1-x_n|')
disp('__________________________________________________________________')
fprintf('%2.0f  %12.6f  %12.6f  %12.6f\n',iter,x0,u,v)
while (err>tol)&&(iter<=n)&&(v~=0)
      x1=x0-m*u/v;
      err=abs(x1-x0);
      x0=x1;
      u=f(x0);
      v=df(x0);
      iter=iter+1;
      fprintf('%2.0f  %12.6f  %12.6f  %12.6f  %12.6f\n',iter,x0,u,v,err)
end
if (v==0) 
   disp('  Division by zero')     
end
if (iter>n)
   disp('  Method failed to converge')
end
% Plot f(x) in the interval [p0-5,p0+5].
fplot(f, [x0-5 x0+5])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(x0,0,'r*')
hold off
grid on
end
  

    

  
 
      
         
   