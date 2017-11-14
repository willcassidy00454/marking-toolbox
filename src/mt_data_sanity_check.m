% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_data_sanity_check(data)
assert(data{1,1} == 'Name', ...
  'The first row of the marks table should contain the name of variables');

[N, K] = size(data);

for n=1:N
    for k=1:K
        assert(isstring(data{n,k}));
    end
end
