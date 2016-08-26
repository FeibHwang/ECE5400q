
clear

pathS='/Users/coifman.1/ my stuff/cars n bn/big day 090909 data/'; % you will need to change this path to wherever you put the data on your computer
pathLS=[pathS,'loop data/090909/'];

% now load the data from station 13
if exist([pathLS,'st13.mat'])
    load([pathLS,'st13'])  % load the data from station 1 assuming it is in the folder where I put it on my computer
elseif exist('st13.mat')
    load st13 % otherwise, try loading it from the current working directory
else
    note='I cannot seem to find st1.mat, please move it to the same directory that has this .m file and try again'
    break
end

[vU,onU,LU,tU]=toSpeed(p3uE(:,1:2),p3dE(:,1:2));

if 0
    % set the target free flow speed to be 60 mph at station 13 and 16, 
    % modify your code from part 1 accordingly, then recalculate L
    vU= SOMETHING;
    LU= SOMETHING;
else
    % Coifman's solution will appear here in the solution, after your submission is due

end


% now load the data from station 16
if exist([pathLS,'st16.mat'])
    load([pathLS,'st16'])  % load the data from station 1 assuming it is in the folder where I put it on my computer
elseif exist('st16.mat')
    load st16 % otherwise, try loading it from the current working directory
else
    note='I cannot seem to find st1.mat, please move it to the same directory that has this .m file and try again'
    break
end

[vD,onD,LD,tD]=toSpeed(p3uE(:,1:2),p3dE(:,1:2));

if 1
    % set the target free flow speed to be 60 mph at station 13 and 16, 
    % modify your code from part 1 accordingly, then recalculate L
    vD= SOMETHING;
    LD= SOMETHING; 
else
    % Coifman's solution will appear here in the solution, after your submission is due

end

figure(20)
subplot(411)
plot(tU/60^3,vU,'.')
axis([0,24,0,100])
median(vU)

subplot(413)
plot(tU/60^3,LU,'.')
axis([0,24,0,100])
median(LU)

subplot(412)
plot(tD/60^3,vD,'.')
axis([0,24,0,100])
median(vD)

subplot(414)
plot(tD/60^3,LD,'.')
axis([0,24,0,100])
median(LD)





figure(80)
plot(tU/60^3+1/60,LU,'go',tD/60^3,LD,'rx')
axis([17.95,18.15,0,80])
% now use title, xlabel, ylabel, and legend to clearly explain what this
% plot is showing
% You should also add a paragraph to your writeup explaining what this
% plot is showing (well, do that for all plots, but this one especially so)
