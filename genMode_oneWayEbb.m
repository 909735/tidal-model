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
    
%   For each point within the hold time after high water
    for x=[1:holdIndOWHW]
        curInd = highLagInds(w)+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break
        end
        lagH(curInd) = highLags(w);
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    opInds(w) = curInd;
    
%   Release the water using the flow function
	script_releaseWater;
    clInds(w) = lastCloseInd;
end

flag = 0;