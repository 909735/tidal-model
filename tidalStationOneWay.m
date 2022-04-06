%%  Generation Pattern - One-Way Ebb
%   The model for a one-way ebb generation station.

%   Changes the lagoon height wave to hold water and discharge it as an ebb
%   generation pattern.

%% 
% Find time indicies of high tide
[Ht,HtInd] = findpeaks(hSea);

% Setup arrays containing gate open/close times and indicies
gateOpens = [];
gateCloses = [];

numData = length(hLag);

%% Loop to trap water at high tide
% For every maxima (high tide):
for i=[1:length(Ht)]
    HTInd = HtInd(i);   % Current high tide index
    HTHeight = Ht(i);   % Current high tide height
    
%   For each point within the hold time after high water
    for x=[1:holdInd]
        curInd = HTInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
        hLag(curInd) = HTHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(i) = HTInd+x;
end  

%% Loop to release water at open points
% For every release point:
for j=[1:length(gateOpens)]
    openInd = gateOpens(j);     % Current gate open index
    openHeight = Ht(j);         % Current gate open height
    
%   For each point within one cycle of the release point:
    for x=[1:dayInd]
        curInd = openInd+x;
        nextHeight = tidalStationFlow(openHeight,x);
        
%       Check index is within data bounds and lagoon is higher than sea
        if curInd>numData || nextHeight<=hSea(curInd)
%           Set as a gate closing index
            gateCloses(j) = curInd; break
        else
%           Otherwise, set next point height
            hLag(curInd) = nextHeight;
        end
    end
end
