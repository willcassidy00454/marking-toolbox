% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function [penalties, remarks, log] = ...
    mt_parse_student_marks(student_marks, cw_settings)

%% Check consistency of inputs
[temp, num_questions] = size(student_marks);
assert(temp==1);

%% Define variables
penalties = nan(num_questions, 1);
remarks = cell(num_questions, 1);
log = string; % Initialise log

%% Find penalties
for question_id = 1:num_questions
    remark_str = student_marks{question_id};
    
    [penalties(question_id), remarks{question_id}, question_log] = ...
        mt_find_penalty(remark_str, cw_settings);
    
    log = log + 'Question id ' + num2str(question_id) + ':' + newline + ...
                 question_log + newline + newline;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [question_penalty, question_str, log] = ...
                    mt_find_penalty(question_str, cw_settings)
wrong_format_msg = strcat('Wrong format of penalty, ',...
                          'should be (penalty:-X), (penalty:-XX), ',...
                          '(penalty:+X) or (penalty:+XX)');
log = 'Parsing string ''' + question_str + ''' (length: ' + ...
    num2str(strlength(question_str)) + ' chars)' + newline;

question_penalty = 0;

%% Parse for string (penalty:-XX)
penalties = extractBetween(question_str,"(penalty:",")");  
log = log + 'Found ' + num2str(length(penalties)) + ...
             ' occurrences of (penalty:XXX): ' + ...
             strjoin(penalties) + newline;

%% Parse each (penalty:-XX) occurrence
for penalty_id = 1:length(penalties)
    penalty_str = penalties{penalty_id};
    
    % Check correct format of string
    assert(strlength(penalty_str)>=2, wrong_format_msg);
    assert(strlength(penalty_str)<=3, wrong_format_msg);
    assert(penalty_str(1) == '+' || penalty_str(1) == '-', wrong_format_msg);
    assert(mt_char_is_num(penalty_str(2)), wrong_format_msg);
    if strlength(penalty_str) == 3
        assert(mt_char_is_num(penalty_str(3)), wrong_format_msg);
    end
    
    % Add penalty to question
    question_penalty = question_penalty + str2double(penalty_str);
end

log = log + 'Total penalty for this question: ' + ...
             num2str(question_penalty) + newline;

%% Remove the penalty from text remark, if needed
if isfield(cw_settings, 'remove_penalty_from_text') && ...
           cw_settings.remove_penalty_from_text
    question_str = replaceBetween(question_str, "(penalty:", ")", '',...
                                  'Boundaries', 'inclusive');
end

end
