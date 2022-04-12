%%  tidalStationReleaseWater
%   Script that causes the lagoon height to change based on water flowing
%   in or out.

%% Loop to release water at open points
% For every release point:
for x=[1:numData]
    openInd = gateOpens(x);     % Current gate open index
    lastLagH = lagH(openInd);        % Current gate open lagoon height
    lastSeaH = seaH(openInd);        % Current gate open sea height
    lagHO = lastLagH;
    
%   For each point within one cycle of the release point:
    for x=[1:dayInd]
        
%       Set the indices and last values
        curInd = openInd+x;
        nextLagH = func_flow(lastLagH,lastSeaH);
        
%       if out of bounds
        if curInd>numData, break
        end
            
%       Set next point height
        lagH(curInd) = nextLagH;
        nextSeaH = seaH(curInd);
        
%       Set the calculated sea/lagoon height as previous
        lastLagH = nextLagH; lastSeaH = nextSeaH;
    end
end



