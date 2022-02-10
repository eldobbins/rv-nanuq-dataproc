% function cleanup_tsg_matfile
%
% Script to do some very basic clean-up on TSG files
% * sort time and remove duplicate timesteps
% * trim 3 cruises that have data at odd times
%
% No hand-edit will be performed until after the merge with navigation
% because there might be some dependence on speed.
% 
% ELD
% 2/9/2022
%

close all
indir = '../../data/TSG/Level_0_v2';
outdir = '../../data/TSG/Level_1'; 

files = dir('../../data/TSG/Level_0_v2');

for f = 1:length(files)
    name = files(f).name;
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        %disp('not this file')
        continue
    end
    
    filename = sprintf('%s/%s', indir, name)
    load(filename)
    
    % for some cruises, trim time
    T = table(date, temperature, conductivity, salinity, sound_velocity);
    if contains(name, 'NUQ202002S')  % oddness at end
        T = T(T.date < datenum(2020, 6, 11, 23, 52, 0), :);
    elseif contains(name, 'NUQ202003Sall')
        T = T(T.date > datenum(2020, 7, 28, 0, 0, 0), :);
    elseif contains(name, 'NUQ202005S')
        T = T(T.date < datenum(2020, 11, 7, 0, 0, 0), :);
    elseif contains(name, 'NUQ202105S')
        T = T(T.date < datenum(2021, 5, 27, 6, 0, 0), :);
    end
    
    % Sort by time and remove duplicate times
    % Note: I don't know why there are duplicate times, so I don't know if
    % just removing them is correct.
    T = sortrows(T, 'date');
    [~,uidx] = unique(T(:, 'date'), 'stable');
    T = T(uidx,:);
        
    % getting ready for output
    date = T.date;
    date_str = datestr(date);
    temperature = T.temperature;
    conductivity = T.conductivity;
    salinity = T.salinity; 
    sound_velocity = T.sound_velocity;

    name = replace(name, 'L0_v2', 'L1_v1');
    outfile = sprintf('%s/%s', outdir, name);
    save(outfile, 'date_str', 'date', 'temperature', 'conductivity', 'salinity', 'sound_velocity');
end
