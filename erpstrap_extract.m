function [ subset ] = erpstrap_extract( data, channels, events )
% erpstrap_extract() - a function to extract data for bootstrapping 
%
% Usage:
%   >>  subset = erpstrap_extract( data, channels, events );
%
% Inputs:
%   data        - [struct] EEGLAB EEG dataset
%   channels    - [double] 
%   events      - [double] 
% 
% Outputs:
%   subset      - [struct] EEG data containing trials of interest
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

if nargin < 3
	help erpstrap_extract;
	return;
end;

if isempty(data)
    error('erpstrap_extract: cannot process empty sets of data');
end;

% Save some info about the data for later
subset.srate = data.srate;
subset.pnts = data.pnts;
subset.nbchan = length(channels);
subset.xmin = data.xmin;
subset.xmax = data.xmax;

% Collect channel labels
for index = 1:length(channels)
    temp(index) = {data.chanlocs(channels(index)).labels};
end;
subset.labels = temp;
clear temp;

% Find events
eventTemp = [];
eventLength = [];

for event = 1:length(events)
    temp = [];

    for index = 1:length(data.epoch)
        for i = 1:length(data.epoch(index).eventtype)
            if strcmp(data.epoch(index).eventtype(i), char(events(event)))
            temp = [temp index];
            end;
        end;
    end;
    eventLength = [eventLength length(temp)];
    eventTemp = [eventTemp temp];
end;

subset.eventLengths = eventLength;
subset.events = eventTemp;
clear temp eventTemp eventLengths;

% Get the data from the dataset
subset.data = data.data(channels, :, subset.events);

end