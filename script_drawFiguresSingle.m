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

% Subplot 1 - Lagoon level for site with dashed sea level
subplot(3,1,1)
plot(tGrph,seaHGrph,'r-')
title("Sea/Lagoon height over "+endDayGraph+ "days")
ylabel('h (m)')
xlabel('t (hrs)')
grid on, hold on
plot(tGrph,lagHGrph,'b','LineWidth',1.5)
%scatter(t(lowLagInds(4)),lowLags(4),'*m')
%scatter(t(lowLagInds(5)),lowLags(5),'*m')
legend('Sea height','Lagoon height')

% Subplot 2 - Height difference
subplot(3,1,2)
%plot(datum(:,1),datum(:,2),'k-.','LineWidth',1)
grid on, hold on
plot(tGrph,dHGrph,'k','LineWidth',1.5)
ylabel('dh (m)')
xlabel('t (hrs)')
title('Lagoon-sea height difference')


% Subplot 3 - Power output actual
subplot(3,1,3)
plot(tGrph,POutGrph,'r','LineWidth',1.5)
title("Power output")
ylabel('P (MW)')
xlabel('t (hrs)')
grid on, hold on
dispMWh = round(WOutC/1000);
legend(dispMWh+(" GWh over ")+endDayCalc+" days")
