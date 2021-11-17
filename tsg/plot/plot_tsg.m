close all
clear
load nuq_tsg
plot_cruise_track = 1;
plot_vars = 1;
plot_chl = 0;
dens = sw_dens(salt, temp, 1);
sz = 20;
skp = 10;
%%
% load chuk_bath
% load /Users/hstats/Documents/LTER/mapping/AlaskaBathy.mat

load /Users/hstats/Documents/LTER/mapping/AlaskaXYZ.mat
XE = XE - 360;
ZE = -ZE;

lonrng = [-150 -143];
latrng = [59 61.3];
proj = 'lambert';
scrsz = get(0,'ScreenSize');            %get screensize for full screen figure output

%%
if plot_cruise_track,
%     figure(1);                              %plot onto figure #1
%     set( 1, 'Position', scrsz);
%     
%     m_proj(proj,'lat',latrng,'lon',lonrng);
%     %m_gshhs_f('save','GOA.mat')
%     m_usercoast('GOA.mat','patch',[0.7 0.7 0.7]);
%     m_grid('xtick', 3,'ytick', 3, 'fontsize', 12)
%     hold on
%     [cs,h] = m_contour(XE,YE,ZE,[20 30 40 50 60 100 150 200 300 500 1000 2000 3000],'color',[.6 .6 .6]);
%     %clabel(cs,h,'fontsize',6);
%     %clabel(cs,h,'LabelSpacing',72,'Color','b','FontWeight','bold')
%     set(h,'linewidth',.7)
%     
%     h1 = m_plot( lon, lat, '.', 'color', 'r', 'linewidth', 2); hold on
%     % h2 = m_plot( gridded.lon(cols(1)), gridded.lat(cols(1)), 'o', 'color', 'k', 'markersize', 4, 'linewidth', 2, 'markerfacecolor', 'g')
%     
%     m_ruler([0.5 0.8], .1);
    %     close
    print('-dpng','-r300','TSG_Cruise_track.png');
end
%%
if plot_vars,
    figure(2);                              %plot onto figure #1
    set( 2, 'Position', scrsz);
    m_proj(proj,'lat',latrng,'lon',lonrng);
    % m_gshhs_f('save','GOA.mat')
    m_usercoast('GOA.mat','patch',[0.7 0.7 0.7]);
    m_grid('xtick', 3,'ytick', 3, 'fontsize', 12)
    hold on
    [cs,h] = m_contour(XE,YE,ZE,[20 30 40 50 60 100 150 200 300 500 1000 2000 3000],'color',[.6 .6 .6]);
    %clabel(cs,h,'fontsize',6);
    %clabel(cs,h,'LabelSpacing',72,'Color','b','FontWeight','bold')
    set(h,'linewidth',.7)
    
    % h1 = m_plot( lon, lat, '-', 'color', 'r', 'linewidth', 2);
    %hold on
    m_scatter(lon(1:skp:end), lat(1:skp:end), sz, temp(1:skp:end),'filled')
    % h2 = m_plot( gridded.lon(cols(1)), gridded.lat(cols(1)), 'o', 'color', 'k', 'markersize', 4, 'linewidth', 2, 'markerfacecolor', 'g')
    
    m_ruler([0.7 0.9], .1);
    caxis([6 18])
    cb = colorbar('Location','SouthOutside');
    set( cb, 'fontsize', 12, 'fontweight', 'normal', 'ytick', [6:.5:18])
    ylabel( cb, 'Temperature [\circC]', 'fontsize', 12,'fontname','Times');
    
    print('-dpng','-r300','TSG_map_temp.png');
    close
    %%
    figure(3);                              %plot onto figure #1
    set( 3, 'Position', scrsz);
    m_proj(proj,'lat',latrng,'lon',lonrng);
    % m_gshhs_f('save','GOA.mat')
    m_usercoast('GOA.mat','patch',[0.7 0.7 0.7]);
    m_grid('xtick', 3,'ytick', 3, 'fontsize', 12)
    hold on
    [cs,h] = m_contour(XE,YE,ZE,[20 30 40 50 60 100 150 200 300 500 1000 2000 3000],'color',[.6 .6 .6]);
    %clabel(cs,h,'fontsize',6);
    %clabel(cs,h,'LabelSpacing',72,'Color','b','FontWeight','bold')
    set(h,'linewidth',.7)
    
    % h1 = m_plot( lon, lat, '-', 'color', 'r', 'linewidth', 2);
    %hold on
    m_scatter(lon(1:skp:end), lat(1:skp:end), sz, salt(1:skp:end),'filled')
    % h2 = m_plot( gridded.lon(cols(1)), gridded.lat(cols(1)), 'o', 'color', 'k', 'markersize', 4, 'linewidth', 2, 'markerfacecolor', 'g')
    
    m_ruler([0.7 0.9], .1);
    caxis([20 33])
    cb = colorbar('Location','SouthOutside');
    set( cb, 'fontsize', 12, 'fontweight', 'normal', 'ytick', [20:1:33])
    ylabel( cb, 'Salinity', 'fontsize', 12,'fontname','Times');
    print('-dpng','-r300','TSG_map_salt.png');
    
    %%
    figure(4);                              %plot onto figure #1
    set( 4, 'Position', scrsz);
    m_proj(proj,'lat',latrng,'lon',lonrng);
    % m_gshhs_f('save','GOA.mat')
    m_usercoast('GOA.mat','patch',[0.7 0.7 0.7]);
    m_grid('xtick', 3,'ytick', 3, 'fontsize', 12)
    hold on
    [cs,h] = m_contour(XE,YE,ZE,[20 30 40 50 60 100 150 200 300 500 1000 2000 3000],'color',[.6 .6 .6]);
    %clabel(cs,h,'fontsize',6);
    %clabel(cs,h,'LabelSpacing',72,'Color','b','FontWeight','bold')
    set(h,'linewidth',.7)
    
    % h1 = m_plot( lon, lat, '-', 'color', 'r', 'linewidth', 2);
    %hold on
    m_scatter(lon(1:skp:end), lat(1:skp:end), sz, dens(1:skp:end)-1000,'filled')
    % h2 = m_plot( gridded.lon(cols(1)), gridded.lat(cols(1)), 'o', 'color', 'k', 'markersize', 4, 'linewidth', 2, 'markerfacecolor', 'g')
    
    m_ruler([0.7 0.9], .1);
    caxis([8 25])
    cb = colorbar('Location','SouthOutside');
    set( cb, 'fontsize', 12, 'fontweight', 'normal', 'ytick', [8:1:25])
    ylabel( cb, 'Sigma-T', 'fontsize', 12,'fontname','Times');
    print('-dpng','-r300','TSG_map_dens.png');
end
%%
if plot_chl,
    st = datenum(2020,7,26);
    nd = datenum(2020,8,10);
    ens = find(time >= st & time <= nd);
    figure(2)
    clf
    subplot(411)
    plot(time(ens),chl(ens),'k')
    axis tight
    datetick('x',6)
    grid on
    ylim([0 6.5e4])
    ylabel('Chl-a')
    
    subplot(412)
    plot(time(ens),phy(ens),'k')
    axis tight
    datetick('x',6)
    grid on
    ylim([10.25 11.2])
    ylabel('Phy. (RFU)')
    
    subplot(413)
    plot(time(ens),cdom(ens),'k')
    axis tight
    datetick('x',6)
    grid on
    ylim([10 80])
    ylabel('CDOM (RFU)')
    
    subplot(414)
    plot(time(ens),turb(ens),'k')
    axis tight
    datetick('x',6)
    grid on
    ylim([0 100])
    ylabel('Turb. (RFU)')
    
    print('-dpng','-r300','TSG_trace_chl.png');
    
   
        figure(3);                              %plot onto figure #1
        set( 3, 'Position', scrsz);
        m_proj(proj,'lat',latrng,'lon',lonrng);
        % m_gshhs_f('save','GOA.mat')
        m_usercoast('GOA.mat','patch',[0.7 0.7 0.7]);
        m_grid('xtick', 3,'ytick', 3, 'fontsize', 12)
        hold on
        [cs,h] = m_contour(XE,YE,ZE,[20 30 40 50 60 100 150 200 300 500 1000 2000 3000],'color',[.6 .6 .6]);
        %clabel(cs,h,'fontsize',6);
        %clabel(cs,h,'LabelSpacing',72,'Color','b','FontWeight','bold')
        set(h,'linewidth',.7)
        
        %h1 = m_plot( lon(ens), lat(ens), 'o', 'color', 'k', 'linewidth', .5);
        %hold on
        %m_scatter(lon(1:skp:end), lat(1:skp:end), sz, chl(1:skp:end),'filled');
        m_scatter(lon(ens(1):skp:ens(end)), lat(ens(1):skp:ens(end)), sz, chl(ens(1):skp:ens(end)),'filled');
        % h2 = m_plot( gridded.lon(cols(1)), gridded.lat(cols(1)), 'o', 'color', 'k', 'markersize', 4, 'linewidth', 2, 'markerfacecolor', 'g')
        
        m_ruler([0.7 0.9], .1);
        %caxis([10.25 11.2])
        cb = colorbar('Location','SouthOutside');
        set( cb, 'fontsize', 12, 'fontweight', 'normal'); %, 'ytick', [30:.25:32.7])
        ylabel( cb, 'chl-a [RFU]', 'fontsize', 12,'fontname','Times');
        print('-dpng','-r300','TSG_map_chl.png');
    
end