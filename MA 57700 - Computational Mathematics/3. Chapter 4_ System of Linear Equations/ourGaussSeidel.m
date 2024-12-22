function x=ourGaussSeidel(A,b,x0,tol,itmax)
% Solves the system Ax=b by using Gauss-Seidel Method.
fprintf('\n');
disp('      The augmented matrix is =')
Augm=[A b]
n=length(b);
for i=1:n
    if(A(i,i)==0)
 disp('Division by zero. The Gauss-Seidel method cannot be applied.')
 return
    end
end
D=diag(diag(A))
L=tril(A,-1)
U=triu(A,1)
T=-inv(D+L)*U
c=inv(D+L)*b
x=x0;
rerr=100;
k=1;
while k<=itmax && rerr>tol
    x=T*x+c;
   rerr=abs(norm(x-x0))/(norm(x)+eps);
   x0=x;
   k=k+1;
end
% Print the results
if(k==itmax+1)
 disp('No convergence within the error tolerance: allow for more iterations.')
 end
 fprintf('\n');
 disp(['The approximate solution after ',num2str(k-1),' iterations is']);
end


