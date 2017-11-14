% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_generate_marks

%% Load coursework variables
assert(exist('coursework_variables.m','file') == 2, ...
        'File not found: coursework_variables.m' );
coursework_variables % Load
assert(exist('mt_settings', 'var') == 1, ...
        'File coursework_variables does not contain variable mt_settings');
mt_settings_sanity_check(mt_settings);

%% Load marks table
assert(exist(mt_settings.marks_filename,'file') == 2, ...
       'File not found: marks.mat');
load(mt_settings.marks_filename); % Load
assert(exist('data', 'var') == 1, ...
        'File marks.mat does not contain variable data');
mt_data_sanity_check(data);
% Convert table to cell, which are easier to handle
data = table2cell(data);

data 

%% Define variables
[num_rows, num_columns] = size(data);
num_students = num_rows - 1;
num_questions = num_columns-5;
questions_title = data(1,6:end);
% First five columns: name, surname, URN, email, # days delay
students_data = data(2:end,1:5);
marks = data(2:end,6:end);

%% Replace macros
if isfield(mt_settings, 'macros') == 1
    marks = mt_replace_macros(marks, mt_settings.macros);
end

%% Run reports
final_marks = nan(num_students, 1);
for student_id=1:num_students % First row is variable names
    student_data = mt_create_student_struct(students_data(student_id, :));
    student_marks = marks(student_id,:);
    
    % Run student report
    mark = mt_run_student(student_data, student_marks, questions_title, ...
                          mt_settings);
    final_marks(student_id) = mark;
end

%% Display info
display(newline);
display(strcat('Number of students: ', num2str(num_students)));
display(strcat('Number of questions/points: ', num2str(num_questions)));
display(strcat('Average mark: ', num2str(mean(final_marks))));
display(strcat('Median mark: ', num2str(median(final_marks))));
display(strcat('Standard deviation: ', num2str(std(final_marks))));
display(strcat('Max mark: ', num2str(max(final_marks))));
display(strcat('Min mark: ', num2str(min(final_marks))));

end


