% Script to do some very basic clean-up on all the Navigation mat files
%
% CSV files are not written because I don't think these will go in their 
% own archive. They will instead be used with other data processing.
% 
% ELD
% 2/6/2022
%

close all
indir = '../../data/Navigation/Level_0_v2';

files = dir('../../data/Navigation/Level_0_v2');

for f = 1:length(files)
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        disp('not this file')
        continue
    end
    
    nav_cleanup_matfile_cruise(name, indir)
end
