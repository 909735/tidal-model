%%  Tidal Station Setup
%   Sets up common variables for all tidal station models

%   Sets up:
%   > time series
%   > time end points
%   > sea level series for current station
%   > blank lagoon level series

%%  Time 
    
%   Start and end times in hours, rounded to nearest dt.
    t0C=dt*floor(startTimeCalc/dt);t2C=dt*round(24*endDayCalc/dt);
    t0G=dt*floor(startTimeGraph/dt);t2G=dt*round(24*endDayGraph/dt);
    
%   Gate hold time and half daily cycle indices, rounded to nearest dt.
    holdInd = round((holdTime/dt)-1);
    dayInd = round(0.5*tidalDay/dt);
 
% Time of one spring/neap cycle
    t1 = lunarOrbit*24;             
    
%   Create time series
    t = [t0C:dt:t2C];
    
%   Graph start/end time indices
    t0GInd=find(t==t0G); t2GInd = find(t==t2G);
    
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
    hLag = hSea;             % Setup lagoon height as that of sea
    flag = 0;                   % Reset break flag, just in case