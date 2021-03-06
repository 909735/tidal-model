%%  Config
%   Central file to change key variables across all code

%% Settings

% Data
dataFile = 'StationData.csv';   % Path to file to read data from

% Time and graphing. A different value is used to display the graph to that
% for calculating total energy out. Simulation is run around 30 hours
% before recording data to make sure the lagoon height calculations
% function before recording the cumulative power out.

resolution = 15;        % Resolution; Steps per hour
startTimeCalc = -30;    % Calculation start time, hours
endDayCalc = 2;         % Calculation for MWh end time in days
startTimeGraph = 0;     % Graphing start time, hours
endDayGraph = 2;        % Graphing end time in days

% Assumptions
flowTurbine = 0.5;      % Coefficient of water discharge though turbines

% Mode holding time settings - Times in hours
owHoldingHW = 4.5;      % One-way ebb high water
owHoldingLW = 4.5;      % One-way flow high water
twHoldingHW = 1.0;      % Two-way high water
twHoldingLW = 1.0;      % Two-way low water

% Gate close threshold
closeThresh = 0.02;      % Percent difference where gate is closed

% Turbine settings
turbDiam = 7;           % Diameter
turbEff = 0.60;         % Efficiency
turbPerArea = 1.4;      % Number of turbines per unit area (km^2)

%% Constants

% Constant properties
tidalDay = 24.83;       % Period between moonrises in hours
lunarOrbit = 29.53;     % Period between new moons in hours
rhoSeawater = 1027;     % Density of sea water
g = 9.81;               % Gravitational acceleration

%% Global calculated values
dt = 1/resolution;      % Data time step
dts = dt*3600;          % Time step in seconds