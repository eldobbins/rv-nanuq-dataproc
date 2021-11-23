function plot_level1_timeseries(cruise_id)
%
% Produces timeseries plot to serve as a check on the function that 
% combines Navigation and TSG data streams together to 
% create a single .mat file.
%
% Requires that the sea water toolbox be installed (for sw_dens).
% 
% 2nd half of the read_tsg.m code originally from Hank. Adapted by ELD
% 2021-11-22
%

close all
indir = sprintf('../data/Level_1/%s', cruise_id);
pltdir = indir;

filename = sprintf('%s/uaf_%s_TSG_L1_v1.mat', indir, ...
    replace(cruise_id, '_all', ''));
load(filename, 'jd', 'temp', 'salt')

% subset the data
if strcmp(cruise_id, 'NUQ202003S_all')
    ens = find(jd > datenum(2020,7,27));
    jd = jd(ens);
    temp = temp(ens);
    salt = salt(ens);
end

dens = sw_dens(salt, temp, 1);

%
figure(1)
clf

subplot(311)
plot(jd, temp, 'ko', 'markersize', 1.2, 'markerfacecolor', 'k')
ylim([6 18])
datetick('keeplimits')
grid on
ylabel(sprintf('Temp. (%cC)', char(176)))
title(sprintf('%s: Temp. (%cC)', cruise_id, char(176)), 'Interpreter', 'None')

subplot(312)
plot(jd, salt, 'ko', 'markersize', 1.2, 'markerfacecolor', 'k')
ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Salinity (PSU)')
title(sprintf('%s: Salinity (PSU)', cruise_id), 'Interpreter', 'None')

subplot(313)
plot(jd, dens-1000, 'ko', 'markersize', 1.2, 'markerfacecolor', 'k')
% ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Density (kg/m3)')
title(sprintf('%s: Density as sigma-theta)', cruise_id), 'Interpreter', 'None')

pltname = sprintf('%s/TSG_timeseries.png', pltdir);
print('-dpng', '-r300', pltname);

