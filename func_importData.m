%% func_getData
% Imports station data based on operating mode.

%%
% Setup
Config;

% Import simple data from a csv file and keep just the numbers
if dataMode=="simple"
    stations = importdata(simpleDataFile);
    stationData = stations.data;
    return

% Import simple data from a csv file and keep just the numbers
elseif dataMode=="actual"
    metaData = importdata(actualDataFile);
    
    
    stationData = stations.data;
    return
    
else
    disp("Invalid data mode")
    return
end


