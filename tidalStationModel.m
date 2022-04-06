function [t,WOut,MWh] = tidalStationModel(stationNo)
%% TidalStationModel - 1D model of a single tidal station

%   Looks up data for a given tidal station number, and 
%   converts it into a predicted power generation output series.

%   Outputs:
%   t - time series
%   powerOut - power output series
%   MWh - Cumulative energy out over specified period (same as graphs)

%   Inputs:
%   stationNo - Data entry number for given station, read from .csv file.

%   Data is in the following format:
%   Column 1 - Station name
%   Column 2 - Median tidal range (m) from high to low water
%   Column 3 - Spring/Neap range deviation from median (m)
%   Column 4 - Phase difference (hours)
%   Column 5 - Area of tidal lagoon (m^2)

%   This model is run inside a function to keep all values local for each
%   station.

%   Most calculations are done in sub script and function files. These are:
%     tidalStationConfig - Sets up properties used by many scripts
%     tidalStationSetup - Generates time and sea height series
%     tidalStationOneWay - Lagoon height using one way generation
%     tidalStationTwoWay - Lagoon height using two way generation
%     tidalStationGenPower - Power output using sea/lagoon h difference
%       tidalStationFlow - Function modelling water flow rate
%     tidalStationFigures - Produces plots of the sites' data

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
    area = stationData(s,4);    % Area (km^2)
    range = stationData(s,1);   % Median range (m)
    rVar = stationData(s,2);    % Spring/neap range Variation (m)
    phase = stationData(s,3);   % Phase (hours)
    
%   Run common tidal station setup code
    tidalStationSetup;
    
%   Use one way generation model
    tidalStationOneWay;
    
%   Calculate power output over time using lagoon/sea height, gate opens/closes
    [powerPerKm2,dH] = tidalStationGenPower(hLag,hSea,gateOpens,gateCloses);
    
%   Adjust for area and turbine efficiency
    WIdeal = powerPerKm2*area;
    WOut = WIdeal*turbEff;
    
%   Cumulative power produced out
    MWh = 1;
    
%   Draw figures
    tidalStationFiguresSingle;
end
