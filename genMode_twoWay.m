%%  Generation Mode - One-Way Ebb
%   The model for a one-way ebb generation station. Generates the indices
%   of the gate opening times.

%   Holds water at high tide for a hold time, then releases it as the sea
%   level is lower.

%% Loop to trap water at high tide
% For every maxima (high tide):
for i=[1:length(HighTides)]
    lastHTInd = HighTideInds(i);   % Current high tide index
    lastHTHeight = HighTides(i);   % Current high tide height
    
%   For each point within the hold time after high water
    for x=[1:holdIndTWHW]
        curInd = lastHTInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
        lagH(curInd) = lastHTHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(i) = curInd;
end  

flag = 0;
