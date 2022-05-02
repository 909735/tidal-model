%% Draw Figures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Sea height vs time, simulated
%   2 - Sea height vs time, actual
%
%   This is to check the simulated sea heights are roughly accurat with
%   the real thing

%% Setup
% Create a dashed line to show mean water
datum = [t0Grph,0;t2Grph,0];

%% Figures

% Fig 1
figOne = figure(98); clf(figOne)
% Subplot 1 - Simulated sea level height, June/July
subplot(1,1,1)
plot(tim,seaHGrph,'r-')
title('Sea height, simulated')
ylabel('h (m)')
xlabel(timLab)
grid on, hold on

%{
% Subplot 2 - Actual sea level height, June/July
subplot(2,1,2)
plot(timAct,seaHActDat,'r-')
title('Sea height, readings Jan-Apr 2020')
ylabel('h (m)')
xlabel(timLab)
grid on, hold on
%}

% Save fig 1
% exportgraphics(figOne,"seaHeight.png",'Resolution',300)