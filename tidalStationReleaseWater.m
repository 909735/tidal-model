%%  tidalStationReleaseWater
%   Script that causes the lagoon height to change based on water flowing
%   in or out.

%% Setup
% Set lower and upper percent bounds
LowBdry = 1-closeThresh; UppBdry  = 1+closeThresh;

%% Loop to release water at open points
% For every release point:
for j=[1:length(gateOpens)]
    openInd = gateOpens(j);     % Current gate open index
    lastLagH = lagH(openInd);        % Current gate open lagoon height
    lastSeaH = seaH(openInd);        % Current gate open sea height
    lagHO = lastLagH;
    
%   For each point within one cycle of the release point:
    for x=[1:dayInd]
        
%       Set the indices and last values
        curInd = openInd+x;
        nextLagH = flow(lastLagH,lastSeaH);
        
%       if out of bounds 
        if curInd>numData
%           Set as a gate closing index and break
            %disp("OOB")
            gateCloses(j) = curInd; break
        end
        
%       Find how close the lagoon is to the sea
        nextSeaH = seaH(curInd);
        closeness = (nextLagH/nextSeaH);
            
%       If lagoon h is close to sea h
        if (closeness>LowBdry && closeness<UppBdry)
%           Set as a gate closing index and break
            %disp("lagH close to seaH")
            gateCloses(j) = curInd; break
            
        else
%           Otherwise, set next point height
            lagH(curInd) = nextLagH;
            nextSeaH = seaH(openInd+x);
        end
        
%       Set the calculated sea/lagoon height as previous
        lastLagH = nextLagH; lastSeaH = nextSeaH;
    end
end


%% Function defining the flow of the water
function [nextLagH] = flow(lastLagH,lastSeaH)
%   Determines the lagoon discharge pattern over time

    tidalStationConfig;

%   Difference in height between sea and lagoon
    deltaH = lastSeaH-lastLagH;
    
%   Find the change in lagoon level height from last time step
    dhL = deltaH*flowTurbine*dt;
    
%   Set next height value
    nextLagH = lastLagH+dhL;
end
