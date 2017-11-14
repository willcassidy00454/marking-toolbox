% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [questions_title, students_data, marks] = ...
            mt_data_load(data_filename)

assert(exist(data_filename,'file') == 2, ...
       'File not found: marks.mat');
load(data_filename); % Load
assert(exist('data', 'var') == 1, ...
        'File marks.mat does not contain variable data');
% Convert table to cell, which are easier to handle
data = table2cell(data);

assert(data{1,1} == 'Name', ...
  'The first row of the marks table should contain the name of variables');

[N, K] = size(data);

for n=1:N
    for k=1:K
        assert(isstring(data{n,k}));
    end
end

questions_title = data(1,6:end);
% First five columns: name, surname, URN, email, # days delay
students_data = data(2:end,1:5);
marks = data(2:end,6:end);
