function [tGrph,POutGrph,WOutC] = tidalStationModel(stationNo)
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
%   Read config
    Config;
    
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
    mode = stationData(s,5);    % Generation mode - 1 or 2 way generation
    
%   Run common tidal station setup code
    script_setup;


%   Generate lagoon gate opening points for operating pattern
    str = "Station "+string(stationNo)+" using ";  
    switch(mode) 
    case 1
%       Use one way generation model
        disp(str+"one-way ebb")
        genMode_oneWayEbb;
        
    case 2
%       Use one way generation model
        disp(str+"one-way flow")
        genMode_oneWayFlow;
        
    case 3
%       Use two way generation model
        disp(str+"two-way")
        genMode_twoWay;
        
    otherwise
%       Display an error and use one way
        disp(str+"invalid mode")
        genMode_oneWayEbb;
    end
    
%   Calculate power output over time using lagoon/sea height, gate opens/closes
    [powerOut,dH] = func_genPower(lagH,seaH,area,gateOpens,gateCloses);
    
%   Cut time and power out to start from 0
    tCalc = t(t0GrphInd:numData); POutC = powerOut(t0GrphInd:numData);

%   Mega Watt-hours
    WOutC = sum(POutC*dt);

    % Cut data to graph length
    tGrph = t(t0GrphInd:t2GrphInd);
    seaHGrph = seaH(t0GrphInd:t2GrphInd); 
    lagHGrph = lagH(t0GrphInd:t2GrphInd);
    dHGrph = dH(t0GrphInd:t2GrphInd);
    POutGrph = powerOut(t0GrphInd:t2GrphInd);
    
%   Draw figures
    script_drawFiguresSingle;
end
