function plot_level1nav(input_string, indir)
%
% Function to plot M3S data stored in .csv files
% 
% Timestep length is plotted to see if it is constant.
% 
% Note: it requires that m_map is installed.
% https://www.eoas.ubc.ca/~rich/mapug.html
% run ../../utilities/initialize_coast.m if you need to make the coastline
% file.
% 
% Arguments:
% input_string: can be either a filename or a cruise id. if cruise_id, then
%               then it builds the input filename
% indir: where the file is found. Will be converted to the outdir name.
% 
% ELD
% 2/13/2022
%

%input_string = 'NUQ201901S'
%indir = '~/Desktop/NGA LTER/Underway/met_station/Level_1/'

sz = 20;   % size of the markers for scatter plot
skp = 12;  % points to skip between scatter points

if endsWith(input_string, '.mat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('nga_%s_m3s_L1_v1.mat', input_string);
else
    name = input_string;
end

filename = sprintf('%s/%s', indir, name)
load(filename)
pltdir = sprintf('%s/Plots', indir);

figure(1)
clf

subplot(6, 1, 1)
plot(time, AirTC)
title([name ':  Air Temperature'], 'Interpreter', 'None')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 2)
plot(time, RH)
title('Relative Humidity')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 3)
plot(time, PAR_Den)
title('PAR (average, umol/m2s)')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 4)
plot(time, PAR_Tot_Tot)
title('PAR (integrated, mmol/m2)')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 5)
w = find(WS_ms<1000);
plot(time(w), WS_ms(w))
title('Wind Speed (m/s)')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 6)
plot(time(w), WindDir(w), '.')
title('Wind Direction')
datetick('x', 'mm-dd HH:MM', 'keeplimits')
ylim([0 360])

% save the timeseries
pltname = replace(name, '.mat', '.png');
pltname = sprintf('%s/%s', pltdir, pltname);
print('-dpng', '-r300', pltname);

%
% plot navigation stuff
%

figure(2)
clf

subplot(6, 1, 1)
plot(time, latitude)
title([name ':  Latitude'], 'Interpreter', 'None')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 2)
plot(time, longitude)
title('Longitude')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 3)
plot(time, Course, '.')
title('M3S Course')
datetick('x', 'mm-dd HH:MM', 'keeplimits')
ylim([0 360])

subplot(6, 1, 4)
plot(time, cog, '.')
title('Computed Course over Ground')
datetick('x', 'mm-dd HH:MM', 'keeplimits')
ylim([-180 180])

subplot(6, 1, 5)
plot(time, spog)
title('Computed Speed over Ground')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(6, 1, 6)
w = find(WS_ms<1000);
plot(time(w), WS_ms(w))
title('Wind Speed (m/s)')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

% save the timeseries
pltname = replace(name, '.mat', '_nav.png');
pltname = sprintf('%s/%s', pltdir, pltname);
print('-dpng', '-r300', pltname);

