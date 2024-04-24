%% Defitions
mt_settings = struct();


%% Common mistakes
mt_settings.macros = {
    'P11_GEQ', 'This is a macro message giving a penalty of -5 points. This is also invoking the solution for this point. [penalty:-5] [solution]\n\n';
	'P12_OTH', 'This is a macro message giving a penalty of +5 points. Since the penalty is positive, this will add to the mark [penalty:+5]\n\n';
	'BASE_P13', 'This is the base macro message, associated with completing this task to a satisfactory standard.\n\n';
    };
 
mt_settings.macro_preamble = '';                                           % This adds a preamble to each macro
mt_settings.macro_postamble = '';                                          % This adds a postamble to each macro



%% Marks
% The adjusted mark is given by the following formula:
% mark = round(starting_mark + penalty*mark_multiplier)
% and then
% mark = max(min(mark, maximum_mark), minimum_mark);
mt_settings.starting_mark = 100;                                           % This is the mark from which all the penalties are added.
                                                                           % In other words, an entry with no penalties will have a
                                                                           % (unadjusted) mark of starting_mark
mt_settings.penalty_multiplier = 1.0;                                      % Multiplies the total penalty by this value
mt_settings.minimum_mark = 0;                                              % If the resulting mark is below minimum_mark, it becomes minimum_mark
mt_settings.maximum_mark = 100;                                            % If the resulting mark is above maximum_mark, it becomes maximum_mark

% The overall remark dependent on the final mark
mt_settings.overall_remarks = {'100', '100', 'Your coursework is flawless.';
  '90', '99', 'Your coursework is outstanding.';
  '80', '89', 'Your coursework is excellent.';
  '70', '79', 'Your coursework is very good.';
  '60', '69', 'Your coursework is good.';
  '50', '59', 'Your coursework is ok, but could be better.'
  '40', '49', 'Your coursework could be better. Please carefully consider this feedback, and arrange a tutorial with me so we can go over the coursework together.'
  '-1', '40', 'Your coursework is rather poor. Please carefully consider this feedback, and arrange a tutorial with me so we can go over the coursework together.'};

%% Directories and filenames
mt_settings.output_dir = 'outputs';                                        % Name of directory where all outputs (including temporary) will be placed
mt_settings.solution_tex_dir = 'solution_tex';                             % Name of directory where all solutions (if any) should be found
mt_settings.solution_message = 'Please see the correct solution below. \n';% Preamble in case a solution is invoked
mt_settings.tex_template_filename = 'feedback_template.tex';               % Tex template of feedback
mt_settings.marks_filename = 'marks.txt';                                  % Name of tab-separated file containing the marks
mt_settings.pdflatex_filename = '/Library/TeX/texbin/pdflatex';            % Location of pdflatex

%% Feedback settings
mt_settings.generate_pdf = true;                                           % If true, it generates the PDF. Set to false if, e.g. you want to submit 
mt_settings.remove_penalty_from_text = true;                               % If true, the toolbox will remove all mentiones of [penalty:-XX]
mt_settings.feedback_title = 'Feedback of Coursework 1 of Audio Signal Processing and Synthesis';
mt_settings.message_no_remarks = 'This question was completed correctly.'; % Message to be placed in case the cell in the Excel spreadsheet is left empty

%% Email settings
mt_settings.send_emails = true;
mt_settings.email_subject = mt_settings.feedback_title;
mt_settings.email_template = 'email_template.txt';
mt_settings.feedback_description = ...
         'the first coursework of Audio Signal Processing and Synthesis';

mt_settings.sender_email = 'Enzo De Sena <e.desena@surrey.ac.uk>';            % TODO: extract this info automatically
mt_settings.email_appears_in_mac_mail = 'true';
mt_settings.send_email_automatically = 'false';
mt_settings.drive_name = 'Macintosh HD';                                    % TODO: extract this info automatically

