% This script presents a console interface for populating "marks.txt".
% The macros from "coursework_variables.m" are presented to the user in
% sections outlined by "evaluation_setup.txt". Each section refers to a
% column in the output. Existing data in "marks.txt" will be preserved.
%
% ============================= REQUIREMENTS =============================
%
% Please run "set_up_evaluation.m" first to specify the section headings
% and the number of subsections in each.
%
% This script requires the macros in "coursework_variables.m" to use the
% prefix "BASE" to denote those corresponding to satisfying the coursework
% specification. These macros will be presented at the start of each
% subsection, and the others in said subsection will be skipped once a
% macro is selected. Each "BASE" macro must come at the END of its
% subsection in "coursework_variables.m".
%
% Also, the macros in "coursework_variables.m" must be in the order of
% expected appearance for the spreadsheet, as they are read sequentially.
%
% If you have edited "marks.txt", please ensure no double quotes have been
% used - this script removes them. Use single quotes instead.
%
% Note: The first five columns of the output spreadsheet will start with
% the following student info variables, as required by the toolbox:
% "Name" "Surname" "Student ID" "Email" "Late submission penalty".

function run_evaluation(directory)
    settings_filename = directory + "coursework_variables.m";
    spreadsheet_filename = directory + "marks.txt";
    setup_filename = directory + "evaluation_setup.txt";
    student_info_headings = ["Name"	"Surname" "Student ID" "Email" "Late submission penalty"];

    % Load the setup file which contains the coursework section headings and
    % how many subsections each contains
    setup_file = fopen(setup_filename);
    coursework_var_headings = strsplit(fgetl(setup_file), ',');
    num_subsec_per_sec = readmatrix(setup_filename);
    
    % Write section headings to the output spreadsheet
    if ~exist(spreadsheet_filename, "file")
        headings = horzcat(student_info_headings, coursework_var_headings);
        writematrix(headings, spreadsheet_filename, "Delimiter", "\t");
    end
    
    disp(sprintf("\nCoursework Evaluation (writes to " + spreadsheet_filename + ")\n"));
    disp("=========================================");
    
    continue_flag = true;

    mt_settings = mt_settings_load(settings_filename);
    
    % Each iteration refers to one student
    while continue_flag == true
        disp(sprintf("\n*** Student Information ***\n"));
    
        forename = input("Forename: ", "s");
        surname = input("Surname: ", "s");
        student_number = input("Student number: ", "s");
        email = input("Email: ", "s");
        late_penalty = input("Late submission penalty: ", "s");

        row_output_data = {forename, surname, student_number, email, late_penalty};
    
        row_output_data = present_macro_prompts(row_output_data, mt_settings, coursework_var_headings, num_subsec_per_sec);

        write_row_to_file(row_output_data, spreadsheet_filename);

        disp(sprintf("\n========================================="));
        disp(sprintf("\n Evaluation for " + forename + " " + surname + " written to " + spreadsheet_filename + "."));
    
        if input(sprintf("\n Continue? [y/n]: "), "s") ~= 'y'
            continue_flag = false;
        end
    end
end

function cell_output = judge_subsection(cell_output, macro_index_start, macro_index_end, mt_settings)
    % Check if the fully-satisfactory 'base' statement is true
    base_statement = num2str(cell2mat((mt_settings.macros(macro_index_end, 2))));

    base_answer = input(base_statement + " Is this true? [y/n]: ", "s");

    % If the base statement is true, return the respective macro and break
    if base_answer == 'y'
        macro = num2str(cell2mat(mt_settings.macros(macro_index_end, 1)));
        cell_output = append(cell_output, macro + " ");
        return
    end
    
    % If there are nested options, cycle through them, breaking on selection
    if (macro_index_end > macro_index_start)
        for macro_index = macro_index_start:macro_index_end - 1
            statement = num2str(cell2mat((mt_settings.macros(macro_index, 2))));
        
            answer = input(statement + " Is this true? [y/n]: ", "s");
        
            if answer == 'y'
                macro = num2str(cell2mat(mt_settings.macros(macro_index, 1)));
                cell_output = append(cell_output, macro + " ");
                return
            end
        end
    end
end

function write_row_to_file(row_data, spreadsheet_filename)
    % Prepend a carriage return to indicate a new line
    row_data(1) = sprintf('\r') + row_data(1);

    % Join all the output data for the current row into a single character array
    row_data = convertStringsToChars(join(row_data, sprintf('\t')));

    % Append new row to existing data, removing newline chars and
    % double quotes added by the process (this is a workaround)
    existing_data = fileread(spreadsheet_filename);
    all_output_data = horzcat(existing_data, row_data);
    all_output_data = strrep(all_output_data, newline, '');
    all_output_data = strrep(all_output_data, '"', '');

    % Rewrite all file data at once to avoid adding newline chars.
    % This method ensures the structure of the output file remains the
    % same if it gets edited with excel.
    writematrix(all_output_data, spreadsheet_filename, "WriteMode", "overwrite");
end

function row_output_data = present_macro_prompts(row_output_data, mt_settings, coursework_var_headings, num_subsec_per_sec)
    disp(sprintf("\nJudge the following statements."));
        
    macro_index = 1;
    
    % This assumes the student info is five columns
    column_write_index = 6;
    
    for heading_index = 1:length(coursework_var_headings)
        heading = coursework_var_headings(heading_index);
        num_subsections = num_subsec_per_sec(heading_index);
        section_output = "";
    
        disp(sprintf("\n*** " + heading + " ***\n"));
    
        % fill section_macros with all macros of this section, ending with
        % the base macro
        for subsection = 1:num_subsections
            macro_index_start = macro_index;
            macro_index_end = macro_index_start;
            base_macro_found = false;
    
            % Find the start and end macro indexes for the current
            % subsection
            while base_macro_found == false
                macro = num2str(cell2mat((mt_settings.macros(macro_index, 1))));
    
                % If the macro starts with "BASE" then stop filling section_macros
                if startsWith(macro, "BASE")
                    macro_index_end = macro_index;
                    base_macro_found = true;
                end
    
                macro_index = macro_index + 1;
            end
    
            % Append the selected subsection macro to the current section output
            section_output = judge_subsection(section_output, macro_index_start, macro_index_end, mt_settings);
        end
    
        % Remove trailing whitespace
        section_output = strtrim(section_output);
    
        % Append the current section output to the current row of data
        row_output_data = horzcat(row_output_data, section_output);
    
        column_write_index = column_write_index + 1;
    end
end