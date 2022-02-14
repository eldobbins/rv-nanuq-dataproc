function edata = edit_to_level2(cruise_id)
%
% Function to edit the TSG parameters and write into a CSV file that
% is in the NGA LTER standard format. Reads data from the .mat file
% written out by combine_tsg_nav.m
% 
% Argument:
% cruise_id: string identifier of cruise
% 
% Returns:
% edata : editted data matrix [datetime, lat, lon, T, C, S]
% 
% gregaxd is part of a larger package "timeplt" 
% https://github.com/rsignell-usgs/timeplt by
% Rich Signell (c2013). 
%
% ELD
% 2021-11-29
%
% 2/13/2022 Decided the data is clean enough to avoid hand editting.
%

addpath('~/matlab/timeplt');    % for gregaxd

close all
indir = sprintf('../data/Level_1/%s', cruise_id);
outdir = sprintf('../data/Level_2/%s', cruise_id);

infile = sprintf('%s/uaf_%s_TSG_L1_v1.mat', indir, ...
    replace(cruise_id, '_all', ''));

outfile = sprintf('%s/uaf_%s_TSG_L2_v1.csv', outdir, ...
    replace(cruise_id, '_all', ''));


% load data. was written out like:
% save(outfile, 'jd', 'lat', 'lon', 'temp', 'cond', 'salt');
% "cond" is also a function name, and MATLAB is strict about naming
% conflicts, so read the data into a structure.
data = load(infile, '*');

% prep the data for editing, and sort it by time
data.lon(data.lon==0) = NaN;  % Some bad positions (0,0)
data.lat(data.lat==0) = NaN;
data.all = [data.jd, data.lat, data.lon, data.temp, data.cond, data.salt];
data.all = sortrows(data.all, 1);
% subset the data
if strcmp(cruise_id, 'NUQ202003S_all')
    ens = find(data.all(:,1) > datenum(2020,7,27));
    data.all = data.all(ens,:);
end

edata = hand_cleanup(data.all);
% pull time out to a separate variable
dtime = edata(:,1);

% write out
if ~exist(outdir, 'dir')
    mkdir(outdir);
end

fid = fopen(outfile, 'w');
hdr = ['Cruise,Type,Date_Time_[UTC],', ...
       'Longitude_[decimal_degrees_east],Latitude_[decimal_degrees_north],', ...
       'Temperature_[C],Conductivity_[S/m],Salinity_[psu]'];
fprintf(fid, '%s\n', hdr);
for nrec = 1:length(dtime)
    fprintf(fid, '%s,TSG,%s,%.5f,%.5f,%.3f,%.3f,%.3f\n', cruise_id, ...
        datestr(dtime(nrec), 'yyyy-mm-ddTHH:MM:SS'), ...
        edata(nrec, 2:end));
end

fclose(fid);
