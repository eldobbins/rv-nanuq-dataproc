function outfile = tsg_cleanup_matfile_cruise(input_string, indir)

% Function to do some very basic clean-up on TSG files
% * sort time and remove duplicate timesteps
% * trim 3 cruises that have data at odd times
%
% No hand-edit will be performed until after the merge with navigation
% because there might be some dependence on speed.
% 
% Arguments:
% input_string: can be either a filename or a cruise id. if cruise_id, then
%               then it builds the input filename
% indir: directory where files can be found
% 
% ELD
% 2/9/2022
%

close all

if endsWith(input_string, '.mat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_TSG_L0_v2.mat', input_string);
else
    name = input_string;
end
filename = sprintf('%s/%s', indir, name)

outdir = replace(indir, 'Level_0_v2', 'Level_1'); 
outname = replace(name, 'L0_v2', 'L1_v1');
outfile = sprintf('%s/%s', outdir, outname);

load(filename)

% for some cruises, trim time
T = table(date, temperature, conductivity, salinity, sound_velocity);
if contains(name, 'NUQ202002S')  % oddness at end
    T = T(T.date < datenum(2020, 6, 11, 23, 52, 0), :);
elseif contains(name, 'NUQ202003S')
    T = T(T.date > datenum(2020, 7, 28, 0, 0, 0), :);
elseif contains(name, 'NUQ202005S')
    T = T(T.date < datenum(2020, 11, 7, 0, 0, 0), :);
elseif contains(name, 'NUQ202105S')
    T = T(T.date < datenum(2021, 5, 27, 6, 0, 0), :);
elseif contains(name, 'NUQ202108S')  % first day of this cruise no TSG
    T = T(T.date > datenum(2021, 8, 13, 18, 0, 0), :);
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
temperature = T.temperature;
conductivity = T.conductivity;
salinity = T.salinity; 
sound_velocity = T.sound_velocity;

% save the intermediate version of this file
save(outfile, 'date_str', 'date', 'temperature', 'conductivity', 'salinity', 'sound_velocity');
