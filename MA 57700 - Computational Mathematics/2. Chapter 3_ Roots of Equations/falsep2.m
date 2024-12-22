function falsep2(f,a,b,tol,n)
% False position method for solving the nonlinear equation f(x)=0. 
% Here, f is the function in vectorized form, [a,b] is the interval, 
% tol=error tolerance, and n=maximum number of iterrations.
% % The output includes the graph of the function and the table of results,
% including the first n approximations.
a0=a;
b0=b;
iter=0;
u=f(a);
v=f(b);
c=(v*a-u*b)/(v-u);
w=f(c);
disp('_______________________________________________________')
disp(' iter     a             c          b            f(p)   ')
disp('_______________________________________________________')
fprintf('\n')
N=n-1;
if (u*v<=0)
   while (abs(w)>tol)&&(abs(b-a)>tol)&&(iter<=N)&&((v-u)~=0)
      w=f(c);
      if w==0
          fprintf('Exact solution is c=%.f\n',c)
          break
      else
      fprintf('%2.0f %10.6f %10.6f  %10.6f  %10.6f\n',iter,a,c,b,w)
      if (w*u<0)
         b=c;v=w;
      else
         a=c;u=w;
      end
      iter=iter+1;
      c=(v*a-u*b)/(v-u);
      end
   end
   if (iter>N)
      disp('  Method failed to converge')
   end
   if (v-u==0)
      disp('  Division by zero')
   end
else
   disp('  The method cannot be applied f(a)f(b)>0')  
end 
% Plot f(x) in the interval [a,b].
fplot(f,[a0 b0])
title('Graph of the function and calculated root')
xlabel('x-axis');ylabel('y-axis');
hold on
plot(c,0,'r*')
hold off
grid on

  
 
      
         
   