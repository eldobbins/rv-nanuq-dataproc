
indir = '../../data/Navigation/Level_0_v2';
cruise_id = 'NUQ202002S';
% outdir = '../../data/Level_0_v2'; write out to same directory

% dir('../../data/Navigation/Level_0_v2')


filename = sprintf('%s/uaf_%s_NAV_L0_v2.mat', indir, cruise_id)
load(filename)

figure(1)
plot(lon, lat)

figure(2)

subplot(4, 1, 1)
plot(date, depth)
title('Depth')
datetick('x', 'mm-dd HH:MM')

subplot(4, 1, 2)
plot(date, heading, '.')
title('Heading')
datetick('x', 'mm-dd HH:MM')

subplot(4, 1, 3)
plot(date, cog, '.')
title('Course over Ground')
datetick('x', 'mm-dd HH:MM')

subplot(4, 1, 4)
plot(date, sog)
title('Speed over Ground')
datetick('x', 'mm-dd HH:MM')
