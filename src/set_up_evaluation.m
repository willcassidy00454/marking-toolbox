% This script populates "evaluation_setup.txt" to prepare
% "run_evaluation.m" with the coursework variable section headings, and the
% number of subsections under each.
%
% Ultimately, a section refers to the headings in the LaTeX PDF output, and
% a subsection refers to a collection of macros where one will be selected
% and presented as a bullet point in the PDF output.
%
% For example, entering the heading "MIDI Support" and number of
% subsections "3" will result in the following PDF output:
%
% MIDI Support
% - The first selected macro
% - The second selected macro
% - The third selected macro
%
% (assuming an option is selected in each subsection)
%
% Note: The number of subsections should be equal to the number of "BASE"
% macros in each section of "coursework_variables.m".

function set_up_evaluation(directory)
    headings_and_num_subsections = [""; ""];
    user_is_continuing = true;

    disp(sprintf("\nCoursework Evaluation Setup\n"));
    disp("=========================================");

    column = 1;

    while user_is_continuing
        headings_and_num_subsections(1, column) = input("Enter a coursework variable section heading (e.g. 'MIDI Support'): ", "s");
        headings_and_num_subsections(2, column) = input("Enter the number of subsections under this heading (i.e. how many 'BASE' macros there are in the section): ", "s");

        if input("Continue adding headings? [y/n]: ", "s") ~= 'y'
            user_is_continuing = false;
        else
            headings_and_num_subsections(1, column + 1) = "";
            column = column + 1;
        end
    end

    writematrix(headings_and_num_subsections, directory + "evaluation_setup.txt", "Delimiter", "comma", "WriteMode", "overwrite");
end