function [tideHeight,tidePowerOut,time] = tidalStation1D(area,avgRange,phase)

%TidalStation1D - 1D model of a single tidal station
%
%   Takes a tidal station's lagoon area, tidal range and tidal phase and 
%   converts it into a predicted power generation output series. 
%
%   The model uses a simple estimation of the
%   change in potential energy of the water throughout the day, based on
%   the one presented in Sustainable energy - without the hot air (MacKay
%   D, 2008.).

%% Setup
%   Assumptions used in the model
    turbineEff = 0.90;
    tidalDay = 24;          % Simplified 24 hour model
%   tidalDay = 24.83;       % Actual period between moonrises
    rhoWater = 1000;
%   rhoWater = 1027;
    g = 9.81;

%% Script version setup
%area = 1;           %m^2
%avgRange = 4;       %m
%phase = 0;          %time offset in hours

%% Time series setup
%   All times are in hours. 0.5 = 30 mins.

%   Resolution of output.
    tStep = 1/60;
%   Start and end times
    t0 = 0;
    t1 = 1*tidalDay;

%% Calculations
%   Height travelled by water centre of mass
    h = avgRange/2;
%   Offset to add due to phase difference
    phi = 2*pi*phase/tidalDay;
%   Mass of water moving
    waterMass = rhoWater*h*area;
    waterEnergy = waterMass*g*h;
    
%   Create a time series
    time = [t0:tStep:t1]';
    
%   Adjust to fit frequency of tides
    t = 4*pi/tidalDay;
    
%   Tidal series, centred around mean water height.
    tideHeight = h*sin(t*time+phi);
%   Series of the difference in potential energy from baseline
    tideEnergy = waterEnergy*sin(t*time+phi)+waterEnergy;
    
%   Series of the max power output, dy/dt(tideEnergy)
    tidePowerMax = abs(1/3600*t*waterEnergy.*cos(t*time+phi));
    tidePowerOut = tidePowerMax*turbineEff;
    %tidePowerAvg = mean(tidePowerAct);
    
%   Call figure drawing script if needed. Moved to multi station script.
    %drawFigures1D();
    
end
