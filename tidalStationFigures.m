%% Draw Figures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Sea height and lagoon height vs time

% Setup
% Create a dashed line to show mean water
datum = [t0,0;tEnd,0];

% Subplot 1 - Sea level for site over time
figure(1), clf(1)
subplot(4,1,1)
plot(t,hSea,'r')
title('Sea height over one spring/neap cycle')
ylabel('height from average (m)')
xlabel('time (hrs)')
legend('Sea height')
grid on
hold on
% plot(datum(:,1),datum(:,2),'k-.'),

% Subplot 2 - Lagoon level for site with dashed sea level
subplot(4,1,2)
plot(t,hSea,'k-.')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
plot(t,hLagoon,'b')
legend('Sea height','Lagoon height')
% plot(datum(:,1),datum(:,2),'k-.')

% Subplot 3 - Height from average
subplot(4,1,3)
plot(t,deltaH,'k')
ylabel('height from average (m)')
xlabel('time (hrs)')
grid on
hold on
legend('Height Difference')

% Subplot 4 - Power output ideal vs actual
subplot(4,1,4)
plot(t,powerIdeal,'r')
ylabel('Power out (W)')
xlabel('time (hrs)')
grid on
hold on
%plot(t,powerAct,'b')
%legend('Ideal power','Actual power')
