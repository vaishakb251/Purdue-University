%% Basic 2D Plots: plot
%The basic command for producing a 2D plot is 
%plot(xvalues,yvalues,'style-options')
x=[-2 0 1.5 3 4 7];         %defines vector x.
y=[-3 1 -2 0 1 3];          %defines vector y
plot(x,y)                   %plots y versus x 
%plot(x,y,'--')             %plots y versus x with a dashed line.
                            %Other line styles: ':' dotted, '-.' dash-dot
%plot(x,y,'r')              %plots y versus x with a red solid line.
%Other options: 'r--' red dashed line, 'b:' blue dotted line, etc. . 
%Other colors: y (yellow), m (magenta), c (cyan), g (green)
%plot(x,y,'b--+')           %plots y versus x with a blue dashed line, 
                            %and the (x,y) points are marked by +
                            %Point markers: +, *, x, . , ^, s, d.
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('A basic 2D plot')   %puts a title
grid on                    %puts a grid
%text(8,68,'Note this')     %writes ``Note this'' at the location (8,68)
%axis([0 10 -100 100])      %sets the x-axis from 0 to 10, y-axis from -100 to 100  
%Axis control: axis equal, axis square, axis off
%legend(...,pos)            %writes the legend outside the plot-frame if
                            %pos=-1 and inside if pos=0 (there are also 
                            %other options).
%% Basic 2D Plots
%The basic command for producing a 2D plot is 
%plot(xvalues,yvalues,'style-options')
x=0:.1:10;        %creates vector x. One can also use x=linspace(0,10,101)
y=x.^2.*sin(x);   %calculates vector y
plot(x,y,'b-')    %plots y versus x with a blue solid line
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Graph via plot')   %puts a title
grid on
%% Specialized 2D Plots: fplot (plots 2D functions)
% fplot(FUN,LIMS) plots the function FUN between the x-axis limits
% specified by LIMS = [XMIN XMAX]. 
% fplot(...,'LineSpec') plots with the given line specification. 
% For example, 'r-' plots a red line.
fplot(@(x)sin(x).*x.^2,[-1 1],'r-')
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Graph via fplot')   %puts a title
grid on     
 
%% Specialized 2D Plots: fplot (plots 2D functions)
% fplot(X,Y,LIMS) plots the parameterized curve with coordinates
% X(T), Y(T) for T between the values specified by LIMS = [TMIN TMAX].
fplot(@(t)cos(t),@(t)t.*sin(t),[0 2*pi])
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Graph via fplot')   %puts a title
grid on

%% Specialized 2D Plots: area(x,y)
% Plots y versus x and fills the area between 0 and y.
x=linspace(-3*pi,3*pi,100);
y=sin(x)./x;
area(x,y)
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Graph via area')   %puts a title
grid on
%% Specialized 2D Plots:stem
% stem(X,Y) plots the data sequence Y at the values specified in X.
% stem(...,'LINESPEC') uses the linetype specified for the stems and
% markers. See plot for possibilities.
x = 0:0.1:5;
y = cos(x.^2).*exp(-x);
stem(x,y,'b-')
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic stem plot')   %puts a title
grid on  

%% Specialized 2D Plots: stairs(x,y) 
% Draws a stairstep graph of the elements in vector y at
% the locations specified in x.
x = 0:0.25:10;
y=sin(x);
stairs(x,y) % Please type: help stairs  
            % and see its reference page.
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic stairs plot')   %puts a title
grid on  
%% Specialized 2D Plots:scatter(x,y)
% Creates a plot using circle markers.
year=2016:2023; population=[4.5 4.6 4.8 5 5.2 5.3 5.1 5]; 
scatter(year,population)
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic scatter plot')   %puts a title
grid on

%% Specialized 2D Plots: bar(x,y)
% Draws a bar chart.
x = -3:0.2:3;
y = exp(-x.^2);
bar(x,y) % Please type: help bar  
         % and see the reference page for bar.
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic bar plot')   %puts a title
grid on         
%% Specialized 2D Plots: barh(x,y)
% Draws a horizontal bar chart.
x = -3:0.2:3;
y = exp(-x.^2);
barh(x,y) % Please type: help bar  
         % and see the reference page for bar.
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic barh plot')   %puts a title
grid on         
%% Specialized 2D Plots: histogram
% Takes the values in the vector y and put them into n bins.
y=rand(50,1);
histogram(y,10) % Type: help histogram for much more.
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic histogram plot')   %puts a title
grid on  
%% Specialized 2D Plots: pie
% pie(X,LABELS) specifies text labels for the slices. X must be numeric.
% The number of labels must equal the number of elements in X.
pie([2 4 3 5],{'Mary','John','Steve','Nick'})

%% Specialized 2D Plots: comet
% Displays an animated comet plot of vector y versus x.
x=linspace(0,10*pi,1000);
y=x.*sin(x);
comet(x,y)
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic comet plot')   %puts a title
grid on  
%% Specialized 2D Plots: fimplicit
% Plots the curves where fun(x,y)==0 between the axes limits,
% with a default range of [-5 5].
% fimplicit(fun,LIMS) uses the given limits. 
% LIMS can be [XMIN XMAX YMIN YMAX] or
% [XYMIN XYMAX] with XYMIN <= X <+ XYMAX and XYMIN <= Y <= XYMAX.
 
% fimplicit(...,'LineSpec') plots with the given line specification.
fimplicit(@(x,y) x.^2/4+y.^2/9-1,[-4 4 -4 4],'b-')
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Basic fimplicit plot')   %puts a title
grid on  
%% Specialized 2D Plots: polar 
% Makes a plot using polar coordinates of
% the angle theta, in radians, versus the radius r.
% polar(theta, r, S) uses the linestyle specified in string S.
% See the comand plot (above) for a description of legal linestyles.
t=linspace(0,2*pi,201);
r=sqrt(abs(2*sin(5*t)));
polar(t,r,'g-*')

%% Specialized 2D Plots: ezpolar 
% Easy to use polar coordinate plotter.
% ezpolar(fun) plots the polar curve r = fun(theta) over the default
% domain 0 < theta < 2*pi.
% ezpolar(fun,[A,B]) plots fun for A < theta < B.
ezpolar('sqrt(abs(2*sin(5*theta)))',[0 2*pi])

%% Multiple Plots
x=linspace(0,2*pi,201);
y1=sin(x); y2=cos(x); y3=x.*sin(x);
plot(x,y1,'r-+',x,y2,'b--d',x,y3,'m-.x')
legend('y1','y2','y3')
xlabel('x-axis')           %labels the x-axis
ylabel('y-axis')           %labels the y-axis
title('Multiple plots')   %puts a title
grid on  
%% Subplot
% You can display m plots vertically and n plots horizontally 
% in one graphics window by subplot(m,n,p)
% This divides the graphics window into m-by-n rectangles and
% selects the p-th rectangle for the current plot. All the graphics
% commands work as before, but now apply only to this particular
% rectangle in the graphics window. You can “bounce” between
% these different rectangles by calling subplot repeatedly for different
% values of p. If you are comparing a number of plots, it is important
% to have the endpoints of the axes be the same in all the plots. The
% sgtitle function can be used to put a title on the entire Figure Window. 
subplot(2,2,1)
fplot(@(x) x.*sin(x),[0 2*pi])
grid on
subplot(2,2,2)
fplot(@(x)x.*cos(x),[0 4*pi])
grid on
subplot(2,2,3)
fplot(@(x)x.^2.*cos(x)+1,[-pi pi])
grid on
subplot(2,2,4)
pie([2 4 3 5],{'Mary','John','Steve','Nick'})
sgtitle('Example')
figure
%-------------------------------------------------
% 3D Plots
%-------------------------------------------------
%% Basic 3D Plots: plot3
% The basic command for ploting a 3D curve is 
% plot3(xvalues,yvalues,zvalues,'style-options')
t=linspace(0,10*pi,300);
x=cos(t); y=sin(t); z=t;
plot3(x,y,z,'b--*')
grid on
xlabel('x(t)=cos(t)')
ylabel('y(t)=sin(t)')
zlabel('z(t)=t')

%% Specialized 3D Plots: fplot3
% Plots the parametric curve fx(t), fy(t) and fz(t) over the
% interval [tmin, tmax]. The default interval is [-5, 5] if
% the interval is missing.
fplot3(@(t) sin(2*t),@(t) cos(t), @(t) sin(3*t+2), [-pi,pi], '--*')
xlabel('x')
ylabel('y(t)')
zlabel('z(t')

%% Specialized 3D Plots:mesh
% Draws a wireframe mesh of 3D points.
[x,y] = meshgrid(0:.05:2,-4:.05:4);
z = x .* exp(-x.^2 - y.^2);
mesh(z)                    %or mesh(x,y,z)

%% Specialized 3D Plots:surf
% Creates a surface plot by using colors to display the the
% surfaces.
[x,y] = meshgrid(0:0.01:2, -4:0.1:4);
z = x .* exp(-x.^2 - y.^2);
surf(x,y,z)                     %or surf(z)
%Related: surfc; surfl; shading; colormap

%% Specialized 3D Plots:ezsurf
ezsurfc(@(x,y)-5./(1+x.^2+y.^2),[-3,3,-3,3]);
%Related: ezsurfc; comet3; pie3; sphere; etc.

%% Specialized 3D Plots: fimplicit3
% Plots implicit surfaces.
% fimplicit3(fun,limits,’LineSpec’) plots the surface
% fun(x,y,z)=0 between the axes limits with the given line
% specification, using the color for the surface
 fimplicit3(@(x,y,z) x.^2+y.^2+z.^2 - 9,'r--*')
axis equal
% fimplicit3(@(x,y,z) sin(x+y+z)+cos(y-z),[-10 10 -10 10 -10 10])
% fimplicit3(@(x,y,z) x.*(x-1).^2.*(x-2) + y.^3+ z.^3-5,[-10 10 -10 10 -10 10])
% fimplicit3(@(x,y,z)x.^2+y.^2+z.^2-x.*y.*z,[-30 30 -30 30 -30 30])
% fimplicit3(@(x,y,z) x.^2-y.^2-z.^2)
% fimplicit3(@(x,y,z) x.^2-y.^2.*z)
% fimplicit3(@(x,y,z) x.^2.*y.*z+y.^3-z.^3,[-10 10 -10 10 -10 10])

%% Specialized 3D Plots:contour
% Draws level curves.
[x,y] = meshgrid(0:.1:2, -4:.1:4);
z = x .* exp(-x.^2 - y.^2);
cs=contour(x,y,z,[0.1 0.2 0.3 0.4 0.41]);
clabel(cs)

%% Specialized 3D Plots:contour3
% Draws contour curves.
[x,y] = meshgrid(0:.1:2, -4:.1:4);
z = x .* exp(-x.^2 - y.^2);
cs3=contour3(x,y,z,[0.2 0.35 0.4]);
clabel(cs3)
%--------------------------------------------------------------------------