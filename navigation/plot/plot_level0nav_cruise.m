function plot_level0nav(input_string, indir)
%
% Function to plot the cleaned-up navigation data stored in one cruise's
% .mat file
% 
% Makes 2 figures: a map of lat-lon and a set of timeseries.
% Timestep length is plotted because it isn't constant.
% Does not save plots.
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
% 2/6/2022
%


if endsWith(input_string, '.mat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_NAV_L0_v2.mat', input_string);
else
    name = input_string;
end
    
filename = sprintf('%s/%s', indir, name)
load(filename)

%
% Make the map
%

figure(1)
clf
lat = lat(lon~=0);  % quick fix till these get removed
lon = lon(lon~=0);

proj = 'lambert';
if max(lon) > -149;  % Went to Prince William Sound
    lonrng = [-150 -143];
    latrng = [59 61.3];
else
    lonrng = [-150 -149];
    latrng = [59.75 60.25];
end
m_proj(proj, 'lat', latrng, 'lon', lonrng);
m_usercoast('../../goa_coast.mat','patch','g');
hold on
m_plot(lon, lat)
title(name, 'Interpreter', 'None')
m_grid

%
% Make the timeseries
%

figure(2)

subplot(5, 1, 1)
plot(date, depth)
title([name ':  Depth'], 'Interpreter', 'None')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 2)
plot(date, heading, '.')
title('Heading')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 3)
plot(date, cog, '.')
title('Course over Ground')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 4)
plot(date, sog)
title('Speed over Ground')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 5)
date = sort(date);
plot(date, [diff(date); NaN] )
title('time difference')
ylim([-.00001 .00003])
datetick('x', 'mm-dd HH:MM', 'keeplimits')

% Don't save these plots.  Just for diagostic use.