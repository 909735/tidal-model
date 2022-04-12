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
    
% Create a seasonal variation wave
tideVariation = (1-hN/hM) * (sin(L*t))+1;
% Scale daily wave by seasonal variation wave
seaH = tideDailyMedian .* tideVariation;
    
%% Pre generating mode setup
% Initially set lagoon height as that of sea
lagH = seaH;             

% Setup arrays containing gate open/close times and indicies
gateOpens = [];
gateCloses = [];

% Number of data points
numData = length(lagH);

% Find time indicies of high/low tide
[HighTides,HighTideInds] = findpeaks(seaH); 
[LowTides,LowTideInds] = findpeaks(-seaH); LowTides=-LowTides;

    
%% Function for rounding hold time indices
function [roundedInd] = iRound(holdTime,dt)
    roundedInd = round((holdTime/dt)-1);
end