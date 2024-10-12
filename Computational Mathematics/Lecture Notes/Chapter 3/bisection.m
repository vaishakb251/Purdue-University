function [c,iter] = bisection(f,a,b,tol,n)
% Bisection method for solving the nonlinear 
% equation  f(x)=0 (input the function in vectorized form).
% Here, a and b are the endpoints of the interval [a,b], 
% tol is the error tolerance, and n is maximum number of iterrations.
% The output includes the graph of the function and calculated root.
a0=a;
b0=b; 
iter=0;
u=f(a);
v=f(b);
c=(a+b)*0.5;
err=abs(b-a)*0.5;
disp('_____________________________________________________________________')
disp(' iter    a            c           b           f(c)      err  ')
disp('_____________________________________________________________________')
fprintf('\n')
if (u*v<=0)
   while (err>tol)&&(iter<=n)
      err=abs(b-a)*0.5;
      w=f(c);
      if w==0
          fprintf('Exact solution is p=%.f\n',c)
          break
      else
      fprintf('%2.0f  %10.6f  %10.6f  %10.6f  %10.6f  %10.6f\n',iter,a,c,b,w,err)
      if (w*u<0)
         b=c;v=w;
      else
         a=c;u=w;
      end
      iter=iter+1;
      c=(a+b)*0.5;
      end
   end 
   if (iter>n)
      disp('Method failed to converge')
   end   
else
   disp('The method cannot be applied f(a)f(b)>0')  
end
% Plot f(x) in the interval [a,b].
fplot(f, [a0 b0])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(c,0,'r*')
hold off
grid on
end
 
      
         
   