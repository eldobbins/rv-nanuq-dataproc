function [cog, spog] = compute_course(time, latitude, longitude)
%
% Compute the course and speed over ground required for the 
% wind corrections.
%
% Arguments:
% time:  vector of times of position fixes (datenum)
% latitude: vector of decimal degrees (-90 to 90)
% longitude: vector of decimal degrees (east positive)
%
% Returns:
% cog: course over ground (degrees clockwise from north, -180 to 180)
% spog: speed over ground (m/s)


% diference in time between fixes in seconds
dt_s = diff(time) * 86440;

cog = [];   % course over ground
spog = [];  % speed over ground
for index = 1:length(time)-1
    
    lat1 = latitude(index);
    lat2 = latitude(index+1);
    lon1 = longitude(index);
    lon2 = longitude(index+1);
    [s12, azi1, azi2] = geoddistance(lat1, lon1, lat2, lon2);
    
    spog = [spog; s12/dt_s(index)];
    cog = [cog; azi1];
    
end

% pad the end
spog = [spog; NaN];
cog = [cog; NaN];