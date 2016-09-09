% homework 2, part 1.
%
% Submit a report containing all of the figures from this .m file (EXCEPT
% FIGURE 500)
%
% the report should also explain what you are showing in the given figure.
%
% Also upload your .m files.
%
% However, do NOT upload your data files, I do not want to see them

clear
close all

pathS='/rcc4/homes/huang.2650/Downloads/5400/HW2'; % you will need to change this path to wherever you put the data on your computer
pathLS=[pathS,'loop data/090909/'];

stS='st1';

if exist([pathLS,stS,'.mat'])
    load([pathLS,stS])  % load the data from station 1 assuming it is in the folder where I put it on my computer
elseif exist([stS,'.mat'])
    load(stS) % otherwise, try loading it from the current working directory
else
    note='I cannot seem to find st1.mat, please move it to the same directory that has this .m file and try again'
    % break
end


pu=transMatch(p2uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
pd=transMatch(p2dE(:,1:2));

[pu,pd]=pulseMatch(pu,pd);



T=300; % quick check to make sure the

[q,occ,vs,vt]=getAgg(pu,pd,T,55);

if max(vs)==0
    % here is a quick check to see if the unmodified getAgg is working, it
    % should report q and vt
    %
    % do not discuss figure 500 in your report, well, you can if you want
    % to, but it will not be graded.
    
    tt=(1:24*3600/T)*T/3600; % time of each sample
    
    figure(500)
    plot(tt,q)
    title('quick check to see if the unmodified getAgg is working')
    
    clear q occ vs vt
    
    note='the code is about to stop at a keyboard command... hit "quit debugging" to resume editing or "continue" to continue'
    keyboard
end




T=1; % yes, for checking, we will use T=1 sec
[q,occ,vs,vt]=getAgg(pu,pd,T,55);
tt=(1:24*3600/T)*T/3600; % time of each sample

figure(1)
plot(tt,occ)
axis([17.29,17.32,-20,120])
xlabel('time (hr after midnight)')
ylabel('occ (%)')
title([stS,' sampled at ',num2str(T),' sec']) % check out the title on that plot!



T=30; % now use T=30 sec
[q,occ,vs,vt]=getAgg(pu,pd,T,55);
tt=(1:24*3600/T)*T/3600; % time of each sample

figure(2)
L=20/5280; % average effective vehicle length in miles
subplot(411)
plot(tt,vs)
axis([0,24,0,75])
% now use title, xlabel, and ylabel to clearly explain what this
% plot is showing

subplot(412)
plot(tt,vs-vt)
axis([0,24,-10,5])
% now use title, xlabel, and ylabel to clearly explain what this
% plot is showing

subplot(413)
plot(tt,100*L*q./occ);  % need the 100* to counter the % occ
axis([0,24,0,75])
% now use title, xlabel, and ylabel to clearly explain what this
% plot is showing

subplot(414)
plot(tt,100*L*q./occ,tt,vt,tt,vs)
axis([0,24,0,75])
% now use title, xlabel, ylabel, and legend to clearly explain what this
% plot is showing



figure(3)
plot(vs,vt,'.')
axis('square')
axis([0,80,0,80])
grid on
% now use title, xlabel, and ylabel to clearly explain what this
% plot is showing




% now lets load all 4 eb lanes at st1, might as well start with lane 2
% which is already ready... 

clear q occ vs vt

T=30; % now use T=30 sec

[q2,occ2,vs2,vt2]=getAgg(pu,pd,T,55);

tt=(1:24*3600/T)*T/3600; % time of each sample


pu=transMatch(p1uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
pd=transMatch(p1dE(:,1:2));
[pu,pd]=pulseMatch(pu,pd);
[q1,occ1,vs1,vt1]=getAgg(pu,pd,T,55);


pu=transMatch(p3uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
pd=transMatch(p3dE(:,1:2));
[pu,pd]=pulseMatch(pu,pd);
[q3,occ3,vs3,vt3]=getAgg(pu,pd,T,55);


pu=transMatch(p4uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
pd=transMatch(p4dE(:,1:2));
[pu,pd]=pulseMatch(pu,pd);
[q4,occ4,vs4,vt4]=getAgg(pu,pd,T,55);


figure(10)
subplot(311)
plot(tt,vs1,tt,vs2,tt,vs3,tt,vs4)
axis([0,24,0,75])
subplot(312)
plot(tt,q1,tt,q2,tt,q3,tt,q4)
axis([0,24,0,2500])
subplot(313)
plot(tt,occ1,tt,occ2,tt,occ3,tt,occ4)
axis([0,24,0,100])
% now use title, xlabel, ylabel, and legend to clearly explain what these
% plots are showing

figure(11)
subplot(221)
plot(occ1,q1,'.')
subplot(222)
plot(occ2,q2,'.')
subplot(223)
plot(occ3,q3,'.')
subplot(224)
plot(occ4,q4,'.')
% but look again, all 4 plots are on different scales- so fix that, make
% them all the same scale
%
% then use title, xlabel, and ylabel to clearly explain what the
% plots are showing
%
% What would we would call this relationship?

figure(12)
plot(occ1,q1,'.',occ2,q2,'.',occ3,q3,'.',occ4,q4,'.')


figure(13)
plot(q1./vs1,q1,'.',q2./vs2,q2,'.',q3./vs3,q3,'.',q4./vs4,q4,'.')
% now use title, xlabel, ylabel, and legend to clearly explain what these
% plots are showing
%
% What would we would call this relationship?


figure(14)
subplot(221)
plot(q1,vs1,'.')
subplot(222)
plot(q2,vs2,'.')
subplot(223)
plot(q3,vs3,'.')
subplot(224)
plot(q4,vs4,'.')
% but look again, all 4 plots are on different scales- so fix that, make
% them all the same scale
%
% then use title, xlabel, and ylabel to clearly explain what the
% plots are showing
%
% What would we would call this relationship?





if 0
    qN=[q1;q2;q3;q4];
    vsN=[vs1;vs2;vs3;vs4];
    vtN=[vt1;vt2;vt3;vt4];
else
    % exclude lane 4 from the net measurements, lane 4 exhibits strange
    % (but true) behavior unique to the geometry of this location. So to
    % keep the plots clean just use lanes 1-3
    qN=[q1;q2;q3];
    vsN=[vs1;vs2;vs3];
    vtN=[vt1;vt2;vt3];
end


uu=vsN>45; % looking at fig 10, subplot 311 this seems to do a good job of separating free flow from congested

vsMed=zeros(20,1);
vsAvg=zeros(20,1);
vsHav=zeros(20,1);

vtMed=zeros(20,1);
vtAvg=zeros(20,1);
vtHav=zeros(20,1);

qq=(1:20)*120;

for ii=1:20
    % u2=(vsN>45)&(qN==qq(ii));
    u2=uu&(qN==qq(ii));
    
    vsMed(ii)=median(vsN(u2));
    vsAvg(ii)=mean(vsN(u2));
    vsHav(ii)=1/mean(1./vsN(u2));
    
    vtMed(ii)=median(vtN(u2));
    vtAvg(ii)=mean(vtN(u2));
    vtHav(ii)=1/mean(1./vtN(u2));
    
end

figure(20)
plot(qq,vsMed,qq,vsAvg,qq,vsHav)

% figure(21); plot(qq,vtMed,qq,vtAvg,qq,vtHav)  % try this if you like, but do not include in your report



uu=vsN<45; % looking at fig 10, subplot 311 this seems to do a good job of separating free flow from congested

vsMed=zeros(20,1);
vsAvg=zeros(20,1);
vsHav=zeros(20,1);

vtMed=zeros(20,1);
vtAvg=zeros(20,1);
vtHav=zeros(20,1);

qq=(1:20)*120;

for ii=1:20
    u2=uu&(qN==qq(ii));
    
    vsMed(ii)=median(vsN(u2));
    vsAvg(ii)=mean(vsN(u2));
    vsHav(ii)=1/mean(1./vsN(u2));
    
    vtMed(ii)=median(vtN(u2));
    vtAvg(ii)=mean(vtN(u2));
    vtHav(ii)=1/mean(1./vtN(u2));
    
end

figure(20)
hold on
plot(qq,vsMed,qq,vsAvg,qq,vsHav)
hold off



