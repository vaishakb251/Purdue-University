function spl1(x,y,c)
% This MATLAB function finds the value at c of the
% first-degree spline that interpolates data points 
% represented by x and y.

% First degree spline and value at c.
n=length(x);
for i=n-1:-1:1
   dis=c-x(i);
   if(dis>=0)
      break
   end
end
m=(y(i+1)-y(i))/(x(i+1)-x(i));
S=y(i)+m*dis;
% Print the results.
disp('                 Linear Spline')
disp('_________________________________________________________')
disp(['        x             y            c = ',num2str(c),'     '])
disp('_________________________________________________________')
for j=1:n
   fprintf('%12.6f  %12.6f ',x(j),y(j))
   if (j==i)
      fprintf('\n                               S(c)= %10.6f',S)
   end
   fprintf('\n')
end
end


 
