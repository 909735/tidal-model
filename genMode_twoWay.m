%%  Generation Mode - Two-Way
%   The model for a two-way generation station. Generates the indices
%   of the gate opening times.

%   Holds water at high and low tide for a hold time, then releases it as 
%   the sea level is lower or higher respectively.


%% Setup

% Find time indicies of lagoon highs and lows
[highLags,highLagInds] = findpeaks(lagH,'MinPeakProminence',0.5);
[lowLags,lowLagInds] = findpeaks(-lagH,'MinPeakProminence',0.5); 
lowLags=-lowLags;

%lastGateCloseHeight = highLags(1);
%lastGateCloseInd = highLagInds(1);

lastGateCloseHeight = 0;
lastGateCloseInd = 1;

% Find whichever is lower
nHigh = length(highLags);
nLow = length(lowLags);
waveCount = min(nHigh,nLow);
disp("H:"+nHigh+" L:"+nLow+" Waves:"+waveCount)

%{
pause(0.6)
figure(1), clf(1),
grid on
title('Water height')
ylabel('h (m)')
xlabel('t (hrs)')
plot(t,seaH,'r-')
hold on
plot(t,lagH,'b','LineWidth',1.5)
hold off
%}

%% Loop to trap water at high/low tide
% For every cycle (taken as high tide) and a couple more just in case:
for w=[1:nHigh]
%% First half - Ebb, holding and gate open time

    %{
%   Find time indicies of lagoon highs
    [highLags,highLagInds] = findpeaks(lagH,'MinPeakProminence',0.5);
    
    pause(0.3)    
    plot(t,seaH,'r-')
    hold on
    plot(t,lagH,'b','LineWidth',1.5)
    scatter(t(highLagInds),highLags,'m*')
    scatter(t(lowLagInds),lowLags,'m*')
    hold off
    %disp("Done ebb "+w)
    
%   Check for edgecase where number of peaks reduces at end of calc
    nHigh = length(highLags);
    if w>nLow, flag=1; break;
    end
    %}

%   For each point within the hold time after high water
    for x=[0:holdIndTWHW]
        curInd = lastGateCloseInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last high water
        lagH(curInd) = lastGateCloseHeight;
    end
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(w) = curInd;

%   Release the water using the flow function
    script_releaseWater;
    
    
%% Second half - Flow, holding and gate open time

    %{
%   Find time indicies of lagoon lows 
    [lowLags,lowLagInds] = findpeaks(-lagH,'MinPeakProminence',0.5); 
    lowLags=-lowLags;  
    
    pause(0.3)    
    plot(t,seaH,'r-')
    hold on
    plot(t,lagH,'b','LineWidth',1.5)
    scatter(t(highLagInds),highLags,'m*')
    scatter(t(lowLagInds),lowLags,'m*')
    hold off
    %disp("Done flow "+w)
    
%   Check for edgecase where number of troughs reduces at end of calc
    nLow = length(lowLags);
    if w>nLow, flag=1; break
    end
    %}
    
%   For each point within the hold time after low water
    for x=[0:holdIndTWLW]
        curInd = lastGateCloseInd+x;
        
%       Check if within bounds
        if curInd>numData, flag=1; break;     
        end
%       Set height to last low water
        lagH(curInd) = lastGateCloseHeight;
    end    
    
%   Break second loop if out of bounds
    if flag==1, break
    end
    
%   The last index of holding time is the gate open time
%   Add gate open time to an array
    gateOpens(w) = curInd;

%   Release the water using the flow function
	script_releaseWater;
    
    
end

flag = 0;


