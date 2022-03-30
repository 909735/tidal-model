function [nextHeight] = tidalStationFlow(startHeight,x)
%%  Flow function
%   Determines the lagoon discharge pattern over time

% Read config
tidalStationConfig;

nextHeight = startHeight - disFlow * x*dt;

end
