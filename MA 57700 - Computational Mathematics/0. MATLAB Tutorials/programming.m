% MATLAB has four flow control and/or branching instructions: for
% loops, while loops, if-else branching tests, and switch branching
% tests. All of these instructions end with an end statement, and it is
% frequently difficult to determine the extent of these instructions.
% Thus, it is very important to use indentation to indicate the
% structure of a code.

% The for loop is used when it is necessary to repeat statement(s) and when
% it is known ahead of time how many times the statement will be repeated.
% The general form of the for loop is
% for <variable> = <expression>
%   <statement>
%   ...
%   <statement>
% end
% where the variable is often called the index of the loop. The
% elements of the row vector <expression> are stored one at a time
% in the variable and then the statements up to the end statement
% are executed.

%% The for loop
% Example 0: Repeat five times `I will never smoke!'
for i=1:5
    fprintf('I will never smoke!\n')
end
%% The for loop.
% Example 1: Calculate S=sum_{i=1}^100 i^2
tic %tic/toc is a built-in function that determines how long it takes 
    %the code to execute.
S=0;
for i=1:100
    S=S+i^2;
end
fprintf('S=%.f\n',S)
toc
%% The for loop.
% Example 2: Calculate S=sum_{i=1}^100 (-1)^i*(2*i+1)^2
S=0;
for i=1:100
    S=S+(-1)^i*(2*i+1)^2;
end
fprintf('S=%.f\n',S)
%% The for loop. 
% Example 3: Balance $1000. Years 30. Interest 8%. 
bal=1000;
for i=1:30
    bal=bal*1.08;
end
fprintf('bal=%.f\n',bal)

%% The for loop. 
% Example 4: Assume your balance is $1000, and that you deposit $500 
% at the very end of each year. What is the balance after 30 years if
% the annual interest rate is 8%. 
bal=1000;
for i=1:30
    bal=bal*1.08+500;
end
fprintf('bal=%.f\n',bal)

%% The for loop. 
% Example 5: If a_1=2, a_2=1, a_3=1, and a_(n+3)=2a_n-3a_(n+1)+a_(n+2). 
%Write a script that produces a vector containing the first 20 terms of the
% sequence.
a(1)=2;
a(2)=1;
a(3)=1;
for n=1:17
    a(n+3)=2*a(n)-3*a(n+1)+a(n+2);
end
disp(a(1:20)')
%% The for loop. 
% Example 6: Decrement values of the index.
for v=2:-0.25:-3
    p=v+0.2;
    disp(p)
end

%% The for loop. 
% Example 7: Specific values for the index.
s=0;
p=1;
for v=[1 -2 4 6 9]
    s=s+v;
    p=p*v;
end
disp(s), disp(p)

%% The for loop. 
% Example 8:Generate a Hilbert matrix.
n=5;
for i=1:n
    for j=1:n
        H(i,j)=1/(i+j);
    end
end
format rat
disp('H='),disp(H)
format short
%% The for loop. 
% Example 8: Plots of the function f(x)=sin(x)+cos(x) between 0 and 2*pi
% using 10, 20, 30, and 40 points, respectively.
for i=1:4
    x=linspace(0,2*pi,10*i);
    y=sin(x)+cos(x);
    subplot(2,2,i)
    plot(x,y,'*')
    xlabel('x-axis')
    ylabel('y-axis')
    title('sin(x)+cos(x) plot')
    grid on
end
% The sgtitle function puts a title on the entire Figure Window.
sgtitle('sin(x)+cos(x) plots (with different number of points)') 

%% The second MATLAB loop structure is the while statement, 
% which is used as the conditional loop. It is used to repeat an action
% when ahead of time it is not known how many times the action will be
% repeated.
% The general form of the while loop is
% while <logical expression>
%   <statement>
%   ...
%   <statement>
% end
% where the statements are executed repeatedly as long as the
% <logical expression> is true.

%% The while loop.
% Example 1: Calculating eps
eps=1;
while 1+eps>1
    eps=eps/2;
end
eps=2*eps
%% The while loop.
% Example 2: Find the first integer n for which S=3+3^2+3^3+...+3^n is a 6 
% digit number
S=0;
n=0;
while S<10^5
    n=n+1;
    S=S+3^n;
end
fprintf('n=%.f, S=%.f\n',n,S)
%% The while loop.
% Example 3: Calculate n!
n = 12;
nf = n;
while n > 1
    n = n-1;
    nf = nf*n;
end
disp(['n! =' num2str(nf)]) 

%% The if statement.
% The simplest form of the if statement is
% if <logical expression>
%   <statement>
%   ...
%   <statement>
% end
% where the statements are evaluated as long as the <logical
% expression> is true.
%% Example 1: Assign x=x+2 if x is nonnegative.
prompt='What is x?\n';
x=input(prompt);
if x>=0
    x=x+2;
end
disp(['Then, if x >=0, x=x+2, otherwise unchanged: x=', num2str(x)])
%% The if-else statement. 
% A second form of the if statement is
% if <logical expression>
%   <statement group 1>
%   else
%   <statement group 2>
% end
% where statement group 1 is evaluated if the <logical expression> is
% true and statement group 2 is evaluated if it is false.
%% Example 2: Calculate y=sqrt(x) only if x is nonnegative.
prompt='What is x?\n';
x=input(prompt);
if x>=0
    y=sqrt(x);
    fprintf('y=%.4f\n',y)
else
    disp('x is negative')
end
%% Example 3: Calculate y=sqrt(x) if x is nonnegative
%  and y=e^(-x)-1 if x<0.
x=input('x=')
if x>=0
    disp('x is nonnegative')
    y=sqrt(x);
else
    disp('x is negative')
    y=exp(-x)-1;
end
fprintf('y=%.8f\n',y)
%% The final form of the if statement is
% if <logical expression 1>
%   <statement group 1>
%   elseif <logical expression 2>
%   <statement group 2>
%   ...
%   elseif <logical expression r>
%   <statement group r>
%   else
%   <statement group r+1>
% end
% where statement group 1 is evaluated if the <logical expression 1>
% is true, statement group 2 is evaluated if the <logical expression
% 2> is true, etc. The final else statement is not required. If it occurs
% and if none of the logical expressions is true, statement group r+1
% is evaluated. If it does not occur and if none of the logical
% expressions is true, then none of the statement groups are
% executed.

%% Example 4: Calculate y=ln(x) if x>10, y=sqrt(x) if 
% 0<x<=10, and y=x^2 if x<=0.
x=input('x=');
if x<=0
    y=x^2;
elseif x>10
    y=log(x);
elseif (x>0)&&(x<=10)
    y=sqrt(x);
end
fprintf('y=%.4f\n',y)
%% Example 5: Determine if a value x falls within 
%  a specified range: minVal<=x<=maxVal.
x=input('x=')
minVal=-2;
maxVal=12;
if (x>=minVal) && (x<=maxVal)
    disp('x is within specified range')
elseif x>maxVal
    disp('x exceeds maximum value')
elseif x<minVal 
    disp('x is below minimum value')
end
%% Example 6: Create a n-by-n matrix of 1s. Then, 
% loop through the matrix and assign each element a new value. 
% Assign 2 on the main diagonal, -1 on the adjacent diagonals, 
% and 0 everywhere else.
n=6;
A=ones(n);
for i=1:n
    for j=1:n
        if j==i
            A(j,i)=2;
        elseif abs(j-i)==1
            A(j,i)=-1;
        else
            A(j,i)=0;
        end
    end
end
disp('A='),disp(A)
%% The switch command.
% It can often used in place of a nested if-else or an if statement
% with many elseif conditions.
% It executes particular statements based on the
% value of a variable or an expression. Its general form is
% switch <variable or expression>
%   case <Value 1>
%   <statement group 1>
%   case {<Value 2a>, <Value 2b>, <Value 2c>, ..., <Value 2m>}
%   <statement group 2>
%   ...
%   case <value n>
%   <statement group r>
%   otherwise
%   <statement group r+1>
% end
% where statement group 1 is evaluated if the variable or expression
% has <Value 1>, where statement group 2 is evaluated if the
% variable or expression has values <Value 2a> or <Value 2b> or
% <Value 2c>, etc.

%% Example 1: Tells whether the selected number is odd or even. 
choice=input('Enter 1, 2, 3, 4, or 5\n');
switch choice
    case{1,3,5}
        disp('It is an odd number')
    case{2,4}
        disp('It is an even number')
    otherwise
        disp('You are not very good at following directions :-)')
end

%% Example 2: Provides the number of days in a given month.
month=2
switch month
    case{1,3,5,7,8,10,12}
        days=31
    case{4,6,9,11}
        days=30
    case{2}
        days=28
end     
%% Example 3: Another version of the previous example.
month=input('month=') % You can also use input('month=\n'), but not if you want to publish your file.
switch month
    case{'January','March','May','July','August','October','December'}
        days=31
    case{'April','June','September','November'}
        days=30
    case 'February'
        days=28
    otherwise
        disp('This is not a month')
end
%% Example 4: Here we find the sign of a given number.
mynumber = -3 % You can also use input('Enter a number:')
mynumbersign=sign(mynumber);
switch mynumbersign
    case -1
        disp('Negative number');
    case 0
        disp('Zero');
    case 1
        disp('Positive number');
end
%% Example 5: Fast food stuff.
myorder=menu('What would you have?','Cheesburger','Fries','Soda');
switch myorder
    case 1
        disp('I would like a cheesburger, please!')
    case 2
        disp('I would like fries with that, please!')
    case 3
        disp('Soda, please!')
end
        
