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
    
%   For each point within the hold time after low water
    for x=[1:holdIndOWLW]
        curInd = lowLagInds(w)+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break     
        end
        lagH(curInd) = lowLags(w);
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    opIndsF(w) = curInd;
    
%   Release the water using the flow function
	script_releaseWater;
    clIndsF(w) = lastCloseInd;
end

flag = 0;