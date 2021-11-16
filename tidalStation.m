function [powerOutput] = tidalStation1D(phase,range)
%TidalStation1D - 1D model of a single tidal station
%   Testing git functionality
%
%   Takes a site's tidal range and phase and converts it into a predicted
%   power generation output.
powerOutput = phase + range;
end
