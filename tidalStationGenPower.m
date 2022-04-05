function [MWPerKm2,deltaH] = tidalStationGenPower(lHeight,sHeight,oTimes,cTimes)
%%  Generate Power
%   Function to calculate the power output generated from a given lagoon
%   and sea height.

% Read the config to get turbine/sea water properties
tidalStationConfig;

% Turbine qualities
turbArea = pi*(0.5*turbDiam)^2;

% Head difference
deltaH = lHeight - sHeight;

% Shorthands to simplify following code
lot = length(oTimes); lct = length(cTimes);
if lot ~= lct
    disp("More opens than closes")
end

cycles = lct;
numData = length(lHeight);

% Initialise flow rate per unit area as zeros
VdotPA = zeros(1,numData);

% Local volumetric flow rate per unit area. Vdot = dh/dt * A
% For each gate release
for i=[1:cycles]
    openInd = oTimes(i);
    closeInd = cTimes(i);
    openTime = closeInd-openInd;
    
%   Setup last height and time values
    h1 = lHeight(openInd);
    
%   As long as t is within data bounds
    for t=[1:(numData - openInd)]
        curInd = openInd+t;
        
%       Check if the closing index has been reached
        if t>(openTime), break
        end
        
%       Find h2
        h2 = lHeight(curInd);
        
%       Calculate rate of change of height
        VdotPA(curInd) = (h2-h1)/dt;
        
%       Set h1 for next iteration
        h1 = h2;
    end
end

% Power output per unit area
MWPerKm2 = abs(deltaH.*VdotPA*rhoSeawater*g);
end

