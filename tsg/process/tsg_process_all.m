% Script to call the functions that do the cleanup and combine the TSG and
% navigation files for all the cruises
%
% No hand-edit will be performed until after the merge with navigation
% because there might be some dependence on speed.
% 
% ELD
% 2/9/2022
%

close all
indir = '../../data/TSG/Level_0_v2';

files = dir(indir);

for f = 1:length(files)
    name = files(f).name;
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        %disp('not this file')
        continue
    end
    
    tsg_file = tsg_cleanup_matfile_cruise(name, indir)
    combine_tsg_nav(tsg_file)
end
