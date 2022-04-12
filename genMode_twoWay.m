%%  Generation Mode - Two-Way
%   The model for a two-way generation station. Generates the indices
%   of the gate opening times.

%   Holds water at high and low tide for a hold time, then releases it as 
%   the sea level is lower or higher respectively.


%% Setup - 1st pass, Ebb gen

% Find time indicies of lagoon highs and lows
[highLags,highLagInds] = findpeaks(lagH);
[lowLags,lowLagInds] = findpeaks(-lagH); lowLags=-lowLags;

% Peak or trough first?
HLI1 = highLagInds(1); LLI1 = lowLagInds(1);
First = min(HLI1,LLI1);
if HLI1<LLI1
    disp("Peak first")
else
    disp("Trough first")
end
disp("H1:"+HLI1+" L1:"+LLI1+" Waves:"+First)

% Find whichever is lower
nHigh = length(highLags);
nLow = length(lowLags);
waveCount = min(nHigh,nLow);
disp("H:"+nHigh+" L:"+nLow+" Waves:"+waveCount)


%% Loop to trap water at high/low tide
% For every cycle (taken as high tide) and a couple more just in case:
for w=[1:length(highLags)]
%% First half - Ebb, holding and gate open time

%   Find time indicies of lagoon highs
    [highLags,highLagInds] = findpeaks(lagH);
    
%   Get the previous lagoon high water heights and indices. These change
%   each cycle, but should remain the same index number.
    lastHLInd = highLagInds(w);   % Current high tide index
    lastHLHeight = highLags(w);   % Current high tide height
    
%   For each point within the hold time after high water
    for x=[1:holdIndTWHW]
        curInd = lastHLInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last high water
        lagH(curInd) = lastHLHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(w) = curInd;

%   Release the water using the flow function
    script_releaseWater;
    
    
    
%% Second half - Flow, holding and gate open time

%   Find time indicies of lagoon lows 
    [lowLags,lowLagInds] = findpeaks(-lagH); lowLags=-lowLags;
    
%   Get the previous lagoon low water heights and indices. These change
%   each cycle, but should remain the same index number.
    lastLLInd = lowLagInds(w);   % Current low tide index
    lastLLHeight = lowLags(w);   % Current low tide height
        
%   For each point within the hold time after low water
    for x=[1:holdIndTWLW]
        curInd = lastLLInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last low water
        lagH(curInd) = lastLLHeight;
    end    
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(w) = curInd;

%   Release the water using the flow function
	script_releaseWater;
    
    
    
end

flag = 0;


