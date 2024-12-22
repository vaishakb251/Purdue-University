function spl1graph(x,y)
% This function graphs piecewise linear interpolations.
n=length(x);
for i=1:n-1
    t=linspace(x(i),x(i+1),2);
    m=length(t);
    for j=1:m
        z(j)=spl1simple(x,y,t(j));
    end
    plot(t,z)
    hold on
end
plot(x,y,'*')
hold off
end

