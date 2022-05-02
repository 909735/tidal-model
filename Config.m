%%  Config
%   Central file to change key variables across all code

%% Settings

% Data
dataFolder = "Data/";
dataFileName = "StationData3";  % Path to file to read data from
realDataFileName = "Data2020";  % Path for real world data file
fileExt = ".csv";               % File format being used
realFileExt = ".csv";           % File format being used

% Time settings
startTimeCalc = -30;        % Calculation start time, hours. Ideally < -30
endDayCalc = 4;             % Calculation for MWh end time in days
seaonalStartPhase = 0;      % Start phase in days for seasonal variation

% Assumptions
flowTurbine = 0.7;          % Coefficient of water discharge though turbs
flowSluice = 5.0;           % Coefficient of water discharge though sluices
semiSpringEffect = 0.4;     % Value to scale effect of semi-spring cycle
                            % ...variation.

% Mode holding time settings - Times in hours
owHoldingHW = 6.0;          % One-way ebb high water
owHoldingLW = 4.0;          % One-way flood high water
twHoldingHW = 4.0;          % Two-way high water
twHoldingLW = 4.0;          % Two-way low water

% Graph settings
startTimeGraph = 0;         % Graphing start time, hours. Normally 0
endDayGraph = 02;           % Graphing end time in days
resolution = 4;             % Resolution; Steps per hour
txtSpaceX = 2;              % Text spacing - X
txtSpaceY = 30;             % Text spacing - Y
txtSize = 06;               % Text font size
figPath = "Results/";          % Folder to put graphs in
figPrefix = "sim";          % Prefix (if any) to name graphs by
figHolding = owHoldingHW;   % Which holding time to name graph by
timeUnit = "Days";          % display days or hours 
figCloseOnFin = 1;          % 0 = Keep figures open, 1 = Close figures

% Gate close threshold
closeThresh = 0.1;          % Percent difference where gate is closed

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

% File paths
dataFile = dataFolder+dataFileName+fileExt;
