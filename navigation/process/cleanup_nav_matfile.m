% function cleanup_nav_matfile
%
% Script to do some very basic clean-up on Navigation files
% * remove lat = lon = 0, and depth and speed too
% * sort time and remove duplicate timesteps
% * trim 3 cruises that have data at odd times
%
% No hand-edit will be performed.  These data are of limited use. There
% is the possibility that NUQ202003Sall will be useful for the M3S weather
% station, but if that needs more clean-up, I will do it later.
%
% CSV files are not written because I don't think these will go in their 
% own archive. They will instead be used with other data processing.
% 
% ELD
% 2/6/2022
%

close all
indir = '../../data/Navigation/Level_0_v2';
outdir = '../../data/Navigation/Level_1'; 

files = dir('../../data/Navigation/Level_0_v2');

for f = 1:length(files)
    name = files(f).name
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        disp('not this file')
        continue
    end
    
    filename = sprintf('%s/%s', indir, name);
    load(filename)
    
    % spot edit bad points
    lat(lat==0) = NaN;
    lon(lon==0) = NaN;
    depth(depth<2) = NaN;
    sog(sog==0) = NaN;
    
    % for some cruises, trim time
    T = table(date, lat, lon, depth, heading, cog, sog);
    if contains(name, 'NUQ202003Sall')
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
    lat = T.lat;
    lon = T.lon;
    depth = T.depth; 
    heading = T.heading;
    cog = T.cog;
    sog = T.sog;

    name = replace(name, 'L0_v2', 'L1_v1');
    outfile = sprintf('%s/%s', outdir, name);
    save(outfile, 'date_str', 'date', 'lat', 'lon', 'depth', 'heading', 'cog', 'sog');
end
