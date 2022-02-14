function plot_level0tsg_cruise(input_string, indir)
% Function to plot the concatinated TSG data stored in .mat files
% 
% Timestep length is plotted to see if it is constant.
% Does not save plots. No maps yet.
% 
% Arguments:
% input_string: can be either a filename or a cruise id. if cruise_id, then
%               then it builds the input filename
% indir: directory where files can be found
%
% ELD
% 2/7/2022
%

if endsWith(input_string, '.mat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_TSG_L0_v2.mat', input_string);
else
    name = input_string;
end

filename = sprintf('%s/%s', indir, name);
load(filename)

% NUQ202003S has some weird time we need to work around
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
        
