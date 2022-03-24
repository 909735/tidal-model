%%  Tidal Station Setup
%   Sets up common variables for all tidal station models

%   Sets up:
%   > time series
%   > time end points
%   > sea level series for current station
%   > blank lagoon level series

%%  Time 
    t1 = lunarOrbit*24;             % Time of one spring/neap cycle
    tEnd = 24*noDays;               % End time to display graph until
    tStep = 1/resolution;           % Time step based on resolution
    
%   Time indices - No for gate hold time and half daily cycle
    holdInd = round((holdTime/tStep)-1);
    dayInd = round(0.5*tidalDay/tStep);
    
%   Create time series
    t = [t0:tStep:tEnd];
    
%%  Calculating tidal cycles
    
%   Height travelled by water from centreline, median/spring/neap
    hM = range/2;
    hS = hM+rVar/2;
    hN = hM-rVar/2;
    
%   Coeffs for tide cycle calculations
    Phi = 2*pi*phase/tidalDay;  % Phase diff offset
    T = 4*pi/tidalDay;          % Freq match to daily tides
    L = 4*pi/t1;                % Freq match to seasonal tides
    
%   Daily tidal series, median/spring/neap
    tideDailyM = hM * sin(T*t+Phi);
    tideDailyS = hS * sin(T*t+Phi);
    tideDailyN = hN * sin(T*t+Phi);
    
%   Create a seasonal variation wave
    tideVar = (1-hN/hM) * (sin(L*t))+1;
%   Scale daily wave by seasonal variation wave
    hSea = tideDailyM .* tideVar;
    
%%  Final setup
    hLagoon = hSea;             % Setup lagoon height as that of sea
    flag = 0;                   % Reset break flag, just in case