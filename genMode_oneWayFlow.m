%%  Generation Mode - One-Way Flow
%   The model for a one-way flow generation station. Generates the indices
%   of the gate opening times.

%   Holds lagoon water at low tide for a hold time, then allows sea water
%   in through a turbine when it is higher than the lagoon.

%% Loop to trap water at low tide
% For every minima (low tide):
for i=[1:length(LowTides)]
    lastLTInd = LowTideInds(i);   % Current low tide index
    lastLTHeight = LowTides(i);   % Current low tide height
    
%   For each point within the hold time after high water
    for x=[1:holdIndOWLW]
        curInd = lastLTInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
        lagH(curInd) = lastLTHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(i) = curInd;
end  

flag = 0;