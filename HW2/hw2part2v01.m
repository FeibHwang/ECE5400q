% homework 2, part 2.
%
% Submit a report containing all of the figures from this .m file and the
% requested discussion.
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


% st#N st#S locN locS speedLimit
stData=[
    102 102 1920 1920 55
    105 103 5632 4587 55
    109 108 10660 9637 55
    1 1 15760 15615 55   % data from HW1
    4 4 20830 20790 65   % no NB lane 2 data on this day, maybe add back in using lane 3?
    7 7 27505 27370 65
    % 10 10 32100 31985 65   % no data on this day
    13 13 38350 38220 65   % data from HW1
    16 16 44250 44120 65   % data from HW1
    19 19 50250 50120 65
    22 22 55750 55620 65
    25 25 61280 61140 65
];


nSt=size(stData,1);

T=120;
tt=(1:24*3600/T)*T/3600; % time of each sample

qN=nan*ones(nSt,size(tt,2));
vN=qN;
occN=qN;

for ii=1:nSt
    stS=['st',num2str(stData(ii,1))];
    
    if exist([pathLS,stS,'.mat'])
        load([pathLS,stS])  % load the data from station 1 assuming it is in the folder where I put it on my computer
    elseif exist([stS,'.mat'])
        load(stS) % otherwise, try loading it from the current working directory
    else
        note=['I cannot seem to find st',num2str(stData(ii,1)),'.mat, please move it to the same directory that has this .m file and try again']
        break
    end
    
    if size(p2dE,1)>100
        pu=transMatch(p2uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
        pd=transMatch(p2dE(:,1:2));
    else
        % st4 NB, lane 2 downstream is bad on this day, so use lane 3
        % instead
        pu=transMatch(p3uE(:,1:2));  % using pNuM with N to denote lane and M to denote station
        pd=transMatch(p3dE(:,1:2));
    end
    
    [pu,pd]=pulseMatch(pu,pd);
        
    [q,occ,vs,vt]=getAgg(pu,pd,T,stData(ii,5));

    if max(vs)<5
        note='it looks like your getAgg is not yet producing space mean speed.'
        note2='you need that to go on, so this code will stop here for now...'
        keyboard
    end
    
    qN(ii,:)=q;
    vN(ii,:)=vs;
    occN(ii,:)=occ;

end

xNE=stData(:,3);
nn=size(xNE,1);
dx=diff(xNE)/2;
xNE2=[xNE(1)-dx(1);xNE(1:nn-1)+dx;xNE(nn)+dx(nn-1)];
vNE2=[vN;vN(nn,:)];


xRd=[7637    % I70
     8969    % I71
     11141   % I670
     66978]; % I270

cm=[zeros(100,1),(1:100)'/100,zeros(100,1)];
cm=[(100:-1:1)'/400,(1:100)'/100,zeros(100,1)];
cm(1,:)=[1 1 1];


figure(30)
pcolor(tt,xNE2/5280,vNE2)
hold on
plot([0,24],[xRd,xRd]'/5280,'r')
plot([0;24],[xNE';xNE']/5280,'b--')
hold off
shading flat
colormap(cm)
caxis([0,80])
colorbar('vert')
% now use title, xlabel, and ylabel to clearly indicate what this
% plot is showing.
%
% Also include a paragraph or two explaining what this figure shows








if 0
    % now repeat for southbound in figure(31), but make sure that traffic
    % flows from bottom to the top  
    
    
    
else
    % Coifman's solution will appear here in the solution, after your submission is due
    
    
end





if 1
    % try the following plots to see what they do with the same data as
    % figure 30, but they ARE NOT part of the assignment and you do NOT
    % have to turn anything in for them. They are just great commands to
    % have in your toolbox when you need them.
    %
    % However, you will have to wait for my solutions to see my titles and
    % labels since they will correspnd to some of what you are supposed to
    % do for figure 30.
    
    
    figure(40)
    contour(tt,xNE/5280,vN,10:15:50,'b')
    
    figure(41)
    clabel(contour(tt,xNE/5280,vN,10:15:50,'b'));
    
    
    figure(42)
    surf(tt,xNE/5280,vN)
    colormap(cm)
    caxis([0,80])
    shading flat
    view(15,45)
    rotate3d on
    
    if 1
        % Coifman's solution will appear here in the solution, after your submission is due

        
    end

end