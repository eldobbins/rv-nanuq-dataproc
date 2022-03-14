% Script to plot the semi-edited data stored in .csv files
% 
% Timestep length is plotted to see if it is constant.
% Does not save plots.
%
% ELD
% 2/7/2022
%

indir = '~/Desktop/NGA LTER/Underway/met_station/Level_1/'
files = dir(indir);

for f = 1:length(files)
    % load the file
    name = files(f).name;
    if startsWith(name, 'nga') ~= 1 | endsWith(name, '.mat') ~= 1
        %disp('not this file')
        continue
    end  
    
    plot_level1m3s_cruise(name, indir)
end
