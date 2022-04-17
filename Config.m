%%  Config
%   Central file to change key variables across all code

%% Settings

% Data
dataFile = 'StationData.csv';   % Path to file to read data from

% Time settings
startTimeCalc = -30;        % Calculation start time, hours. Ideally < -30
endDayCalc = 60;            % Calculation for MWh end time in days

% Assumptions
flowTurbine = 0.7;          % Coefficient of water discharge though turbs
flowSluice = 5.0;           % Coefficient of water discharge though sluices

% Mode holding time settings - Times in hours
owHoldingHW = 6.0;          % One-way ebb high water
owHoldingLW = 4.0;          % One-way flow high water
twHoldingHW = 4.0;          % Two-way high water
twHoldingLW = 4.0;          % Two-way low water

% Graph settings
startTimeGraph = 0;         % Graphing start time, hours. Normally 0
endDayGraph = 2;            % Graphing end time in days
resolution = 15;            % Resolution; Steps per hour
txtSpaceX = 2;              % Text spacing - X
txtSpaceY = 30;             % Text spacing - Y
txtSize = 06;               % Text font size
figPath = "Figs/";          % Folder to put graphs in
figPrefix = "OWE ";         % Prefix (if any) to name graphs by
figHolding = owHoldingHW;   % Which holding time to name graph by

% Gate close threshold
closeThresh = 0.1;         % Percent difference where gate is closed

% Turbine settings
turbEff = 0.70;             % Efficiency

%% Constants

% Constant properties
tidalDay = 24.83;           % Period between moonrises in hours
lunarOrbit = 29.53;         % Period between new moons in hours
rhoSeawater = 1027;         % Density of sea water
g = 9.81;                   % Gravitational acceleration

%% Global calculated values
dt = 1/resolution;          % Data time step
LowBdry = 1-closeThresh;    % Lower boundary for sea/lag h threshold
UppBdry  = 1+closeThresh;   % Upper boundary for sea/lag h threshold