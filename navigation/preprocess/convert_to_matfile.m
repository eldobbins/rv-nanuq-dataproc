% function convert_to_matfile(cruise_id)
%
% Function to convert Navigation data to matfiles for easier plotting.
% Used to do one, but now does all.
% 
% ELD
% 2/5/2022
%

close all
indir = '../../data/Navigation/Level_0_v2';
% outdir = '../../data/Level_0_v2'; write out to same directory

files = dir('../../data/Navigation/Level_0_v2');

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
    lat = T.Lat_Deg + T.Lat_Min./60;
    lon = -(T.Lon_Deg + T.Lon_Min./60);
    depth = T.Depth; 
    heading = T.Heading;
    cog = T.COG;
    sog = T.SOG;

    save(outfile, 'date_str', 'date', 'lat', 'lon', 'depth', 'heading', 'cog', 'sog');
end
