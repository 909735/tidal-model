function [tideHeight,tidePowerOut,time] = tidalStationOneWay(area,rangeSpring,rangeNeap,phase)

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
    noDays = 50;

%   Assumptions used in the model
    turbineEff = 0.90;      % Turbine efficiency
    tidalDay = 24.83;       % Period between moonrises in hours
    lunarOrbit = 29.53;     % Period between new moons in days
    rhoWater = 1000;        % Density of seawater
%   rhoWater = 1027;
    g = 9.81;               % Gravitational acceleration

%% Time series setup
%   All times are in hours. 0.5 = 30 mins.

%   Resolution of output.
    tStep = 1/60;
%   Start and end times
    t0 = 0;                 % Start time
    t1 = lunarOrbit*24;     % End time after one spring/neap cycle
    t2 = noDays*24;         % End time after time to show graph for

%% Calculations
%   Height travelled by water from centreline
    hs = avgRange/2;        % Height at spring tide
    hn = avgRange
    
%   Offset to add due to phase difference
    phi = 2*pi*phase/tidalDay;
%   Mass of water moving
    waterMass = rhoWater*hs*area;
    waterEnergy = waterMass*g*hs;
    
%   Create a time series
    time = [t0:tStep:t2]';
    
%   Adjust to fit frequency of tides
    t = 4*pi/tidalDay;
    
%   Daily tidal series, centred around mean water height.
    tideHeight = hs*sin(t*time+phi);
    
    
%   Series of the difference in potential energy from baseline
    tideEnergy = waterEnergy*sin(t*time+phi)+waterEnergy;
    
%   Series of the max power output, dy/dt(tideEnergy)
    tidePowerMax = abs(1/3600*t*waterEnergy.*cos(t*time+phi));
    tidePowerOut = tidePowerMax*turbineEff;
    %tidePowerAvg = mean(tidePowerAct);
    
%   Call figure drawing script if needed. Moved to multi station script.
    drawFigures1D();
    
end
