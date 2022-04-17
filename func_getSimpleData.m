%% func_getSimpleData
% Imports simple station data

function [area,seaH,t,mode] = func_getSimpleData(stationNo)
%%  Setup
    Config;
    
%%  Import/handle data
    stations = importdata(simpleDataFile);
    stationData = stations.data;

    s = stationNo;
%   Set the parameters to that of the data entry
    area = stationData(s,4);    % Area (km^2)
    range = stationData(s,1);   % Median range (m)
    rVar = stationData(s,2);    % Spring/neap range Variation (m)
    phase = stationData(s,3);   % Phase (hours)
    mode = stationData(s,5);    % Generation mode - 1 or 2 way generation
    
    
%%  Time series
%   Start and end times in hours, rounded to nearest dt.
    t0Calc=dt*floor(startTimeCalc/dt);t2Calc=dt*round(24*endDayCalc/dt);
    t0Grph=dt*floor(startTimeGraph/dt);t2Grph=dt*round(24*endDayGraph/dt);

%   Create time series
    t = [t0Calc:dt:t2Calc];
    

%%  Sea height series
%   Height travelled by water from centreline, median/neap
    hM = range/2;
    hN = hM-rVar/2;

%   Time of one spring/neap cycle
    t1 = lunarOrbit*24;
    
%   Coeffs for tide cycle calculations
    Phi = 2*pi*phase/tidalDay;  % Phase diff offset
    T = 4*pi/tidalDay;          % Freq match to daily tides
    L = 4*pi/t1;                % Freq match to seasonal tides
    
%   Daily tidal series, mean
    tideDailyMean = hM * sin(T*t+Phi);

%   Cut the first wave to ensure a peak first (stuff breaks if a trough is
%   first for some reason)
    tideDaily = tideDailyMean;
    [~,highSeaInds] = findpeaks(tideDaily);
    for p=[1:highSeaInds(1)]
        tideDaily(p)=0;
    end
    
%   Create a seasonal variation wave
    tideVariation = (1-hN/hM) * (sin(L*t))+1;
%   Scale daily wave by seasonal variation wave
    seaH = tideDaily .* tideVariation;
    
end

