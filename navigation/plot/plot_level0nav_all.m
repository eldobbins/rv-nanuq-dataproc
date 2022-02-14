% Script to plot the cleaned-up navigation data stored in .mat files
% 
% Makes 2 figures: a map of lat-lon and a set of timeseries.
% Timestep length is plotted because it isn't constant.
% Does not save plots.
%
% Note: it requires that m_map is installed.
% https://www.eoas.ubc.ca/~rich/mapug.html
%
% ELD
% 2/6/2022
%

indir = '../../data/Navigation/Level_0_v2';
files = dir(indir);


for f = 1:length(files)
    % load the file
    name = files(f).name;
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        % disp('not this file')
        continue
    end    

    plot_level0nav_cruise(name, indir)
    
    pause
end
