%%  Generation Mode - Two-Way
%   The model for a two-way generation station. Generates the indices
%   of the gate opening times.

%   Holds water at high and low tide for a hold time, then releases it as 
%   the sea level is lower or higher respectively.


%% Setup

% Find time indicies of lagoon highs and lows
[highLags,~] = findpeaks(lagH,'MinPeakProminence',0.5);
nHigh = length(highLags);

lastCloseHgt = 0;
lastCloseInd = 1;

%% Loop to trap water at high/low tide
% For every cycle (taken as high tide) and a couple more just in case:
for w=[1:nHigh]
%% First half - Ebb, holding and gate open time

%   For each point within the hold time after high water
    for x=[0:holdIndTWHW]
        curInd = lastCloseInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last high water
        lagH(curInd) = lastCloseHgt;
    end
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    opInds(w) = curInd;
    opIndsEbb(w) = curInd;

%   Release the water using the flow function
    script_releaseWater;
    clInds(w) = curInd;
    clIndsEbb(w) = lastCloseInd;
    
    
%% Second half - Flow, holding and gate open time
    
%   For each point within the hold time after low water
    for x=[0:holdIndTWLW]
        curInd = lastCloseInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last low water
        lagH(curInd) = lastCloseHgt;
    end    
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    opInds(w) = curInd;
    opIndsFlow(w) = curInd;

%   Release the water using the flow function
	script_releaseWater;
    clInds(w) = curInd;
    clIndsFlow(w) = lastCloseInd;
    
end

flag = 0;


