% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_settings_sanity_check(mt_settings)

[~, M] = size(mt_settings.macros);
assert(M==2, 'The macros variable has more than 2 columns');