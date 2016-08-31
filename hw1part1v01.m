% homework 1, part 1.
%
% Submit a report containing the following figures from part 1:
% figure 10 (with the additions asked for)
% figure 15 (lots of stuff you need to figure out)
% figure 11 (after rescaling v21 and L21, with the additions asked for)
% figure 12 (with the additions asked for)
%
% and the following figures from part 2:
% figure 20 (with added titles, xlabel, ylabel)
% figure 80 (with added title, xlabel, ylabel, legend)
%
% the report should also explain what you are showing in the given figure.
%
% Also upload your .m files.
%
% However, do NOT upload your data files, I do not want to see them

%clear

%pathS='/Users/coifman.1/ my stuff/cars n bn/big day 090909 data/'; % you will need to change this path to wherever you put the data on your computer
%pathLS=[pathS,'loop data/090909/'];

%if exist([pathLS,'st1.mat'])
%    load([pathLS,'st1'])  % load the data from station 1 assuming it is in the folder where I put it on my computer
%elseif exist('st1.mat')
%    load st1 % otherwise, try loading it from the current working directory
%else
%    note='I cannot seem to find st1.mat, please move it to the same directory that has this .m file and try again'
%    break
%end


p2u1=transMatch(p2uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
p2d1=transMatch(p2dE(:,1:2));

%[p2u1,p2d1]=pulseMatch(p2u1,p2d1);


figure(10)
stairs(p2u1(:,2)/60^3,p2u1(:,1),'g')
hold on
stairs(p2d1(:,2)/60^3,p2d1(:,1)+1.2,'r')
hold off
axis([12.285,12.295,-0.3,2.5])
% now use title, xlabel, ylabel, and legend to clearly explain what this
% plot is showing


figure(15)
% now repeat figure(10) except find a time period where pulseMatch
% discarded pulses. Set your axis to that region. Show the upstream and
% downstream pulse trains for BEFORE and AFTER pulseMatch on the same plot.
% Part of your assignment is to figure out how to do so clearly.
%
% As always, use title, xlabel, ylabel, and legend to clearly explain what
% this plot is showing 
subplot(2,2,1)
stairs(p2u1(:,2)/60^3,p2u1(:,1),'g')
%axis([pu(bb(1),2)/60^3-0.01,pu(bb(1),2)/60^3+0.01,-0.3,2.5])
axis([12.326,12.335,-0.3,2.5])
subplot(2,2,3)
stairs(p2d1(:,2)/60^3,p2d1(:,1)+1.2,'r')
%axis([pu(bb(1),2)/60^3-0.01,pu(bb(1),2)/60^3+0.01,-0.3,2.5])
axis([12.326,12.335,-0.3,2.5])
[p2u1,p2d1]=pulseMatch(p2u1,p2d1);
subplot(2,2,2)
stairs(p2u1(:,2)/60^3,p2u1(:,1),'g')
%axis([pu(bb(1),2)/60^3-0.01,pu(bb(1),2)/60^3+0.01,-0.3,2.5])
axis([12.326,12.335,-0.3,2.5])
subplot(2,2,4)
stairs(p2d1(:,2)/60^3,p2d1(:,1)+1.2,'r')
%axis([pu(bb(1),2)/60^3-0.01,pu(bb(1),2)/60^3+0.01,-0.3,2.5])
axis([12.326,12.335,-0.3,2.5])


if 1
    % Complete the following code to find speed, on_time, and vehicle
    % length at station 1 lane 2. Note the variable names continue the N 
    % and M convention from above.
    %
    v21= (9000/11)./(p2d1(1:2:end,2,:)-p2u1(1:2:end,2,:));; % find the speed of each matched vehicle from the rising edge transitions at the paired detectors in mph, note that the dual loop detectors are SUPPOSED to be 20 ft apart
    on21= p2u1(2:2:end,2,:)-p2u1(1:2:end,2,:); % find the amount of time that the upstream detector is on for each pulse, in 1/60 sec
    L21= (v21*5280/3600/60).*on21; % find the vehicle length for each vehicle passage in ft
    t21= p2u1(1:2:end,2,:); % find the time the vehicle passed the dual detector, in 1/60 sec after midnight
elseif 1
    % Coifman's solution will appear here in the solution, after your submission is due
    
end

%%%% now step through the following one line at a time...

figure(11)
plot(t21/60^3,v21)
% you should see mostly reasonable speeds, with a few unreasonably large
% values.


% try this...
plot(t21/60^3,v21,'.')

% and then this...
axis([0,24,0,100])

% that looks mostly good, except try this and see what you find wrong...
median(v21)

if 1
    % the free flow speed should be about 55 mph at this station, so write 
    % code to rescale the speed so that the median is 55 mph, then 
    % recalculate L21
    v21= v21/median(v21)*55;
    L21= (v21*5280/3600/60).*on21; % same as above, only using the rescaled speed
else
    % Coifman's solution will appear here in the solution, after your submission is due

end

% try this again, it should look a lot better...
plot(t21/60^3,v21,'.')
axis([0,24,0,100])
median(v21)
% now use title, xlabel, ylabel, and legend to clearly explain what this
% plot is showing


% next, let's look at the vehicle lengths
figure(12)
plot(t21/60^3,L21,'.')
axis([0,24,0,100])
median(L21)
% now use title, xlabel, ylabel, and legend to clearly explain what this
% plot is showing










