%%  Multi Station Model
%   Model simulating the combined output of all tidal stations in specified 
%   data file.
%
%   Calls the model function which will calculate all information and data
%   from a particular site. This is then stored and summed for a total
%   output.
%   
%   The model is based on a simple tidal model presented in Sustainable 
%   energy - without the hot air (MacKay D, 2008.).

% Setup
Config;

% Import station data, keep numbers, find no of stations
file=simpleDataFile;
if dataMode=="actual"
    file=actualDataFile;
end

stations = importdata(file);
numStations = size(stations.data,1);

% Initialise data storage
dataMW = [];            % Power out data store
dataMWTotal = [];       % Power total data store
dataMWh = [];           % MWh data store
dataMWhTotal = 0;       % MWh total data store

% Start figures
figure(1); clf(1);
title('Combined station output')
ylabel('power out (MW)')
xlabel('time (hrs)')
hold on

% loop to generate power output for each station
for stationNo=[1:numStations]
    
%   Generate station outputs
    [t,lastMW,lastMWh] = func_stationModel(stationNo);
    
%   Store the data
    dataTime = t;
    dataMW = [dataMW;lastMW];
    dataMWh = [dataMWh;lastMWh];
%   Add cumulative data
    if stationNo==1
        dataMWTotal = lastMW;
        dataMWhTotal = lastMWh;
    else
        dataMWTotal = dataMWTotal+lastMW;
        dataMWhTotal = dataMWhTotal+lastMWh;
    end
    
%   Plot
    figure(1), plot(dataTime,dataMW),
end

plot(t,dataMWTotal,'-k','LineWidth',2)