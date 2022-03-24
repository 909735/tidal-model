%multiStationModel - model simulating the combined output of multiple tidal
%stations.
%
%   Uses a list of tidal stations with their average range and phases to
%   produce an expected power output over time series.
%   
%   The model is based on a simple tidal model presented in Sustainable 
%   energy - without the hot air (MacKay D, 2008.).
%
%% Setup

% Read the config file
tidalStationConfig;

% Data entry
stationNo = 1;

% Initialise data storage
dataPowerOut = [];      % 
dataTime = [];          %

% Generate station outputs
[time,powerOut] = tidalStationModel(stationNo);
    
% Store the data
dataPowerOut=[dataPowerOut;powerOut];
