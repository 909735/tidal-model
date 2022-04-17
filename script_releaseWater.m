%%  script_releaseWater
%   Script that causes the lagoon height to change based on water flowing
%   in or out.

%% Setup
% Current gate open index, depending which array is being used
if isempty(opIndsF)
    lastOpenInd = opIndsE(w);
elseif isempty(opIndsE)
    lastOpenInd = opIndsF(w);
else
    lastOpenInd = max([opIndsE(end),opIndsF(end)]); 
end

lastLagH = lagH(lastOpenInd);       % Current gate open lagoon height
lastSeaH = seaH(lastOpenInd);       % Current gate open sea height

LowBdry = 1-closeThresh;    % Lower boundary for sea/lag h threshold
UppBdry  = 1+closeThresh;   % Upper boundary for sea/lag h threshold
    
%% For each point within a day cycle of the current point:
for x=[1:dayInd]
    
%   Set the indices and last values
    curInd = lastOpenInd+x;
    nextLagH = func_flow(lastLagH,lastSeaH,flowTurbine);
    
%   if out of bounds 
    if curInd>numData
%       Set as a gate closing index and break
        lastCloseHgt = lastLagH;
        lastCloseInd = curInd; break
    end
    
%   Find how close the new lagoon h is to the (SEA or OLD LAG?) h curve
    nextSeaH = seaH(curInd);
    oldLagH = lagH(curInd);
    closeness = (nextLagH/oldLagH);
      
%   If lagoon h is close to sea h
    if (closeness>LowBdry && closeness<UppBdry)
%       Set as a gate closing index and break
        lastCloseInd = curInd;
        lastCloseHgt = nextLagH;
        lagH(curInd) = nextLagH;
        break
    end
    
    lagH(curInd) = nextLagH;
    
%   Set the calculated sea/lagoon height as previous
    lastLagH = nextLagH; lastSeaH = nextSeaH;
end

