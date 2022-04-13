%%  Generation Mode - One-Way Ebb
%   The model for a one-way ebb generation station. Generates the indices
%   of the gate opening times.

%   Holds water at high tide for a hold time, then releases it as the sea
%   level is lower.

%% Setup

% Find time indicies of lagoon highs
[highLags,highLagInds] = findpeaks(lagH);

%% Loop to trap water at high tide
% For every maxima (high tide):
for w=[1:length(highLags)]
    lastHLInd = highLagInds(w);   % Current high tide index
    lastHLHeight = highLags(w);   % Current high tide height
    
%   For each point within the hold time after high water
    for x=[1:holdIndOWHW]
        curInd = lastHLInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break
        end
        lagH(curInd) = lastHLHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpenInds(w) = curInd;
    
%   Release the water using the flow function
	script_releaseWater;
end

flag = 0;