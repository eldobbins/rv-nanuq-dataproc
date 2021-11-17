%read_tsg.m
close all
clear all
tsg = load('nuq_tsg.dat');
tday = datenum(tsg(:,1),tsg(:,2),tsg(:,3),tsg(:,4),tsg(:,5),tsg(:,6));
temp = tsg(:,7);
cond = tsg(:,8);
salt = tsg(:,9);
sv = tsg(:,10);

nav = load('nuq_nav.dat');
nday = datenum(nav(:,1),nav(:,2),nav(:,3),nav(:,4),nav(:,5),nav(:,6));
nlat = nav(:,7)+nav(:,8)./60;
nlon = -(nav(:,9)+nav(:,10)./60);
ndep = nav(:,11);

%%
for in = 1:length(tday),
    ind = near(nday,tday(in),1);
    tlat(in) = nlat(ind);
    tlon(in) = nlon(ind);
end
%%
tlat = tlat.';
tlon = tlon.';
[jd,ind] = unique(tday);
temp = temp(ind);
cond = cond(ind);
salt = salt(ind);
lat = tlat(ind);
lon = tlon(ind);
save nuq_tsg jd lat lon temp cond salt
dens = sw_dens(salt, temp, 1);
%%
figure(1)
clf
ens = find(jd > datenum(2020,7,27));

subplot(311)
plot(jd(ens),temp(ens),'ko','markersize',1.2,'markerfacecolor','k')
ylim([6 18])
datetick('keeplimits')
grid on
ylabel('Temp. (\circC)')

subplot(312)
plot(jd(ens),salt(ens),'ko','markersize',1.2,'markerfacecolor','k')
ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Salinity (PSU)')

subplot(313)
plot(jd(ens),dens(ens)-1000,'ko','markersize',1.2,'markerfacecolor','k')
% ylim([10 33])
datetick('keeplimits')
grid on
ylabel('Density (\sigma-\theta)')
