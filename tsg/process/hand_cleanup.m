function [D2] = hand_cleanup(D)
% function hand_cleanup
% Clean up time series data matrix by walking through each column
% and inspecting for spikes, stuck sensors or other problems.
% Data structure D should have the Julian Date vector in column 1.
% Data seleted for removal is replaced with NaN.
%
% Example:
% a = sin(t/10);
% t = julian(1900,1,1,0):1/24:julian(1902,1,1,0);
% D = [t; a]';
% D2 = hand_cleanup(D);
% SLD 11/19/12
%
% 2021-11-29 ELD: switch from Julian to MATLAB datenum
% First columns should be datenum time
% Also, some modernization of code.
%

% position of figure on screen. Adjust for your screen as needed.
set(gcf, 'position', [5 500 1270 450])

P = D;  % working matrix will be called P 
zf = 5; % zoom factor for selections 1 and 2
bad =[];
badkeep = [];
[m,n] = size(P);

% remove remaining bad data points by hand editing. datenum time must be in column 1
for in = 2:n
  clf;
  xmin = min(P(:,1));
  xmax = max(P(:,1));
  p1 = 1;
  p2 = length(P);
  plot(P(p1:p2,1), P(p1:p2,in), 'b-')
  set(gca, 'xlim', [xmin xmax]);
  % add axis labels
  datetick('x', 31, 'keeplimits')
  done = 0;
  while ~done 
      disp('(1) Zoom In');
      disp('(2) Zoom Out');
      disp('(3) Move Left');
      disp('(4) Move Right');
      disp('(5) Kill Point');
      disp('(6) Kill Range of Points');
      disp('(7) Make High Kill Threshold');
      disp('(8) Make Low Kill Threshold');
      disp('(9) Next Column');
      disp('(0) Set Zoom Factor');
    s1 = input('Enter choice: ');
    xrange = xmax-xmin;
    if s1 == 1      % zoom in
        disp('Click on zoom endpoints ')
        ep = ginput(2);
        xmin = min([ep(1,1) ep(2,1)]);
        xmax = max([ep(1,1) ep(2,1)]);
     elseif s1 == 2  % zoom out
        xmid = (xmax+xmin)/2;
        xmin = xmid - xrange*zf;
        xmax = xmid + xrange*zf;
    elseif s1 == 3  % move left
        xmin = xmin - xrange*3/4;
        xmax = xmax - xrange*3/4;
    elseif s1 == 4  % move right
        xmin = xmin + xrange*3/4;
        xmax = xmax + xrange*3/4;
    elseif s1 == 5  % kill point
        s2 = ginput(1);
        p1 = find(abs(P(:,1)-s2(1,1)) == min(abs(P(:,1)-s2(1,1))), 1, 'first');
        bad = [bad; p1];
    elseif s1 == 6  % kill points
        s2 = ginput(2);
        s2 = sortrows(s2,1);
        p1 = find(abs(P(:,1)-s2(1,1)) == min(abs(P(:,1)-s2(1,1))), 1, 'first');
        p2 = find(abs(P(:,1)-s2(2,1)) == min(abs(P(:,1)-s2(2,1))), 1, 'last');
        bad = [bad; transpose(p1:p2)];
    elseif s1 == 7  % make high kill threshold
        s2 = ginput(1);
        p1 = find(abs(P(:,1)-xmin) == min(abs(P(:,1)-xmin)), 1, 'first');
        p2 = find(abs(P(:,1)-xmax) == min(abs(P(:,1)-xmax)), 1, 'last');
        wbad = find(P(p1:p2,in) > s2(2));  
        bad = [bad; p1+wbad-1];
    elseif s1 == 8  % make low kill threshold
        s2 = ginput(1);
        p1 = find(abs(P(:,1)-xmin) == min(abs(P(:,1)-xmin)), 1, 'first');
        p2 = find(abs(P(:,1)-xmax) == min(abs(P(:,1)-xmax)), 1, 'last');
        wbad = find(P(p1:p2,in) < s2(2));  
        bad = [bad; p1+wbad-1];
    elseif s1 == 9  % next column
        P(badkeep,in) = NaN;
        bad = [];
        badkeep = [];
        done = 1;
    elseif s1 == 0  % set zoom factor
        zf = input('Enter Zoom Factor = ? ');
    end
    xrange = xmax - xmin;
    p1 = find(abs(P(:,1)-xmin) == min(abs(P(:,1)-xmin)));
    p2 = find(abs(P(:,1)-xmax) == min(abs(P(:,1)-xmax)));
        
        goodones = setxor(p1:p2, bad);
        clf; plot(P(goodones,1),P(goodones,in),'b-'); hold on
        set(gca,'xlim',[xmin xmax]);
        datetick('x', 31, 'keeplimits')
        
        if ~isempty(bad)
            plot(P(bad,1),P(bad,in),'r*');
        end
        
        if length(bad) ~= length(badkeep)
          s3 = input('keep changes (1/0)? ');
          if s3
            badkeep = bad;
          else
            bad = badkeep;
          end
        end
  end
end

s4 = input('Keep changes to matrix P?? ');
if s4
    D2 = P;
    disp('All changes kept');
else
    disp('No changes kept');
    D2 = D;
end
