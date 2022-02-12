function nav2matfile_cruise(input_string, indir)
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
% Arguments:
% input_string: can be either a filename or a cruise id. if cruise_id, then
%               then it builds the input filename
% indir: where the file is found. Will be converted to the outdir name.
%
% ELD
% 2/12/2022
%

close all


if endsWith(input_string, '.mat') ~= 1
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_NAV_L0_v2.mat', input_string);
else
    name = input_string;
end
filename = sprintf('%s/%s', indir, name);

outname = replace(name, 'L0_v2', 'L1_v1');
outdir = replace(indir, 'Level_0_v2', 'Level_1');
outfile = sprintf('%s/%s', outdir, outname);

load(filename)

% spot edit bad points
lat(lat==0) = NaN;
lon(lon==0) = NaN;
depth(depth<2) = NaN;
sog(sog==0) = NaN;

% for some cruises, trim time
T = table(date, lat, lon, depth, heading, cog, sog);
if contains(name, 'NUQ202003S')
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

save(outfile, 'date_str', 'date', 'lat', 'lon', 'depth', 'heading', 'cog', 'sog');

