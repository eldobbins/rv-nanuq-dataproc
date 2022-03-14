%
% The level 1 CSV files are really big. Plotting etc. will be more 
% convenient if I convert the original CSV files into .mat files. And 
% since I'm doing that, I might as well add cog and spog.
%
% I'm in a rush, so just process all the files in the directory.
%
% ELD
% 3/14/2022
%

%cruises = {'NUQ201901S'};
indir = '~/Desktop/NGA LTER/Underway/met_station/Level_1/';
files = dir(indir);

for f = 1:length(files)
    % load the file
    name = files(f).name;
    if startsWith(name, 'nga') ~= 1 | endsWith(name, '.csv') ~= 1
        %disp('not this file')
        continue
    end
    
%     input_string = cruises{c};
%     name = sprintf('nga_%s_m3s_L1_v1.csv', input_string);

    filename = sprintf('%s/%s', indir, name)
    data = read_m3s_dat(filename);
    [data.cog, data.spog] = compute_course(data.time, data.latitude, data.longitude);

    outfile = replace(filename, '.csv', '.mat')
    save(outfile, '-struct', 'data');
    
end