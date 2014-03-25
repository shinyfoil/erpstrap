function [ stat allstat ] = erpstrap_compute_p300_bootstrap( data, iterations, p3wind, window )
% erpstrap_compute_p300_bootstrap() - a function to compute the P300
% bootstrap
%
% Usage:
%   >>  function [ stat allstat ] = erpstrap_compute_p300_bootstrap( data, iterations );
%
% Inputs:
%   data        - [struct] erpstrap subset of data of interest
%   iterations  - [double] number of iterations to compute distribution
%   p3wind      - [double] start and end point of P300 window
%   window      - [double] width of P300 window
% 
% Outputs:
%   stat        - [double] number of iterations where the critical
%                          condition's mean amplitude was greater than the
%                          other condition's
%   allstat     - [double] the difference in mean amplitude between
%                          conditions for each iteration. Difference is
%                          calculated as critical condition minus
%                          other condition.
%
% Author: Richard Mah, McMaster University, 2014

% Copyright (C) 2014, Richard Mah, McMaster University, mahrl@mcmaster.ca
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

if nargin < 2
    help erpstrap_compute_p300_bootstrap;
    return;
end;

if isempty(data)
    error('erpstrap_compute_p300_bootstrap: cannot process empty sets of data');
end;

%% Getting ready to rock
baseline = ceil(abs(data.xmin) * data.srate);
nTrials = data.eventLengths(1);
p3pts = ceil(p3wind * data.srate) + baseline;
widthpts = ceil(window * data.srate);
halfwide = floor(widthpts / 2);
slidepts = p3pts(2) - p3pts(1) - widthpts;

stat = zeros(data.nbchan, 1);
allstat = zeros(data.nbchan, iterations);


%% It's COMPUTATION TIME!
for i = 1:data.nbchan
    for j = 1:iterations
        %% Randomly select trials for averaging
        critCondTrials = randi([1 data.eventLengths(1)], 1, nTrials);
        otherCondTrials = randi([data.eventLengths(1) + 1 ...
            length(data.events)], 1, nTrials);
        
        %% Make it so
        critRandSum = sum(data.data(i, : , critCondTrials), 3);
        otherRandSum = sum(data.data(i, : , otherCondTrials), 3);
        
        critRandMean = critRandSum / nTrials;
        otherRandMean = otherRandSum / nTrials;
        
        %% Pos peak find crit
        critPosPeak = ind2sub(size(critRandMean), find(critRandMean == max(critRandMean(p3pts(1):p3pts(2)))));
        critPosPeakMean = sum(critRandMean((critPosPeak - halfwide):(critPosPeak + halfwide))) / widthpts;
        
        %% Neg peak find crit
        critNegPeak = ind2sub(size(critRandMean), find(critRandMean == max(critRandMean(critPosPeak:data.pnts))));
        
        % Check to see if neg peak window will extend past end
        if ((critNegPeak + halfwide) > data.pnts)
            critNegPeak = data.pnts - halfwide;
        end;
                
        critNegPeakMean = sum(critRandMean((critNegPeak - halfwide):(critNegPeak + halfwide))) / widthpts;
        
        %% Crit difference
        critDiff = critPosPeakMean - critNegPeakMean;
        
        %% Pos peak find other
        otherPosPeak = ind2sub(size(otherRandMean), find(otherRandMean == max(otherRandMean(p3pts(1):p3pts(2)))));
        otherPosPeakMean = sum(otherRandMean((otherPosPeak - halfwide):(otherPosPeak + halfwide))) / widthpts;
        
        %% Neg peak find other
        otherNegPeak = otherPosPeak + ind2sub(size(otherRandMean), find(otherRandMean == max(otherRandMean(otherPosPeak:data.pnts))));

        % Check to see if neg peak window will extend past end
        if ((otherNegPeak + halfwide) > data.pnts)
            otherNegPeak = data.pnts - halfwide;
        end;
        
        otherNegPeakMean = sum(otherRandMean((otherNegPeak - halfwide):(otherNegPeak + halfwide))) / widthpts;
        
        %% Other difference
        otherDiff = otherPosPeakMean - otherNegPeakMean;
        
        %% Difference of differences (calculate test statistic)
        teststat = critDiff - otherDiff;
        
        %% Paperwork...
        if(teststat > 0)
            stat(i) = stat(i) + 1;
        end;
        
        allstat(i, j) = teststat;
    end;  
end;