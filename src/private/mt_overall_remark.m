function remark = mt_overall_remark(mark, late_penalty, mt_settings, for_latex)

if nargin < 4
    for_latex = true;
end

[num_levels, ~] = size(mt_settings.overall_remarks);

for n=1:num_levels
    if mark >= str2double(mt_settings.overall_remarks{n, 1}) && ...
       mark <= str2double(mt_settings.overall_remarks{n, 2})
        remark = mt_settings.overall_remarks{n, 3};
    end
end

if late_penalty < 0
    if for_latex
        penalty_string = "~$" + num2str(late_penalty) + "$\%";
    else
        penalty_string = " " + num2str(late_penalty) + "%";
    end
    remark = remark + " Your coursework incurred a" + penalty_string + ...
        " late submission penalty (this penalty is already included in the overall mark above).";
end
