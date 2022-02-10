function combine_tsg_nav(cruise_id)
%
% Function to combine Navigation and TSG data streams together to 
% create a single .mat file.  Also produces timeseries plot as a check
% 
% read_tsg.m code originally from Hank. Adapted by ELD
% 2021-11-17
%

addpath('../../utilities/')

close all
tsgdir = '../../data/TSG/Level_1'; 
navdir = '../../data/Navigation/Level_1'; 

files = dir(tsgdir);
for f = 1:length(files)
    name = files(f).name;
    
    % load the tsg data
    if startsWith(name, 'uaf') ~= 1 | endsWith(name, '.mat') ~= 1
        continue
    end
    filename = sprintf('%s/%s', tsgdir, name)
    outfile = filename;
    load(filename)
    tday = date;
    
    % load the navigation data
    filename = sprintf('%s/%s', navdir, replace(name, 'TSG', 'NAV'))
    load(filename)
    nday = date;
    nlat = lat;
    nlon = lon;
    nsog = sog;

% % load data
% filename = sprintf('%s/uaf_%s_TSG_L0_v1.dat', indir, cruise_id);
% tsg = load(filename);
% tday = datenum(tsg(:,1),tsg(:,2),tsg(:,3),tsg(:,4),tsg(:,5),tsg(:,6));
% temp = tsg(:,7);
% cond = tsg(:,8);
% salt = tsg(:,9);
% sv = tsg(:,10);  % but don't save speed of sound
% 
% filename = sprintf('%s/uaf_%s_NAV_L0_v1.dat', indir, cruise_id);
% nav = load(filename);
% nday = datenum(nav(:,1),nav(:,2),nav(:,3),nav(:,4),nav(:,5),nav(:,6));
% nlat = nav(:,7)+nav(:,8)./60;
% nlon = -(nav(:,9)+nav(:,10)./60);
% ndep = nav(:,11);  % but don't save bottom depth or the other nav variables

    % Identify the navigation points closest to the TSG points in time.
    % No interpolation needed because Nav is at high resolution.
    lat = nan(length(tday), 1);
    lon = nan(length(tday), 1);
    sog = nan(length(tday), 1);
    for in = 1:length(tday)
        ind = near(nday,tday(in),1);
        lat(in) = nlat(ind);
        lon(in) = nlon(ind);
        sog(in) = nsog(ind);
    end
    date = tday;


% % Assemble data at same time points
% tlat = tlat.';
% tlon = tlon.';
% [jd,ind] = unique(tday);
% temp = temp(ind);
% cond = cond(ind);
% salt = salt(ind);
% lat = tlat(ind);
% lon = tlon(ind);
% 
% % Save to the output file.  Combining data migrates it from Level 0 to
% % Level 1 since it is manipulated.
% if ~exist(outdir, 'dir')
%     mkdir(outdir)
% end
    save(outfile, 'date', 'lat', 'lon', 'sog', ...
    'temperature', 'conductivity', 'salinity', 'sound_velocity');
end
