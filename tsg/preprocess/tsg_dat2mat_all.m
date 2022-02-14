% Script to convert TSG data to matfiles for easier plotting.
% Does all available cruises.
% 
% ELD
% 2/7/2022
%

close all
indir = '../../data/TSG/Level_0_v2';
% outdir = '../../data/Level_0_v2'; write out to same directory

files = dir(indir);

for f = 1:length(files)
    name = files(f).name;
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') == 1
        % disp('not this file')
        continue
    end
    
    tsg_dat2mat_cruise(name, indir)
    
end
