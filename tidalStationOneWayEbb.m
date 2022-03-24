%% TidalStationOneWayEbb - The model for a one-way ebb generation station.

% Changes the lagoon height wave to hold water and discharge it as an ebb
% generation pattern.

%% 
% Find time indicies of high tide
[Ht,HtInd] = findpeaks(hSea);

% Setup an array containing gate release times
gateInd = [];

% Loop to trap water at high tide
% For every maxima (high tide):
for i=[1:length(Ht)]
    ind = HtInd(i);
    
%   For each point within the hold time after high water
    for j=[1:holdInd]

%       Check if it's within bounds
        if ind+j>length(hLagoon)
            flag=1;
            break
        end
%       Set to be the same as high tide
        hLagoon(ind+j) = Ht(i);
    end
    
    % Break second loop if out of bounds
    if flag==1
        break
    end
    
    % Add gate release times to an array
    gateInd(i) = ind+j;
end

% Loop to release water at gate times
for k=[1:length(gateInd)]
    
end
    
%   Call figure drawing script if needed. Moved to multi station script.
    tidalStationFigures;