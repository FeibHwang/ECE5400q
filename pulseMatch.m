
function [pu,pd]=pulseMatch(pu,pd)
% this function finds and deletes unmatched pulses for a dual loop detector

% input pu and pd should have the form of: 
% column 1: transition state: 1=turn on, 0=turn off
% column 2: transition time, in 1/60 sec after midnight
%
% output has the same form as the input, but with all unmatched pulses
% removed. Thus, pu and pd should both have the same number of rows by the
% end of this function.
%
% ... unfortunately, you have to write most of the code

if 0
    % here is a stupid trick to help you edit the code before actually
    % using it as a function
    
    % first of all, change the if statement above to "if 1" so that you do
    % enter this chunk of code...
    
    %%%%%%%%%%%%
    % this next bit is important...
    %%%%%%%%%%%%
    % put a breakpoint on the next line of code and CALL THIS FROM hw1part1
    % as normal. Say on the next line since matlab will not let you set it
    % on a comment line:
    tmp=1;
    
    % now look at your workspace, you should only have three variables: pu,
    % pd, and tmp. Everything from hw1part1 has been pushed into storage
    % and you can only work with variables that were either passed in (pu
    % and pd) or that you created (tmp)
    
    % Also note, however, that when you return to hw1part1 with this
    % section enabled, the rest of that code will give you garbage results
    % because you are doing away with most of the data.
    
    % now let's get the data to a manageable size so that you can study what
    % is going on (you will have to figure out that analysis for yourself).
    % Just be careful to keep the number even in the following commands
    pu=pu(1:26,:);
    pd=pd(1:26,:);
    
    % next, create an unmatched pulse...
    pu(11:12,:)=[];
    
    % okay, now we have a manageable data set to get the code working.
    % Just be sure to disable this section once you have it working.
    % Also
    
    % but even before attempting that...
    % As a big hint to help you code, take 30 sec or a minute of real
    % transitions from a dual loop detector (as done above). If the pulses
    % are already all matched, try deleting one pulse and first do the
    % manipulation "by hand" in a spreadsheet for detecting the problem. 
    % Then figure out how to explain the process in a sequence of commands.
    % Then try that here in matlab and use the debugger to step through and
    % catch those small mistakes that keep the code from running.
    
    % Oh, one last hint, it might help if you already understand how
    % transMatch works... but you might want to borrow some of the above
    % ideas to do so.

end

cuu=[pu(1:2:end,2),pu(2:2:end,2),1+0*pu(1:2:end,2)]; % the last column is using a quick coding trick to create a vector of 1's the same size as the first two columns.
cdd=[pd(1:2:end,2),pd(2:2:end,2),0*pd(1:2:end,2)]; 
% but what are those first two columns and why can we get away with this?

cnet=[cuu;cdd];
cnet=sortrows(cnet,1);

bb=find(diff(cnet(:,3))==0)+1;
bb=bb-cnet(bb,3);
cnet(bb,:)=[];

tmp1 = cnet(1:2:end,:);
tmp2 = cnet(2:2:end,:);

pu = sortrows([[1+0*tmp1(:,1),tmp1(:,1)];[0*tmp1(:,1),tmp1(:,2)]],2);
pd = sortrows([[1+0*tmp2(:,1),tmp2(:,1)];[0*tmp2(:,1),tmp2(:,2)]],2);



%%%% now write your code to find and delete unmatched pulses, then report
%%%% the results in the form of pu and pd
%%%%
%%%% note that when you see an unmatched pulse we cannot easily
%%%% differentiate between pulse breakup at one detector or a missed
%%%% vehicle at the other detector. So, to keep our data clean, we will
%%%% mark for deletion both the pulse with no known match and two more
%%%% pulses. Namely, for the second unmatched downstream detector pulse,
%%%% mark for deletion both of the downstream pulses and the immediatly
%%%% preceding upstream pulse. Conversely, for an unmatched upstream pulse,
%%%% mark for deletion both of the upstream pulses and the very next
%%%% downstream pulse.
%%%%






if 1
    % Coifman's solution will appear here in the solution, after your submission is due

end



end