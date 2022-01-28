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

numStations = size(stationData,1);

% Initialise data storage
dataWaterLevel = []; %zeros(numStations,1);
dataPowerOut = []; %zeros(numStations,1);
dataPowerTotal = [];

% Start figures
figure(4); clf(4);
title('Individual station output')

% loop to generate power output for each station
for s=[1:numStations]
    
%   Read the data entry
    a = stationData(s,3);
    r = stationData(s,1);
    p = stationData(s,2);
    
%   Generate station outputs
    [wL,pO,time] = tidalStation1D(a,r,p);
    
%   Store the data
    dataWaterLevel=[dataWaterLevel;wL];
    dataPowerOut=[dataPowerOut;pO];
    if s==1
        dataPowerTotal = pO;
    else
        dataPowerTotal = dataPowerTotal+pO;
    end
    
%   Plot
    plot(time,pO)
    hold on
end

plot(time,dataPowerTotal,'-.')