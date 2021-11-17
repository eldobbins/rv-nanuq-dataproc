function read_tsg(cruise_id)
%
% Function to combine Navigation and TSG data streams together to 
% create a single .mat file.  Also produces timeseries plot as a check
%
% Requires that the sea water toolbox be installed (for sw_dens).
% Remove the .mat file if you want to recompute it (takes a long time).
% 
% Code originally from Hank. Adapted by ELD
% 2021-11-17
%

close all
indir = sprintf('../data/Level_0/%s', cruise_id);
outdir = sprintf('../data/Level_1/%s', cruise_id);

outfile = sprintf('%s/%s_TSG.mat', outdir, cruise_id);
if ~exist(outfile, 'file')

    % load data
    filename = sprintf('%s/NUQ_TSG_%s.dat', indir, cruise_id);
    tsg = load(filename);
    tday = datenum(tsg(:,1),tsg(:,2),tsg(:,3),tsg(:,4),tsg(:,5),tsg(:,6));
    temp = tsg(:,7);
    cond = tsg(:,8);
    salt = tsg(:,9);
    sv = tsg(:,10);

    filename = sprintf('%s/NUQ_NAV_%s.dat', indir, cruise_id);
    nav = load(filename);
    nday = datenum(nav(:,1),nav(:,2),nav(:,3),nav(:,4),nav(:,5),nav(:,6));
    nlat = nav(:,7)+nav(:,8)./60;
    nlon = -(nav(:,9)+nav(:,10)./60);
    ndep = nav(:,11);

    % Identify the navigation points closest to the TSG points in time.
    % No interpolation needed because Nav is at high resolution.
    for in = 1:length(tday),
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
    save(outfile, 'jd', 'lat', 'lon', 'temp', 'cond', 'salt');
else
    load(outfile, 'jd', 'temp', 'salt')
end

%
figure(1)
clf
ens = find(jd > datenum(2020,7,27));

subplot(311)
plot(jd(ens),temp(ens),'ko','markersize',1.2,'markerfacecolor','k')
ylim([6 18])
datetick('keeplimits')
grid on
ylabel(sprintf('Temp. (%cC)', char(176)))
title(sprintf('%s: Temp. (%cC)', cruise_id, char(176)), 'Interpreter', 'None')

subplot(312)
plot(jd(ens),salt(ens),'ko','markersize',1.2,'markerfacecolor','k')
ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Salinity (PSU)')
title(sprintf('%s: Salinity (PSU)', cruise_id), 'Interpreter', 'None')

subplot(313)
dens = sw_dens(salt, temp, 1);
plot(jd(ens),dens(ens)-1000,'ko','markersize',1.2,'markerfacecolor','k')
% ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Density (kg/m3)')
title(sprintf('%s: Density as sigma-theta)', cruise_id), 'Interpreter', 'None')
