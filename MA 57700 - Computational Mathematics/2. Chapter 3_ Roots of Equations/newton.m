function newton(f,p0,tol,n)
% Newton's method for solving the nonlinear
% equation f(x)=0. Inputs are; function f, an initial guess p0, 
%tolerance tol, and the maximum number of iterations n.
f=sym(f);
df=diff(f);
df=matlabFunction(df);
f=matlabFunction(f);
iter=0;
u=f(p0);
v=df(p0);
err=abs(u/v);
disp('_____________________________________________________________')
disp(' iter      p            f(p)          df(p)      |pn+1-pn|')
disp('_____________________________________________________________')
fprintf('%2.0f  %12.6f  %12.6f  %12.6f\n',iter,p0,u,v)
while (err>tol)&&(iter<=n)&&(v~=0)
      x1=p0-u/v;
      err=abs(x1-p0);
      p0=x1;
      u=f(p0);
      v=df(p0);
      iter=iter+1;
      fprintf('%2.0f  %12.6f  %12.6f  %12.6f  %12.6f\n',iter,p0,u,v,err)
end
if (v==0) 
   disp('  Division by zero')     
end
if (iter>n)
   disp('  Method failed to converge')
end
% Plot f(x) in the interval [p0-5,p0+5].
fplot(f, [p0-5 p0+5])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(p0,0,'r*')
hold off
grid on
end
  

    

  
 
      
         
   