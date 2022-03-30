function [t,powerOut] = tidalStationModel(stationNo)
%% TidalStationModel - 1D model of a single tidal station

%   Looks up data for a given tidal station number, and 
%   converts it into a predicted power generation output series. 

%   Data is in the following format:
%   Column 1 - Station name
%   Column 2 - Median tidal range (m) from high to low water
%   Column 3 - Spring/Neap range deviation from median (m)
%   Column 4 - Area of tidal lagoon (m^2)
%   Column 5 - Phase difference (hours)

%   This is run in a function so that it can be easily repeated many times 
%   for many stations using the same local variables.

%   The model uses a simple estimation of the
%   change in potential energy of the water throughout the day, based on
%   the one presented in Sustainable energy - without the hot air (MacKay
%   D, 2008.).

%% Setup
%   Apend variables from config file
    tidalStationConfig;
    
%% Import data
    
%   Import data from a csv file and keep just the numbers
    stations = importdata(dataFile);
    stationData = stations.data;
    
%   Get the data entry
    s = stationNo;
    
%   Set the parameters to that of the data entry
    area = stationData(s,4);    % Area
    range = stationData(s,1);   % Median range 
    rVar = stationData(s,2);    % Spring/neap range Variation
    phase = stationData(s,3);   % Phase (hours)
    
%   Run common tidal station setup code
    tidalStationSetup;
    
%   Use one way generation model
    tidalStationOneWayEbb
    
%   Power out temp
    powerOut = 1;
    
end
