function p = oip(x,y)
% This function calculates and graphs the interpolation polynomial
% corresponding to the data x, y (x and y must be column vectors of
% the same length, and x_1<x_2<...x_n+1).
if length(x)~=length(y)
    disp('Warning: x and y must be of equal length.')
    return
end
n=length(x)-1;
for i=1:n+1
    for j=1:n+1
        A(i,j)=x(i)^(j-1);
    end
end
P=A\y;
disp('The interpolating polynomial in descending powers is;')
p=P(n+1:-1:1)';
plot(x,y,'r*')
hold on
t=linspace(x(1),x(n+1));
z=polyval(p,t);
plot(t,z,'b-')
hold off
grid on
end

