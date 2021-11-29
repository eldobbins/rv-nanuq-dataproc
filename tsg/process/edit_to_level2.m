function edit_to_level2(cruise_id)
%
% Function to edit the TSG parameters and write into a CSV file that
% is in the NGA LTER standard format. Reads data from the .mat file
% written out by combine_tsg_nav.m
% 
% gregaxd is part of a larger package "timeplt" 
% https://github.com/rsignell-usgs/timeplt by
% Rich Signell (c2013). 
%
% ELD
% 2021-11-29
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
data = load(infile, '*')

JulianTime = julian(datevec(data.jd));
edata = hand_cleanup([JulianTime, data.lat, data.lon, data.temp, data.cond, data.salt]);

% write out
if ~exist(outdir, 'dir')
    mkdir(outdir);
end

fid = fopen(outfile, 'w');
hdr = ['Cruise,Type,Date_Time_[UTC],', ...
       'Longitude_[decimal_degrees_east],Latitude_[decimal_degrees_north],', ...
       'Temperature_[C],Conductivity_[S/m],Salinity_[psu]'];
fprintf(fid, '%s\n', hdr);
for nrec = 1:length(data.jd);
    fprintf(fid, '%s,TSG,%s,%f,%f,%f,%f,%f\n', cruise_id, ...
        datestr(data.jd(nrec), 'yyyy-mm-ddTHH:MM:SS'), ...
        edata(nrec, 2:end));
end

fclose(fid);
