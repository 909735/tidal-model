%%  Generation Pattern - One-Way Ebb
%   The model for a one-way ebb generation station.

%   Changes the lagoon height wave to hold water and discharge it as an ebb
%   generation pattern.

%% 
% Find time indicies of high tide
[Ht,HtInd] = findpeaks(hSea);

% Setup arrays containing gate release times and indicies
gate = []; gateInd = [];


%% Loop to trap water at high tide
% For every maxima (high tide):
for i=[1:length(Ht)]
    ind = HtInd(i);
    lastHT = Ht(i);
    
%   For each point within the hold time after high water
    for j=[1:holdInd]

%       Check if within bounds
        if ind+j>length(hLagoon), flag=1; break
        end
        
%       Set as high tide
        hLagoon(ind+j) = lastHT;
    end
    
%   Break second loop if out of bounds
    if flag==1, break 
    end
    
%   Add gate release times to an array
    gate(i) = lastHT;
    gateInd(i) = ind+j;
end


%% Loop to release water at gate times
% For every gate release point:
for k=[1:length(gateInd)]
    ind = gateInd(k);
    
%   For each point within one cycle of the release point:
    for X=[1:dayInd]
        
%       Next indices set as time function from gate release height
%       y = c - mx
        nextHeight = hLagoon(ind) - disFlow*X*tStep;     
        
%       Check if within bounds, or next point lower than sea level
        if ind+X>length(hLagoon), break
        elseif nextHeight < hSea(ind+X), break
        end
        
%       Set next point
        hLagoon(ind+X) = nextHeight;
    end
end
    
% Draw figures
tidalStationFigures;