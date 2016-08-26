function [v,on,L,t]=toSpeed(pu,pd);
% this function finds individual vehicle speed, on_time, length, and
% passage time
%
% input pu and pd should have the form of: 
% column 1: transition state: 1=turn on, 0=turn off
% column 2: transition time, in 1/60 sec after midnight
%
% output one row per vehicle in:
% v in mph, on om 1/60 sec, L in ft, and t in 1/60 sec after midnight

pu=transMatch(pu(:,1:2)); 
pd=transMatch(pd(:,1:2));

[pu,pd]=pulseMatch(pu,pd);


%%%% copy your code from part 1, update the variable names.
%%%% do not scale speed here, do that in the main program

if 1
    % find speed, on_time, and vehicle length 
    v= SOMETHING; % find the speed of each matched vehicle from the rising edge transitions at the paired detectors in mph, note that the dual loop detectors are SUPPOSED to be 20 ft apart
    on= SOMETHING; % find the amount of time that the upstream detector is on for each pulse, in 1/60 sec
    L= SOMETHING; % find the vehicle length for each vehicle passage in ft
    t= SOMETHING; % find the time the vehicle passed the dual detector, in 1/60 sec after midnight
elseif 1
    % Coifman's solution will appear here in the solution, after your submission is due
end
end


