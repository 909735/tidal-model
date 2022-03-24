%TidalStationOneWayEbb - The model for a one-way ebb generation station.

% Find time indicies of high tide
[Ht,HtInd] = findpeaks(hSea);

% Initially set the lagoon height as that of the sea
hLagoon = hSea;

for i=[1:length(Ht)]
    
end