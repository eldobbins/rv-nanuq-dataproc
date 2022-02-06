% Script to plot the cleaned-up navigation data stored in .mat files
% 
% Makes 2 figures: a map of lat-lon and a set of timeseries.
% Timestep length is plotted because it isn't constant
%
% Note: it requires that m_map is installed.
% https://www.eoas.ubc.ca/~rich/mapug.html
%
% ELD
% 2/6/2022
%

indir = '../../data/Navigation/Level_1';
pltdir = '../../data/Navigation/Level_1/Plots';
files = dir('../../data/Navigation/Level_1');

% for the map
proj = 'lambert';
lonrng = [-150 -143];
latrng = [59 61.3];
m_proj(proj, 'lat', latrng, 'lon', lonrng);
m_gshhs_h('save','goa_coast');

for f = 1:length(files)
    % load the file
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        disp('not this file')
        continue
    end    
    filename = sprintf('%s/%s', indir, name);
    load(filename)

    %
    % Make the map
    %
    
    figure(1)
    clf
    if max(lon) > -149;  % Went to Prince William Sound
        lonrng = [-150 -143];
        latrng = [59 61.3];
    else
        lonrng = [-150 -149];
        latrng = [59.75 60.25];
    end
    m_proj(proj, 'lat', latrng, 'lon', lonrng);
    m_usercoast('goa_coast','patch','g');
    hold on
    m_plot(lon, lat)
    title(name, 'Interpreter', 'None')
    m_grid
    
    % save the map
    pltname = replace(name, '.mat', '_map.png');
    pltname = sprintf('%s/%s', pltdir, pltname);
    print('-dpng', '-r300', pltname);

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
        
    % save the timeseries
    pltname = replace(name, '.mat', '_timeseries.png')
    pltname = sprintf('%s/%s', pltdir, pltname);
    print('-dpng', '-r300', pltname);

    % pause % for debugging
end
