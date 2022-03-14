function data = read_m3s_dat(filename)
%
% Function that reads the contents of a M3S data file and puts
% the content into a data structure for easy access later.
%
% Will read both the 5 sec (for production) and 1 minute averages (for 
% testing).  
%
% ELD 10/20/2021
%

fid = fopen(filename)

% read the header lines
data.info = fgetl(fid);
data.names = fgetl(fid);
data.units = fgetl(fid);
data.type = fgetl(fid);

% there are 2 different types of files with 
% different numbers of columns
vars = replace(data.names, '"', '');
vars = split(vars, ',')

% read the rest of the file into a cell array
if length(vars) == 10  % 1 minute averages
    fmtstr = "%s%d%f%f%f%f%d%f%d%f";
elseif length(vars) == 17  % 5 sec
    fmtstr = "%s%d%f%f%f%f%f%f%f%f%d%f%d%f%f%f%d";
end
C = textscan(fid, fmtstr, 'Delimiter', ',', 'TreatAsEmpty', {'"NAN"'});
fclose(fid);

% put the contents of the cell array into the data structure
for col = 1:length(vars)
    command = ['data.', vars{col}, ' = C{', num2str(col), '};'];
    disp(command)
    eval(command);
end
% plot(data.AirTC_Avg)

% some other stuff that will be useful later on
data.time = datenum(data.TIMESTAMP);
data.longitude = double(data.Longitude_A) + data.Longitude_B/60;
data.latitude = double(data.Latitude_A) + data.Latitude_B/60;

%scatter(data.longitude, data.latitude, 5, data.AirTC_Avg)
%colorbar()
