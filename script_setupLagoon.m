%%  script_setupLagoon
%   Sets up lagoon height and gate release points for both data modes

%   Sets up:
%   > blank lagoon level series
%   > Gate open/close time blank data

%% 	Setting up lagoon height

% Number of data entries
numData = length(t);

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

% Find time indicies of lagoon highs
[highLags,highLagInds] = findpeaks(seaH,'MinPeakProminence',0.5);
% Find time indicies of lagoon lows
[lowLags,lowLagInds] = findpeaks(-seaH,'MinPeakProminence',0.5); 
lowLags=-lowLags;

% Gate hold time and half daily cycle indices, rounded to nearest dt.
holdIndOWHW = iRound(owHoldingHW,dt);holdIndOWLW = iRound(owHoldingLW,dt);
holdIndTWHW = iRound(twHoldingHW,dt);holdIndTWLW = iRound(twHoldingLW,dt);
dayInd = round(0.5*tidalDay/dt);

    
%% Function for rounding hold time indices
function [roundedInd] = iRound(holdTime,dt)
    roundedInd = round((holdTime/dt)-1);
end