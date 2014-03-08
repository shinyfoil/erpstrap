% eegplugin_erpstrap() - EEGLAB plugin for computing statistical boostraps on 
%							individual participant data
%
% Usage:
%   >>  eegplugin_erpstrap( fig, trystrs, catchstrs );
%
% Inputs:
%   fig        - [integer]  EEGLAB figure
%   trystrs    - [struct] "try" strings for menu callbacks.
%   catchstrs  - [struct] "catch" strings for menu callbacks.
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

function version = eegplugin_erpstrap( fig, trystrs, catchstrs );

	version = 'erpstrap 0.1';

if nargin < 1
	help sample;
	return;
end;	
