%%  Config
%   Central file to change key variables across all code

%% Settings

% Data
dataFile = 'StationData.csv';   % Path to file to read data from

% Time and graphing
t0 = 0;                 % Start time (hours)
noDays = 01;            % Length of graph in days
resolution = 30;        % Resolution; Steps per hour

% Assumptions
disFlow = 0.70;         % Coefficient of water discharge though turbs
holdTime = 4;           % Time in hours to hold water at high tide
turbineEff = 0.90;      % Turbine efficiency

%% Constants

% Constant properties
tidalDay = 24.83;       % Period between moonrises in hours
lunarOrbit = 29.53;     % Period between new moons in hours
rhoWater = 1027;        % Density of seawater
g = 9.81;               % Gravitational acceleration