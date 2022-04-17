function [tGrph,POutGrph,WOutC] = func_stationModel(stationNo)
%% TidalStationModel - 1D model of a single tidal station

%   Looks up data for a given tidal station number, and 
%   converts it into a predicted power generation output series.

%   Outputs:
%   t - time series
%   powerOut - power output series
%   WOutC - Cumulative energy out over calculation period

%   Inputs:
%   stationNo - Data entry number for given station, read from data files.

%   This model is run inside a function to keep all values local for each
%   station.

%   Most calculations are done in sub script and function files. These are:
%     Config - Sets up properties used by many scripts
%     script_seaHeightSimple - Gets data/generates simplified seaH series
%     script_seaHeightActual - Gets data from actual seaH series
%     script_setupLagoon - Pre setup for the lagoon height and gate opens
%     genMode_OneWayEbb - Uses one way ebb generation model
%     genMode_OneWayFlow - Uses one way flow generation model
%     genMode_TwoWay - Uses two way generation model
%     script_releaseWater - Creates gradual water release pattern from dh
%     script_drawFiguresSingle - Generates graphs of one station

%   The model uses a simple estimation of the
%   change in potential energy of the water throughout the day, based on
%   the one presented in Sustainable energy - without the hot air (MacKay
%   D, 2008.).

%%
% Setup
Config;

%% Import data   
% Choose which data to read based on the data mode

% Import simple data from a csv file and keep just the numbers
if dataMode=="simple"
    disp("Simple data mode")
    [seaH,t,area,mode] = func_seaHeightSimple(stationNo);
    disp(length(seaH))
    disp(length(t))

% Import simple data from a csv file and keep just the numbers
elseif dataMode=="actual"
    disp("Actual data mode")
    [seaH,t,area,mode] = func_getActualData(stationNo);
    
else
    disp("Invalid data mode")
    return
end

%% Lagoon height
    
% Run common tidal station setup code
script_setupLagoon;

% Generate lagoon gate opening points for operating pattern
str = "Station "+string(stationNo)+" using ";  
switch(mode) 
case 1
% Use one way generation model
    disp(str+"one-way ebb")
    genMode_oneWayEbb;
%   Calculate power output
    [powerOut,dH] = func_genPower(lagH,seaH,area,opInds,clInds);

case 2
%   Use one way generation model
    disp(str+"one-way flow")
    genMode_oneWayFlow;
%   Calculate power output
    [powerOut,dH] = func_genPower(lagH,seaH,area,opInds,clInds);

case 3
%   Use two way generation model
    disp(str+"two-way")
    genMode_twoWay;
%   Calculate power output
    [powerOut,dH] = func_genPower(lagH,seaH,area,opInds,clInds);

otherwise
%   Display an error and use one way
    disp(str+"invalid mode")
    genMode_oneWayEbb;
end

%% Data manipulation

% Start and end times in hours, rounded to nearest dt.
t0Calc=dt*floor(startTimeCalc/dt); t2Calc=dt*round(24*endDayCalc/dt);

% Find graph start and end indices
t0Grph=dt*floor(startTimeGraph/dt);t2Grph=dt*round(24*endDayGraph/dt);
t0GrphInd=find(t==t0Grph); t2GrphInd = find(t==t2Grph);

% Cut time and power out to start from 0

tCalc = t(t0GrphInd:numData); POutC = powerOut(t0GrphInd:numData);

% Mega Watt-hours
WOutC = sum(POutC*dt);

% Cut data to graph length
tGrph = t(t0GrphInd:t2GrphInd);
seaHGrph = seaH(t0GrphInd:t2GrphInd); 
lagHGrph = lagH(t0GrphInd:t2GrphInd);
dHGrph = dH(t0GrphInd:t2GrphInd);
POutGrph = powerOut(t0GrphInd:t2GrphInd);
    
% Draw figures
script_drawFiguresSingle;




end
