function newtonsys(F,xx0,tol,maxit)
% F is the system given by an (n x 1) matrix 
%(for example @(x,y)[x^3+3*y^2-21;x^2+2*y+2]
% JF is the Jacobian of F given by an (n x n) matrix;
% xx0 is the (n x 1) initial (column) vector, tol is the error tolerance;
% maxit is the maximum number of iterations.
% Example of application:
% newtonsys(@(x,y)[x^3+3*y^2-21;x^2+2*y+2],[1;0],10^-3,10)
F=sym(F);
JF=jacobian(F);
JF=matlabFunction(JF);
F=matlabFunction(F);
x0=xx0;
iter=1;
fprintf('Initial guess/First approximation: x0 = %.f, y0 = %.f\n', x0)
while(iter<=maxit)
   y=-JF(x0(1),x0(2))\F(x0(1),x0(2));
   xn=x0+y;
   disp(xn)
   err= max(abs(xn-x0));
   iter=iter+1;
   if (err<=tol)
      x=xn;
      fprintf('The method converges after %3.0f iterations to\n',iter)
      disp(x)
      return
   else
      x0=xn;
   end
end
disp('The method does not converge; increase the max. number of iterations.')
end