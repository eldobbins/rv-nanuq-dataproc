function plot_level1nav(input_string, indir)
%
% Function to plot TSG +Nav data stored in .mat files
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

sz = 20;   % size of the markers for scatter plot
skp = 10;  % points to skip between scatter points

if endsWith(input_string, '.mat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_TSG_L1_v1.mat', input_string);
else
    name = input_string;
end

filename = sprintf('%s/%s', indir, name)
load(filename)
pltdir = sprintf('%s/Plots', indir);

data = load(filename, 'date');
tday = data.date;

%
% Make the map
%

figure(1)
clf

proj = 'lambert';
if max(lon) > -149;  % Went to Prince William Sound
    lonrng = [-150 -145];
    latrng = [59 61.3];
else
    lonrng = [-150 -149];
    if contains(name, 'NUQ202108S')  % Special case: Aialik Bay
        latrng = [59.666667 60.25];
    else
        latrng = [59.75 60.25];
    end
end

subplot(1,2,1)
    m_proj(proj, 'lat', latrng, 'lon', lonrng);
    m_usercoast('../../goa_coast','patch','k');
    hold on
    m_grid
    m_scatter(lon(1:skp:end), lat(1:skp:end), sz, temperature(1:skp:end),'filled')
    cb = colorbar('Location','SouthOutside');
    ylabel( cb, 'Temperature [\circC]', 'fontsize', 12,'fontname','Times');

    
subplot(1,2,2)
    m_proj(proj, 'lat', latrng, 'lon', lonrng);
    m_usercoast('../../goa_coast','patch','k');
    hold on
    m_grid
    m_scatter(lon(1:skp:end), lat(1:skp:end), sz, salinity(1:skp:end),'filled')
    cb = colorbar('Location','SouthOutside');
    ylabel( cb, 'Salinity [PSU]', 'fontsize', 12,'fontname','Times');

sgtitle(name, 'Interpreter', 'None')

% save the map
pltname = replace(name, '.mat', '_map.png');
pltname = sprintf('%s/%s', pltdir, pltname);
print('-dpng', '-r300', pltname);


%
% Make the timeseries
%

figure(2)
clf

subplot(5, 1, 1)
plot(tday, temperature, '.')
title([name ':  Temperature'], 'Interpreter', 'None')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 2)
plot(tday, conductivity, '.')
title('Conductivity')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 3)
plot(tday, salinity, '.')
title('Salinity')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 4)
plot(tday, sound_velocity, '.')
title('Sound Velocity')
datetick('x', 'mm-dd HH:MM', 'keeplimits')

subplot(5, 1, 5)
plot(tday, sog, '.')
title('Speed over Ground')
datetick('x', 'mm-dd HH:MM', 'keeplimits')
        
% save the timeseries
pltname = replace(name, '.mat', '_timeseries.png');
pltname = sprintf('%s/%s', pltdir, pltname);
print('-dpng', '-r300', pltname);

%
% Make the TS plot (instead of timeseries?)
%

figure(3)
clf

scatter(salinity, temperature, 20, sog, 'filled')
ylabel('Temperture');
xlabel('Salinity');
title(name, 'Interpreter', 'None');
c = colorbar;
c.Label.String = 'Speed over Ground';
grid;

pltname = replace(name, '.mat', '_ts.png');
pltname = sprintf('%s/%s', pltdir, pltname);
print('-dpng', '-r300', pltname);

