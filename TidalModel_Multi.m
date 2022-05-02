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
clc
Config;
 
% Import station data, keep numbers, find no of stations
stations = importdata(dataFile);
stationData = stations.data;
numStations = size(stationData,1);

% Initialise data storage
dataMW = [];            % Power out data store
dataMWAll = [];         % Power out data store for all stations
dataMWTotal = [];       % Power total data store
dataMWh = [];           % MWh data store
dataMWhAll = [];        % MWh data store for all stations
dataMWhTotal = 0;       % MWh total data store

% loop to generate power output for each station
for s=[1:numStations]
    
%   Generate station outputs
    [t,lastMW,lastMWh] = func_stationModel(s);
    
%   Store the data
    dataTime = t;
    dataMW = [dataMW;lastMW];
    dataMWAll(s,:) = lastMW;
    dataMWh = [dataMWh;lastMWh];
    dataMWhAll(s,:) = lastMWh;
    
%   Add cumulative data
    if s==1
        dataMWTotal = lastMW;
        dataMWhTotal = lastMWh;
    else
        dataMWTotal = dataMWTotal+lastMW;
        dataMWhTotal = dataMWhTotal+lastMWh;
    end
end

% Plot stuff
script_drawFiguresMulti;

