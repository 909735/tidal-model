%% TidalStationSetup - Sets up 1D model of all tidal stations

%%  Time 
    t1 = lunarOrbit*24;             % Time of one spring/neap cycle
    tEnd = 24*noDays;               % End time to display graph until
    tStep = 1/resolution;           % Time step based on resolution
    holdInd = (holdTime/tStep)-1;   % No of indices for hold time
    
%   Create time series
    t = [t0:tStep:tEnd];
    
%%  Calculating tidal cycles
    
%   Height travelled by water from centreline
    hM = range/2;               % Median tides
    hS = hM+rVar/2;             % At spring tides
    hN = hM-rVar/2;             % At neap tides
    
%   Coeffs for tide cycle calculations
    Phi = 2*pi*phase/tidalDay;  % Phase diff offset
    T = 4*pi/tidalDay;          % Freq match to daily tides
    L = 4*pi/t1;                % Freq match to spring/neap tides
    
%   Daily tidal series, centred around mean water height.
    tideDailyS = hS * sin(T*t+Phi);         % Daily spring tide cycle
    tideDailyN = hN * sin(T*t+Phi);         % Daily neap tide cycle
    tideDailyM = hM * sin(T*t+Phi);         % Daily mean tide cycle
    
%   Create the monthy spring/neap cycle
    tideVar = (1-hN/hM) * (sin(L*t))+1;     % Spring/Neap variation wave
    hSea = tideDailyM .* tideVar;           % Scale tide by variation wave
    
%%  Final setup
    hLagoon = hSea;             % Setup lagoon height as that of sea