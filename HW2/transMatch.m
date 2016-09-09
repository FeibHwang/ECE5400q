
function [pu]=transMatch(pu)
% this function finds and deletes unmatched transitions
%
% input pu should have the form of: 
% column 1: transition state: 1=turn on, 0=turn off
% column 2: transition time, in 1/60 sec after midnight
%
% output has the same form as the input, but with all unmatched transitions
% removed

bb=find(diff(pu(:,1))==0)+1; % returns the index of all repeated transitions, the +1 to account for the fact that diff(x) has one less row than x
bb=bb-pu(bb,1); % want to keep the first repeated falling or the second repeated rising

% note how this approach still works if there are multiple successive repeated transitions, e.g., three 1's

if pu(1,1)==0
    bb=[1;bb]; % we do not want to keep the first transition if it is a falling edge... make sure you know why
end
if pu(end,1)==1
    bb=[bb;size(pu,1)]; % likewise, we do not want to keep the last transition if it is a rising edge
end

pu(bb,:)=[]; % delete the marked rows
end
