%% func_flow
% Determines the lagoon discharge pattern over time

% INPUTS - Last lagoon height, last sea height
% OUTPUTS - Next lagoon height

function [nextLagH] = func_flow(lastLagH,lastSeaH)

%   Read config
    Config;

%   Difference in height between sea and lagoon
    deltaH = lastSeaH-lastLagH;
    
%   Find the change in lagoon level height from last time step
    dhL = deltaH*flowTurbine*dt;
    
%   Set next height value
    nextLagH = lastLagH+dhL;
end