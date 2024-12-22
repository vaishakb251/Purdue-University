function fixed2(g,p0,tol,n)
% This is a fixed point iteration method for solving the equation g(x)=x.
iter=0;
v=g(p0);
error=abs(v-p0);
disp('________________________________________________')
disp('iter     p         g(p)    |p_n+1-p_n|')
disp('________________________________________________')
N=n-2;
fprintf('%.0f  %10.6f  %10.6f\n',iter,p0,v)
while (error>tol)&&(iter<=N)
   p1=v;
   error=abs(p1-p0);
   iter=iter+1;
   p0=p1;
   v=g(p0);
   fprintf('%.0f  %10.6f  %10.6f  %10.8f\n',iter,p0,v,error)
end
if (iter>N)
   disp('No convergence. Increase the number of iterrations.')
end  
% Plot f(x) in the interval [p0-5,p0+5].
fplot(g, [p0-5 p0+5])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(p0,0,'r*')
hold off
grid on
end
    

  
 
      
         
   