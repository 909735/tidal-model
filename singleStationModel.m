%multiStationModel - model simulating the combined output of multiple tidal
%stations.
%
%   Uses a list of tidal stations with their average range and phases to
%   produce an expected power output over time series.
%   
%   The model is based on a simple tidal model presented in Sustainable 
%   energy - without the hot air (MacKay D, 2008.).
%

% Setup
% Import data from a csv file and keep just the numbers
stations = importdata('StationData.csv');
stationData = stations.data;

% Data entry
s = 1;
% Set the parameters to that of the data entry
a = stationData(s,3);
r = stationData(s,1);
rVar = stationData(s,2);
p = stationData(s,4);

% Initialise data storage
dataWaterLevel = []; %zeros(numStations,1);
dataPowerOut = []; %zeros(numStations,1);
dataPowerTotal = [];

% Generate station outputs
[tM,tD,tV,time] = tidalStationModel(a,r,rVar,p);
    
% Store the data
dataWaterLevel=[dataWaterLevel;tM];
%dataPowerOut=[dataPowerOut;pO];
