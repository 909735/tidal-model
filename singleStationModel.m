%%  Single Station Model
%   model simulating the combined output of multiple tidal stations.

%   Uses a list of tidal stations with their average range and phases to
%   produce an expected power output over time series.

%   The model is based on a simple tidal model presented in Sustainable 
%   energy - without the hot air (MacKay D, 2008.).

%% Setup

% Data entry
stationNo = 1;

% Initialise data storage
dataMW = [];      % Power out data store
dataMWh = [];           % MWh data store 

% Generate station outputs
[t,lastMW,lastMWh] = tidalStationModel(stationNo);

% Store the data
dataMW = [dataMW;lastMW];
dataTime = t;        % time will be the same length for all stations.
dataMWh = [dataMWh;lastMWh];
