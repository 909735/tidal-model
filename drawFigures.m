%drawFigures
%
%   A script to draw a few graphs from an individual 1D tidal station.
%   These are:
%
%   1 - Tidal height vs time
%   2 - Potential energy over time
%   3 - Projected power outputs over time

% figure(1), clf(1),
plot(time,tideHeight);
hold on;
plot(baseline(:,1),baseline(:,2),'k-.'),
title('Tide Height')
xlabel('time (s)')
ylabel('height from average (m)')

% Figure 2, tide potential energy over time
figure(2), clf(2),
plot(time,tideEnergy),
hold on;
plot(baseline(:,1),baseline(:,2),'k-.'),
title('Tide Potential')
xlabel('time (s)')
ylabel('energy of water (J)')

% Figure 3, maximum power output vs expected output over time
figure(3), clf(3),
plot(time,tidePowerMax),
hold on;
plot(time,tidePowerAct),
plot(baseline(:,1),baseline(:,2),'k-.'),
title('Tide Power')
xlabel('time (s)')
ylabel('Expected output (W)')
legend('Max output','Estimated output','location','sw')