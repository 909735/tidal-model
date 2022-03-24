function [hSea,tideDailyS,tideVar,t] = tidalStationModel(area,rangeAvg,rangeVar,phase)

%TidalStationModel - 1D model of a single tidal station
%
%   Takes a tidal station's lagoon area, tidal range and tidal phase and 
%   converts it into a predicted power generation output series. 
% 
%   The model uses a simple estimation of the
%   change in potential energy of the water throughout the day, based on
%   the one presented in Sustainable energy - without the hot air (MacKay
%   D, 2008.).

%% Setup
%   Days to show graph for
    noDays = 50;

%   Assumptions used in the model
    holdTime = 4;           % Time in hours to hold water at high tide
    turbineEff = 0.90;      % Turbine efficiency
    tidalDay = 24.83;       % Period between moonrises in hours
    lunarOrbit = 29.53;     % Period between new moons in hours
    rhoWater = 1027;        % Density of seawater
    g = 9.81;               % Gravitational acceleration

%% Time series setup
%   All times are in hours. 0.5 = 30 mins.

%   Resolution of output.
    tStep = 1/60;
%   Start and end times
    t0 = 0;                 % Start time
    t1 = lunarOrbit*24;     % Time of one spring/neap cycle
    tEnd = 24*noDays;       % End time to display graph until

%% Calculations
%   Height travelled by water from centreline
    hA = rangeAvg/2;        % Median tides
    hS = hA+rangeVar/2;     % At spring tides
    hN = hA-rangeVar/2;     % At neap tides
    
%   Offset to add due to phase difference
    Phi = 2*pi*phase/tidalDay;
    
%   Create a time series
    t = [t0:tStep:tEnd];
    
%   Adjust to fit frequency of tides
    T = 4*pi/tidalDay;
%   Adjust to fit frequency of spring/neap cycle
    L = 4*pi/t1;
    
%   Daily tidal series, centred around mean water height.
    tideDailyS = hS * sin(T*t+Phi);
    tideDailyN = hN * sin(T*t+Phi);
    tideDailyA = hA * sin(T*t+Phi);
    tideVar = (1-hN/hA) * (sin(L*t))+1;
    hSea = tideDailyA .* tideVar;
    
    tsOneWayEbb

    
%   Call figure drawing script if needed. Moved to multi station script.
    drawFigures1D();
    
end
