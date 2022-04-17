%% script_importData
% Imports station data based on operating mode.

%%
% Setup
Config;

% Import simple data from a csv file and keep just the numbers
if dataMode=="Simple"
    stations = importdata(simpleDataFile);
    stationData = stations.data;
    return

% Import simple data from a csv file and keep just the numbers
elseif dataMode=="Actual"
    metaData = importdata(actualDataFile);
    
    
    stationData = stations.data;
    return
    
else
    disp("Invalid data mode")
    return
end


