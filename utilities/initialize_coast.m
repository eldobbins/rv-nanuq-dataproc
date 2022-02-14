% Script to make the coastline file for the plotting scripts
%
% Note: it requires that m_map is installed.
% https://www.eoas.ubc.ca/~rich/mapug.html
% with its GSHHS coastline database
%
% ELD
% 2/13/2022

% for the map
proj = 'lambert';
lonrng = [-150 -143];
latrng = [59 61.3];
m_proj(proj, 'lat', latrng, 'lon', lonrng);
m_gshhs_h('save','../goa_coast');
