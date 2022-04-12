%% func_flow
% Determines the lagoon discharge pattern over time

% INPUTS - Last lagoon height, last sea height, flow coefficient to use
% OUTPUTS - Next lagoon height

function [nextLagH] = func_flow(lastLagH,lastSeaH,flow)

%   Read config
    Config;

%   Difference in height between sea and lagoon
    deltaH = lastSeaH-lastLagH;
    
%   Find the change in lagoon level height from last time step
    dhL = deltaH*flow*dt;
    
%   Set next height value
    nextLagH = lastLagH+dhL;
end