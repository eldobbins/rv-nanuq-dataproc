% function convert_to_matfile(cruise_id)
%
% Function to convert TSG data to matfiles for easier plotting.
% Does all available cruises.
% 
% ELD
% 2/7/2022
%

close all
indir = '../../data/TSG/Level_0_v2';
% outdir = '../../data/Level_0_v2'; write out to same directory

files = dir('../../data/TSG/Level_0_v2');

for f = 1:length(files)
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') == 1
        disp('not this file')
        continue
    end
    
    filename = sprintf('%s/%s', indir, name)
    outfile = replace(filename, '.dat', '.mat');

    % load data as table. First column name messed up because of #
    % filename = sprintf('%s/uaf_%s_NAV_L0_v2.dat', indir, cruise_id);
    T = readtable(filename);
    date = datenum(T.x_Year, T.Month, T.Day, T.Hour, T.Minute, T.Second);
    date_str = datestr(date);
    temperature = T.Temperature; 
    conductivity = T.Conductivity;
    salinity = T.Salinity;
    sound_velocity = T.Sound_Velocity;

    save(outfile, 'date_str', 'date', 'temperature', 'conductivity', 'salinity', 'sound_velocity');
end
