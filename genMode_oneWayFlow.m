%%  Generation Mode - One-Way Flow
%   The model for a one-way flow generation station. Generates the indices
%   of the gate opening times, then creates a smooth discharge curve.

%   Holds water at low tide for a hold time, then releases it as the sea
%   level is higher.

%% Setup

% Find time indicies of lagoon lows
[lowLags,lowLagInds] = findpeaks(-lagH); lowLags=-lowLags;

%% Loop to trap water at low tide
% For every minima (low tide):
for w=[1:length(lowLags)]
    lastLLInd = lowLagInds(w);    % Current high tide index
    lastLLHeight = lowLags(w);    % Current high tide height
    
%   For each point within the hold time after low water
    for x=[1:holdIndOWLW]
        curInd = lastLLInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break     
        end
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