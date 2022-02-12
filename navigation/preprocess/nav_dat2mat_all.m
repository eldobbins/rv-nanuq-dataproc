% Script to convert all Navigation data to matfiles
%
% ELD
% 2/12/2022
%

close all
indir = '../../data/Navigation/Level_0_v2';

files = dir(indir);

for f = 1:length(files)
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') == 1
        disp('not this file')
        continue
    end
    
    nav_dat2mat_cruise(name, indir)
end
