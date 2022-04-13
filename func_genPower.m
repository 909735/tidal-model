%%  Generate Power
%   Function to calculate the power output generated from a given lagoon
%   and sea height.

function [MW,dH] = func_genPower(lHeight,sHeight,area,oTimes,cTimes)

% Read the config
Config;

% Head difference
dH = lHeight - sHeight;

% Shorthands to simplify following code
lot = length(oTimes); lct = length(cTimes);
if lot ~= lct
    disp("More opens than closes")
end

cycles = lct;
numData = length(lHeight);

% Initialise flow rate per unit area as zeros
Vdot = zeros(1,numData);

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
        Vdot(curInd) = area*(h2-h1)/dts;
        
%       Set h1 for next iteration
        h1 = h2;
    end
end

% Power output per unit area
powerIdeal = abs(dH.*Vdot*rhoSeawater*g);
powerOut = powerIdeal*turbEff;
MW = powerOut;

end

