%drawFigures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Sea height and lagoon height vs time

% Setup
% Create a dashed line to show mean water
datum = [t0,0;tEnd,0];

figure(1), clf(1)
subplot(2,1,1)
plot(t,hSea,'r')
title('Sea height over one spring/neap cycle')
ylabel('height from average (m)')
xlabel('time (hrs)')
legend('Sea height')
grid on
hold on
% plot(datum(:,1),datum(:,2),'k-.'),

subplot(2,1,2)
plot(t,hSea,'k-.')
ylabel('height from average (m)')
xlabel('time (hrs)')
legend('Lagoon height')
grid on
hold on
plot(t,hLagoon,'b')
% plot(datum(:,1),datum(:,2),'k-.')