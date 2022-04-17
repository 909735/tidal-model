%% func_getActualData
% Imports actual station data

function [outputArg1,outputArg2] = func_getData(stationNo)
%%
% Setup
Config;

% Import simple data from a csv file and keep just the numbers
if dataType==1
    stations = importdata(simpleDataFile);
    stationData = stations.data;
    return

% Import simple data from a csv file and keep just the numbers
elseif dataType==2
    metaData = importdata(actualDataFile);
    
    
    stationData = stations.data;
    return
    
else
    disp("Invalid data mode")
    return
end

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end





