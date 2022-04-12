%% Draw Figures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Sea height and lagoon height vs time

%% Setup
% Create a dashed line to show mean water
datum = [t0Grph,0;t2Grph,0];
figNo = stationNo+1;

%% Figures

% Fig 1
figure(figNo), clf(figNo)

% Subplot 1 - Sea level for site over time
subplot(4,1,1)
plot(tGrph,seaHGrph,'r')
title('Sea height')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on

% Subplot 2 - Lagoon level for site with dashed sea level
subplot(4,1,2)
plot(tGrph,seaHGrph,'k-.')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
plot(tGrph,lagHGrph,'b')
legend('Sea height','Lagoon height')

% Subplot 3 - Height from average
subplot(4,1,3)
plot(tGrph,abs(dHGrph),'k')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
title('Lagoon-sea height difference')

% Subplot 4 - Power output ideal vs actual
subplot(4,1,4)
plot(tGrph,POutGrph,'r')
title('Power output')
ylabel('power out (MW)')
xlabel('time (hrs)')
grid on
hold on
dispMWh = round(WOutC/1000);
legend('GWh:'+string(dispMWh)+(' over ')+string(endDayCalc)+' days')
%legend('Ideal power','Actual power')
