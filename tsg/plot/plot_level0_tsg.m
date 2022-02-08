% Script to plot the concatinated TSG data stored in .mat files
% 
% Timestep length is plotted to see if it is constant.
% Does not save plots.
%
% ELD
% 2/7/2022
%

indir = '../../data/TSG/Level_0_v2';
cruise_id = 'NUQ202002S';
files = dir('../../data/TSG/Level_0_v2');

for f = 1:length(files)
    % load the file
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        disp('not this file')
        continue
    end    
    filename = sprintf('%s/%s', indir, name);
    load(filename)

    % NUQ202003Sall has some weird time we need to work around
    w = find(date ~= 0);
    date = date(w);
    temperature = temperature(w);
    conductivity = conductivity(w);
    salinity = salinity(w);
    sound_velocity = sound_velocity(w);
        
    %
    % Make the timeseries
    %

    figure(1)

    subplot(5, 1, 1)
    plot(date, temperature, '.')
    title([name ':  Temperature'], 'Interpreter', 'None')
    datetick('x', 'mm-dd HH:MM', 'keeplimits')

    subplot(5, 1, 2)
    plot(date, conductivity, '.')
    title('Conductivity')
    datetick('x', 'mm-dd HH:MM', 'keeplimits')

    subplot(5, 1, 3)
    plot(date, salinity)
    title('Salinity')
    datetick('x', 'mm-dd HH:MM', 'keeplimits')

    subplot(5, 1, 4)
    plot(date, sound_velocity)
    title('Sound Velocity')
    datetick('x', 'mm-dd HH:MM', 'keeplimits')

    subplot(5, 1, 5)
    date = sort(date);
    plot(date, [diff(date); NaN])
    title('time difference')
    ylim([-.00001 .0001])
    datetick('x', 'mm-dd HH:MM', 'keeplimits')
        
    pause
end
