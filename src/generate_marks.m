% Generate marks and latex feedback for coursework
% 
% 
% Copyright Enzo De Sena 2017
function generate_marks

%% Load marks table
load marks.mat

%% Load coursework variables
coursework_variables

%% Define variables
[num_students, num_columns] = size(marks);
num_questions = num_columns-5; % First five columns: name, surname, URN, email, # days delay
marks = nan(num_students, 1);

%% Run reports
for student_id=1:num_students
    penalty = generate_student_report(student_id);
    marks(student_id) = initial_mark-penalty;
end


%% Display info
display(strcat('Number of students: ', num2str(num_students)));
display(strcat('Number of questions/points: ', num2str(num_questions)));
display(strcat('Average mark: ', num2str(mean(marks))));
display(strcat('Median mark: ', num2str(median(marks))));
display(strcat('Max mark: ', num2str(max(marks))));
display(strcat('Min mark: ', num2str(min(marks))));

end


function penalty = generate_student_report(student_id)
penalty = 0;

end
