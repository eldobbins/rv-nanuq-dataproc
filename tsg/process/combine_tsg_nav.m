function combine_tsg_nav(tsg_filename)
%
% Function to combine Navigation and TSG data streams together to 
% create a single .mat file.  Also produces timeseries plot as a check
%
% The Level 1 TSG file must exist, so input that as the argument
% 
% read_tsg.m code originally from Hank. Adapted by ELD
% 2021-11-17
%

addpath('../../utilities/')
close all

nav_filename = replace(tsg_filename, 'data/TSG', 'data/Navigation');
nav_filename = replace(nav_filename, 'TSG_L1', 'NAV_L1');

% get the times for which we need positions
data = load(tsg_filename, 'date');
tday = data.date;

% load the navigation data
data = load(nav_filename);
nday = data.date;
nlat = data.lat;
nlon = data.lon;
nsog = data.sog;
ndepth = data.depth;

% Identify the navigation points closest to the TSG points in time.
% No interpolation needed because Nav is at high resolution.
lat = nan(size(tday));
lon = lat;
sog = lat;
depth = lat;
for in = 1:length(tday)
    ind = near(nday, tday(in), 1);
    lat(in) = nlat(ind);
    lon(in) = nlon(ind);
    sog(in) = nsog(ind);
    depth(in) = ndepth(ind);
end

save(tsg_filename, 'lat', 'lon', 'sog', 'depth', '-append');
