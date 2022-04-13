%%  script_setup
%   Sets up common variables for all tidal station models

%   Sets up:
%   > time series
%   > time end points
%   > sea level series for current station
%   > blank lagoon level series
%   > Gate open/close time blank data


%%  Time     
% Start and end times in hours, rounded to nearest dt.
t0Calc=dt*floor(startTimeCalc/dt);t2Calc=dt*round(24*endDayCalc/dt);
t0Grph=dt*floor(startTimeGraph/dt);t2Grph=dt*round(24*endDayGraph/dt);

% Gate hold time and half daily cycle indices, rounded to nearest dt.
holdIndOWHW = iRound(owHoldingHW,dt);holdIndOWLW = iRound(owHoldingLW,dt);
holdIndTWHW = iRound(twHoldingHW,dt);holdIndTWLW = iRound(twHoldingLW,dt);
dayInd = round(0.5*tidalDay/dt);

% Time of one spring/neap cycle
t1 = lunarOrbit*24;

% Create time series
t = [t0Calc:dt:t2Calc];

% Graph start/end time indices
t0GrphInd=find(t==t0Grph); t2GrphInd = find(t==t2Grph);

% Number of data entries
numData = length(t);


%%  Calculating tidal cycles
% Height travelled by water from centreline, median/spring/neap
hM = range/2;
hS = hM+rVar/2;
hN = hM-rVar/2;
    
% Coeffs for tide cycle calculations
Phi = 2*pi*phase/tidalDay;  % Phase diff offset
T = 4*pi/tidalDay;          % Freq match to daily tides
L = 4*pi/t1;                % Freq match to seasonal tides
    
% Daily tidal series, median/spring/neap
tideDailyMedian = hM * sin(T*t+Phi);
tideDailySping = hS * sin(T*t+Phi);
tideDailyNeap = hN * sin(T*t+Phi);

% Cut the first wave to ensure a peak first (stuff breaks if a trough is
% first for some reason)
tideDaily = tideDailyMedian;
[~,highSeaInds] = findpeaks(tideDaily);
for p=[1:highSeaInds(1)]
        tideDaily(p)=0;
end
    
% Create a seasonal variation wave
tideVariation = (1-hN/hM) * (sin(L*t))+1;
% Scale daily wave by seasonal variation wave
seaH = tideDaily .* tideVariation;
    

%% 	Setting up lagoon height
% Preallocate lagH, set an initial seaH/lagH value
lagH = seaH;
lastSeaH = seaH(1);
lastLagH = lastSeaH;

% For every data point:
for x=[1:numData]

%   Set the indices and last values
    nextLagH = func_flow(lastLagH,lastSeaH,flowSluice);
       
%   Set next point height
    lagH(x) = nextLagH;
    nextSeaH = seaH(x);
    
%   Set the calculated sea/lagoon height as previous
    lastLagH = nextLagH; lastSeaH = nextSeaH;
end


%%  Pre generation setup
% Setup arrays containing gate open/close times and indicies
opInds = []; opIndsEbb = []; opIndsFlw = [];
clInds = []; clIndsEbb = []; clIndsFlw = [];

% Number of data points
numData = length(lagH);

% Find time indicies of lagoon highs
[highLags,highLagInds] = findpeaks(seaH,'MinPeakProminence',0.5);
% Find time indicies of lagoon lows
[lowLags,lowLagInds] = findpeaks(-seaH,'MinPeakProminence',0.5); 
lowLags=-lowLags;

    
%% Function for rounding hold time indices
function [roundedInd] = iRound(holdTime,dt)
    roundedInd = round((holdTime/dt)-1);
end