clc
% Attendance A
Na=input('Number of absences (input 6 if more than 6) = ');
A = 3-Na*0.5;
% Classwork & Assignments CW
A_1 = input('Assignment 1 (type 0 or your prediction if not submitted)=');
if (A_1>100)||(A_1<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
A_2 = input('Assignment 2 (type 0 or your prediction if not submitted)=');
if (A_2>100)|| (A_2<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
A_3 = input('Assignment 3 (type 0 or your prediction if not submitted)=');
if (A_3>100)|| (A_3<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
A_4 = input('Assignment 4 (type 0 or your prediction if not submitted)=');
if (A_4>100)||(A_4<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
A_5 = input('Assignment 5 (type 0 or your prediction if not submitted)=');
if (A_5>100)|| (A_5<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
A_6 = input('Assignment 6 (type 0 or your prediction if not submitted)=');
if (A_6>100)|| (A_6<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
Asgn=(A_1+A_2+A_3+A_4+A_5+A_6)*(17/600);
% Midterm Exams E
Exam_1 = input('Exam 1 (type 0 or your prediction if not taken)=');
if (Exam_1>100)|| (Exam_1<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
Exam_2 = input('Exam 2 (type 0 or your prediction if not taken)=');
if (Exam_2>100)|| (Exam_2<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
Exam_3 = input('Exam 3 (type 0 or your prediction if not taken)=');
if (Exam_3>100)|| (Exam_3<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
Exam_Grades = [Exam_1;Exam_2;Exam_3];
Exam_Grades=sort(Exam_Grades);
Exam_Grades(1)=Exam_Grades(2);
E = sum(Exam_Grades)/6;
% Final Exam F
Final_Exam = input('Final Exam (type 0 or your prediction if not taken)=');
if (Final_Exam >100)|| (Final_Exam<0)
    disp('Incorrect entry, please try again from the beginning.')
    return
end
F = Final_Exam *(30/100);
% Course Point Grade cpg
GU=input('Are you enrolled in MA 57700? Type 1 if yes, 0 if not =');
switch GU
    case 1
        Project=input('Your grade/prediction (from 0-10) on the course project =')
        cpg = E+F+Asgn+A+Project-10;
    case 0
        cpg = E + F + Asgn + A
end
fprintf('Your accumulated course point grade so far = %3.2f:\n',cpg)
if cpg>=94
    disp('Your course (letter) grade so far = A')
elseif (cpg>=89)&&(cpg<94)
    disp('Your course (letter) grade so far = A-')
elseif (cpg>=85)&&(cpg<89)
    disp('Your course (letter) grade so far = B+')
elseif (cpg>=80)&&(cpg<85)
    disp('Your course (letter) grade so far = B')
elseif (cpg>=75)&&(cpg<80)
    disp('Your course (letter) grade so far = B-')
elseif (cpg>=70)&&(cpg<75)
    disp('Your course (letter) grade so far = C+')
elseif (cpg>=65)&&(cpg<70)
    disp('Your course (letter) grade so far = C')
elseif (cpg>=60)&&(cpg<65)
    disp('Your course (letter) grade so far = C-')
elseif (cpg>=57)&&(cpg<60)
    disp('D+')
elseif (cpg>=53)&&(cpg<57)
    disp('Your course (letter) grade so far = D')
elseif (cpg>=50)&&(cpg<53)
    disp('Your course (letter) grade so far = D-')
else
    disp('Your course (letter) grade so far = F')
end








    
