%%  func_genPower
% Function to calculate the power output generated from a given lagoon
% and sea height.

function [MW,dH] = func_genPower(lagH,seaH,area,openTimes,closeTimes)

% Read the config
Config;

% Head difference
dH = lagH-seaH;
absDH = abs(dH);

% Shorthands to simplify following code
numOp = length(openTimes); numCl = length(closeTimes);
if numOp ~= numCl
    disp("More opens than closes")
end

cycles = numCl;
numData = length(lagH);

% Initialise flow rate per unit area as zeros
Vdot = zeros(1,numData);

% Local volumetric flow rate per unit area. Vdot = dh/dt * A
% For each gate release

for c=[1:cycles]
    openInd = openTimes(c);
    closeInd = closeTimes(c);
    openTime = closeInd-openInd;
    
%   Setup last height and time values
    h1 = lagH(openInd);
    
%   As long as t is within data bounds
    for x=[1:(numData-openInd)]
        curInd = openInd+x;
        
%       Check if the closing index has been reached
        if x>(openTime), break
        end
        
%       Find h2
        h2 = lagH(curInd);
        
%       Calculate rate of change of height
        Vdot(curInd) = area*(h2-h1)/(dt*3600);
        
%       Set h1 for next iteration
        h1 = h2;
    end
end

% Power output per unit area
MWideal = abs(absDH.*Vdot*rhoSeawater*g); 
MW = MWideal*turbEff;

end

