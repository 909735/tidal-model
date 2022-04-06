%% Draw Figures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Sea height and lagoon height vs time

%% Setup
% Create a dashed line to show mean water
datum = [t0G,0;t2G,0];
figNo = stationNo+1;

% Cut data to graph length
tG = t(t0GInd:t2GInd);
hSeaG = hSea(t0GInd:t2GInd);
hLagG = hLag(t0GInd:t2GInd);


%% Figures

% Fig 1
figure(figNo), clf(figNo)
% Subplot 1 - Sea level for site over time
subplot(4,1,1)
plot(t,hSea,'r')
title('Sea height over one spring/neap cycle')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on

%{
% Additional dev plotting
plot(tG,hSeaG,'b')
graphT = [t(t0GInd),t(t2GInd)];
graphH = [hSea(t0GInd),hSea(t2GInd)];
scatter(graphT,graphH,'*m')
plot(datum(:,1),datum(:,2),'k-.')
%}

% Subplot 2 - Lagoon level for site with dashed sea level
subplot(4,1,2)
plot(t,hSea,'k-.')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
plot(t,hLag,'b')
legend('Sea height','Lagoon height')

%{
% Additional dev plotting
plot(tG,hLagG,'r')
graphT = [t(t0GInd),t(t2GInd)];
graphH = [hLag(t0GInd),hLag(t2GInd)];
scatter(graphT,graphH,'*m')
plot(datum(:,1),datum(:,2),'k-.')
%}

%{
% Fig 2
figure(2), clf(2)

% Subplot 2 - Lagoon level for site with dashed sea level
subplot(3,1,1)
plot(t,hSea,'k-.')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
plot(t,hLag,'b')
legend('Sea height','Lagoon height')
% plot(datum(:,1),datum(:,2),'k-.')

%}
% Subplot 3 - Height from average
subplot(4,1,3)
plot(t,deltaH,'k')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
title('Lagoon/sea height difference')

% Subplot 4 - Power output ideal vs actual
subplot(4,1,4)
plot(t,powerIdeal,'r')
title('Sea height over one spring/neap cycle')
ylabel('Power out (MW)')
xlabel('time (hrs)')
grid on
hold on
%plot(t,powerAct,'b')
%legend('Ideal power','Actual power')
