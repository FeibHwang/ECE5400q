function [q,occ,vs,vt]=getAgg(pu,pd,T,vTarget)
% this function assumes you have already run transMatch and pulseMatch
%
% input pu and pd should have the form of: 
% column 1: transition state: 1=turn on, 0=turn off
% column 2: transition time, in 1/60 sec after midnight
%      no unmatched transitions or pulses
% T: number of seconds per sample, e.g., 30
% vTarget: the speed you want to adjust median to
%
% output- sampled every T over 24 hrs
% q: flow in veh/hr
% occ: occupancy in % of sample time that the detector was occupied, i.e., (sum of on time)/T
% vs: space mean speed (harmonic mean)
% vt: time mean speed (arithmetic mean)
% samples are indext by the end time, so the first entry in each output
% variable corresponds to the sample ending at T sec after midnight
%
% for simplicity, we will calculate q and occ only for the upstream
% detector and speed from the rising edge



% first let's do the necessary individual vehicle calculations
v=20./(pd(1:2:end,2)-pu(1:2:end,2))*60^3/5280;  % speed from rising edge for all vehicles
on=(pu(2:2:end,2)-pu(1:2:end,2))/60;  % upstream on time for all vehicles in sec
tr=pu(1:2:end,2)/60;  % upstream rise time for all vehicles in sec after midnight
tf=pu(2:2:end,2)/60;  % upstream fall time for all vehicles in sec after midnight

% the free flow speed should be about vTarget at this station, so rescale
% the speed so that the median is vTarget
v=v*vTarget/median(v);

% now initilize your output vairables
nsamples=24*3600/T;
q=zeros(nsamples,1);
occ=q;  % just a quick and dirty trick to keep from typing... too bad I just wrote a longer comment to explain... so much for laziness
vs=q;
vt=q;

% we want to sort vehicles into their corresponding sample. The intuitive
% way to do it would be a for loop and find all t such that T_low<t<T_high
% while that will work, it is very inefficient since we have to touch every
% vehicle nsamples times. Instead, to just touch every vehicle once, in a
% matlab friendly format, we are going to do the following counter
% intuitive approach...

rindex=ceil(tr/T);
findex=ceil(tf/T); % you will need this bit for occ since the falling edge might fall in a sample after the rising edge, so you will have to split the on-time over 2+ samples

for ii=1:size(tr)
    q(rindex(ii))=q(rindex(ii))+1;  % note that this is not quite q, still have to multipy by 3600/T
    
    if 1
        if(rindex(ii)==findex(ii))
            occ(rindex(ii)) = occ(rindex(ii)) + on(ii);
        elseif(findex(ii)-rindex(ii)==1)
            occ(rindex(ii)) = occ(rindex(ii)) + (rindex(ii)*T - tr(ii));
            occ(findex(ii)) = occ(findex(ii)) + (tf(ii) - rindex(ii)*T);
        else
            occ(rindex(ii)) = occ(rindex(ii)) + (rindex(ii)*T - tr(ii));
            occ(findex(ii)) = occ(findex(ii)) + (tf(ii) - rindex(ii)*T);
            for i = 1 : findex(ii)-rindex(ii)
                occ(rindex(ii)+i) = T;
            end
        end
            
               
        % now add the code to also find occ, vt, and vs
        
        % be sure to anticipate the possibility that an on-time might be
        % split over 3+ samples when calculating occ
        
        vt(rindex(ii)) = vt(rindex(ii)) + v(ii);
        vs(rindex(ii)) = vs(rindex(ii)) + 1/v(ii);
    else
        % Coifman's solution will appear here in the solution, after your submission is due
        
       
    end
end

if 1
    % now add the code to clean up occ, vt, and vs
    occ = occ/T;
    vt = vt./q;
    vs = 1./(vs./q);
else
    % Coifman's solution will appear here in the solution, after your submission is due
    
end

q=q*3600/T; % convert units of q from veh/sample to veh/hr

end