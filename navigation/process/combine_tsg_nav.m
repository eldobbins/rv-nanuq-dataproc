function combine_tsg_nav(cruise_id)
%
% Function to combine Navigation and TSG data streams together to 
% create a single .mat file.  Also produces timeseries plot as a check
% 
% read_tsg.m code originally from Hank. Adapted by ELD
% 2021-11-17
%

close all
indir = sprintf('../data/Level_0/%s', cruise_id);
outdir = sprintf('../data/Level_1/%s', cruise_id);

outfile = sprintf('%s/uaf_%s_TSG_L1_v1.mat', outdir, ...
    replace(cruise_id, '_all', ''));

% load data
filename = sprintf('%s/uaf_%s_TSG_L0_v1.dat', indir, cruise_id);
tsg = load(filename);
tday = datenum(tsg(:,1),tsg(:,2),tsg(:,3),tsg(:,4),tsg(:,5),tsg(:,6));
temp = tsg(:,7);
cond = tsg(:,8);
salt = tsg(:,9);
sv = tsg(:,10);  % but don't save speed of sound

filename = sprintf('%s/uaf_%s_NAV_L0_v1.dat', indir, cruise_id);
nav = load(filename);
nday = datenum(nav(:,1),nav(:,2),nav(:,3),nav(:,4),nav(:,5),nav(:,6));
nlat = nav(:,7)+nav(:,8)./60;
nlon = -(nav(:,9)+nav(:,10)./60);
ndep = nav(:,11);  % but don't save bottom depth or the other nav variables

% Identify the navigation points closest to the TSG points in time.
% No interpolation needed because Nav is at high resolution.
for in = 1:length(tday)
    ind = near(nday,tday(in),1);
    tlat(in) = nlat(ind);
    tlon(in) = nlon(ind);
end

% Assemble data at same time points
tlat = tlat.';
tlon = tlon.';
[jd,ind] = unique(tday);
temp = temp(ind);
cond = cond(ind);
salt = salt(ind);
lat = tlat(ind);
lon = tlon(ind);

% Save to the output file.  Combining data migrates it from Level 0 to
% Level 1 since it is manipulated.
if ~exist(outdir, 'dir')
    mkdir(outdir)
end
save(outfile, 'jd', 'lat', 'lon', 'temp', 'cond', 'salt');
