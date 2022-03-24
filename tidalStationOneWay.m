function [tideMonth,tideDailyS,tideVar,time] = tidalStationOneWay(area,rangeAvg,rangeVar,phase)

%TidalStation1D - 1D model of a single tidal station
%
%   Takes a tidal station's lagoon area, tidal range and tidal phase and 
%   converts it into a predicted power generation output series. 
%
%   If mode = 1, follows an ebb generation pattern
%   If mode = 2, follows a two-way generation pattern
% 
%   The model uses a simple estimation of the
%   change in potential energy of the water throughout the day, based on
%   the one presented in Sustainable energy - without the hot air (MacKay
%   D, 2008.).

%% Setup
%   Days to show graph for
%     noDays = 50;

%   Assumptions used in the model
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
    t2 = lunarOrbit*24;     % End time after one spring/neap cycle
    t1 = t2/2;
%     t2 = noDays*24;         % End time after time to show graph for

%% Calculations
%   Height travelled by water from centreline
    hA = rangeAvg/2;        % Median tides
    hS = hA+rangeVar/2;       % At spring tides
    hN = hA-rangeVar/2;       % At neap tides

    hR = hN/hS;             % Ratio between neap and spring tides

    varAmp = 1-hN/hA;
    
%   Offset to add due to phase difference
    Phi = 2*pi*phase/tidalDay;

    %{
%   Mass of water moving
    waterMass = rhoWater*hs*area;
    waterEnergy = waterMass*g*hs;
    %}
    
%   Create a time series
    time = [t0:tStep:t1];
    
%   Adjust to fit frequency of tides
    T = 4*pi/tidalDay;
%   Adjust to fit frequency of spring/neap cycle
    L = 2*pi/t1;
    
%   Daily tidal series, centred around mean water height.
    tideDailyS = hS * sin(T*time+Phi);
    tideDailyN = hN * sin(T*time+Phi);
    tideDailyA = hA * sin(T*time+Phi);
    tideVar = varAmp*(sin(L*time))+1;
    tideMonth = tideDailyA.*tideVar;
    
%{    
%   Series of the difference in potential energy from baseline
    tideEnergy = waterEnergy*sin(T*time+Phi)+waterEnergy;
    
%   Series of the max power output, dy/dt(tideEnergy)
    tidePowerMax = abs(1/3600*T*waterEnergy.*cos(T*time+Phi));
    tidePowerOut = tidePowerMax*turbineEff;
    %tidePowerAvg = mean(tidePowerAct);
%}
    
%   Call figure drawing script if needed. Moved to multi station script.
    drawFigures1D();
    
end
