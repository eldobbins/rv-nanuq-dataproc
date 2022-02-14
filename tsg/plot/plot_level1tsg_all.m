% Script to plot the concatinated TSG data stored in .mat files
% 
% Timestep length is plotted to see if it is constant.
% Does not save plots.
%
% ELD
% 2/7/2022
%

indir = '../../data/TSG/Level_1';
files = dir(indir);

for f = 1:length(files)
    % load the file
    name = files(f).name;
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        %disp('not this file')
        continue
    end  
    
    plot_level1tsg_cruise(name, indir)
end
