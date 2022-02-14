function convert_to_matfile(input_string, indir)
%
% Function to convert TSG data to matfiles for easier plotting.
% Does all available cruises.
% 
% Arguments:
% input_string: can be either a filename or a cruise id. if cruise_id, then
%               then it builds the input filename
% indir: directory where files can be found
%
% ELD
% 2/12/2022
%

close all

if endsWith(input_string, '.dat') ~= 1  
    % it is the cruise id. Build the file name
    name = sprintf('uaf_%s_TSG_L0_v2.dat', input_string);
else
    name = input_string;
end

filename = sprintf('%s/%s', indir, name)
outfile = replace(filename, '.dat', '.mat');

% load data as table. First column name messed up because of #
% filename = sprintf('%s/uaf_%s_NAV_L0_v2.dat', indir, cruise_id);
T = readtable(filename);
date = datenum(T.x_Year, T.Month, T.Day, T.Hour, T.Minute, T.Second);
date_str = datestr(date);
temperature = T.Temperature; 
conductivity = T.Conductivity;
salinity = T.Salinity;
sound_velocity = T.Sound_Velocity;

save(outfile, 'date_str', 'date', 'temperature', 'conductivity', 'salinity', 'sound_velocity');
