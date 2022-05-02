function [tGrph,powerGrph,WOutC] = func_stationModel(stationNo)
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
%   Column 3 - Avg Spring/Neap total range deviation from median (m)
%   Column 4 - Total Semi-variation of spring tides (m)
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
%     tidalStationFlow - Function modelling water flow rate
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
    disp("Reading "+dataFile);
    stations = importdata(dataFile);
    stationData = stations.data;
    
%   Get the data entry
    sNo = stationNo;
    
%   Set the parameters to that of the data entry
    range = stationData(sNo,1);   % Mean range (m)
    rVar = stationData(sNo,2);    % Spring-mean range variation (m)
    sVar = stationData(sNo,3);    % Spring semi cycle variation (m)
    phase = stationData(sNo,4);   % Phase (hours)
    area = stationData(sNo,5);    % Area (km^2)
    mode = stationData(sNo,6);    % Generation mode - 1 or 2 way generation
    disp("Station data- No:"+sNo+" range:"+range+" rVar:"+rVar+" sVar:"...
        +sVar+" phi:"+phase+" area:"+area+" mode:"+mode)
    
    %{
%   Read actual data
%   File path
    realDataFile = dataFolder+realDataFileName+'_'+string(sNo)+realFileExt;
    
%   Import the data
    %disp("Reading "+realDataFile);
    actDat = importdata(realDataFile);
    actDat = actDat.data;
%   Split the data
    tActDat = actDat(:,1);
    seaHActDat = actDat(:,2);
    %}
    
%   Run common tidal station setup code
    script_setup;

%   Generate lagoon gate opening points for operating pattern
    str = "Station "+string(stationNo)+" using ";  
    switch(mode) 
    case 1
%       Use one way generation model - discharge at high tide
        disp(str+"one-way ebb")
        genMode_oneWayEbb;
        
    case 2
%       Use one way generation model - flood at low tide
        disp(str+"one-way flood")
        genMode_oneWayFlood;
        
    case 3
%       Use two way generation model
        disp(str+"two-way")
        genMode_twoWay;
        
    otherwise
%       Display an error and use one way
        disp(str+"invalid mode")
        return
    end
    
%   Calculate power output
    [powerOutA,dH] = func_genPower(lagH,seaH,area,opIndsE,clIndsE);
    [powerOutB,~] = func_genPower(lagH,seaH,area,opIndsF,clIndsF);
    power = powerOutA+powerOutB;
    
%   Cut time and power out to start from 0
    tCalc = t(t0GrphInd:numData); POutC = power(t0GrphInd:numData);

%   Mega Watt-hours
    WOutC = sum(POutC*dt);

%   Cut data to graph length
    tGrph = t(t0GrphInd:t2GrphInd);
    seaHGrph = seaH(t0GrphInd:t2GrphInd); 
    lagHGrph = lagH(t0GrphInd:t2GrphInd);
    dHGrph = dH(t0GrphInd:t2GrphInd);
    powerGrph = power(t0GrphInd:t2GrphInd);
    
    %{
    actEndInd = find(tActDat==t2Grph);
    tActDat = tActDat(1:actEndInd);
    seaHActDat = seaHActDat(1:actEndInd);
    tDayActDat = tActDat/24;
    %}
    
%   Day version of time    
    tDayGrph = tGrph/24;
    
%   Change time unit depending on setting
    switch(lower(timeUnit))
    case 'days'
        tim = tDayGrph; %timAct = tDayActDat;
        t0Grph = t0Grph/24; t2Grph = t2Grph/24;
        timLab = "t (days)";
    case 'hours'
        tim = tGrph; %timAct = tActDat;
        timLab = "t (hrs)";
    otherwise
            disp('Invalid time unit - use Days or Hours')
    end
    
%   Draw figures
    script_drawFiguresSingle;
    %script_drawFiguresSeaHeight;

end
