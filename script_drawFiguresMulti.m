%% Draw Figures Multi
%
%   A script to draw a graph showing combined tidal station outputs 

%%

% Start figures
figMulti = figure(1); clf(figMulti);
title('Combined station output')
ylabel('power out (MW)')
xlabel('time (hrs)')
hold on

% Plot cumulative
%plot(t,dataMWTotal,'-k','LineWidth',2)
area(t,dataMWTotal)
%colororder([0.9,0.9,0.9])

for s=[1:numStations]
    % Plot individual station data
    disp("Plotting "+s)
    plot(dataTime,dataMWAll(s,:)),
end

% Save fig
fullPath = figPath+figPrefix+"_Len"+endDayGraph+"sum.png";
exportgraphics(figMulti,fullPath,'Resolution',300)