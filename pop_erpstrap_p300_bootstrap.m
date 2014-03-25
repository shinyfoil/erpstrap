% pop_erpstrap_p300_bootstrap() - GUI for erpstrap P300 boostrap
% 
% This program prompts the user for settings required to calculate the P300
% bootstrap test
% 
% Usage:
%   >> [ EEGOUT, COM ] = pop_erpstrap_p300_bootstrap( EEG )
%   
% Command line usage:
%   >> [ EEGOUT, COM ] = pop_erpstrap_p300_bootstrap( EEG, iter, chan,...
%   critEvent, otherEvent, p3Wind, sWind, sType );
%       
% Inputs:
% 
%     EEG         - EEGLAB EEG structure
%     iter        - number of iterations to perform (default: [] = 1000)
%     chan        - index of channels to process
%     critEvent   - string of critical event code
%     otherEvent  - string of other event code
%     p3Wind      - P300 search window (default: [] = [0.3 0.65])
%     sWind       - width of averaging window (default: [] = 0.1)
%     sType       - type of search to perform: absolute peak or min/max
%                   window (default: [] = 'slide')
%     
% GUI Inputs:
% 
% Number of iterations: the number of times the test will calculate the
% test statistic, per channel. Default: 1000 iterations per channel.
% 
% Channels: you must specify the indicies of channels for which you wish to
% calculate the test statistic.
% 
% Critical event: you must specify the event code for the critical event
% (the event that has the P300).
% 
% Other event: you must specify the event code for the other event (the
% baseline event, without the P300).
% 
% P300 search window: the start and end times where the P300 should be
% searched for. Default: 0.3 sec to 0.65 sec
% 
% Search window width: the width of the averaging window. Default: 0.1 sec
% 
% Search type: the type of search to perform. Either building a window
% around the extreme points in the waveform, or by searching the waveform
% for the windows with extreme averages. Default: min/max sliding window.
% 
% Author: Richard Mah, McMaster University, 2014

% Copyright (C) 2014, Richard Mah, McMaster University, mahrl@mcmaster.ca
%
% This program is free software: you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by the
% Free Software Foundation, either version 3 of the License, or (at your
% option) any later version.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
% Public License for more details.
% 
% You should have received a copy of the GNU General Public License along
% with this program.  If not, see <http://www.gnu.org/licenses/>.
