%% Load election Data
clear;
clc;

file = 'ElectionData.xlsx';
    [num,text,raw] = xlsread(file);
    %Clinton = column 2 in raw
    %Trump = 4
    %Johnson = 6

    
    %% Define colours for the map based on turnout for all parties

%First, adjust columns 2, 4 and 6 for the number of EC votes in that state.
n = 1;
while n<= length(num)
    num(n,2) = num(n,2)/num(n,9);
    num(n,4) = num(n,4)/num(n,9);
    num(n,6) = num(n,6)/num(n,9);
    n = n+1;
end    
    
Anchor = max(max(num(:,2:6)));

proportions = zeros(49,3);
n = 1;
while n<= length(proportions)
   proportions(n,3) = num(n,2)/Anchor; 
   proportions(n,1) = num(n,4)/Anchor;
   proportions(n,2) = num(n,6)/Anchor;
    
    n = n+1;
end
%square root to make states populations more linear.
proportions = sqrt(proportions);
%Change the background grey
proportions = proportions+.2;
proportions = proportions ./ max(max(proportions));


%% Define map colour based on the win margin. Make all defaults white

%%First, adjust columns 2, 4 and 6 for the number of EC votes in that state.
% n = 1;
% while n<= length(num)
%     num(n,2) = num(n,2)/num(n,9);
%     num(n,4) = num(n,4)/num(n,9);
%     num(n,6) = num(n,6)/num(n,9);
%     n = n+1;
% end

% %Now find the biggest value and anchor everything to it.
% Anchor = max(max(num(:,2:6)));
% 
% proportions = zeros(49,3);
% n = 1;
% while n<= length(proportions)
%     if num(n,2) > num(n,4) && num(n,2) > num(n,6) %Clinton win
%         proportions(n,3) = (num(n,2)/Anchor); 
%         proportions(n,2) = 0;
%         proportions(n,1) = 0;
%     elseif num(n,4) > num(n,2) && num(n,4) > num(n,6) %Trump Win
%         proportions(n,1) = (num(n,4)/Anchor);
%         proportions(n,2) = 0;
%         proportions(n,3) = 0;
%     elseif num(n,6) > num(n,2) && num(n,6) > num(n,4) %Johnson Win
%         proportions(n,2) = (num(n,6)/Anchor);
%         proportions(n,1) = 0;
%         proportions(n,3) = 0;
%     else %error
%         proportions(n,1) = 1;
%         proportions(n,2) = 1;
%         proportions(n,3) = 1;
%     end
%     n = n+1;
% end
% %square root to make states populations more linear.
% proportions = nthroot(proportions,2);
% %Change the background grey
% proportions = proportions+.2;
% proportions = proportions ./ max(max(proportions));


%% simply recreate the 2016 states map from nyt

% %Now find the biggest value and anchor everything to it.
% Anchor = max(max(num(:,2:6)));
% 
% proportions = zeros(49,3);
% n = 1;
% while n<= length(proportions)
%     if num(n,2) > num(n,4) && num(n,2) > num(n,6) %Clinton win
%         proportions(n,3) = 196; 
%         proportions(n,2) = 128;
%         proportions(n,1) = 26;
%     elseif num(n,4) > num(n,2) && num(n,4) > num(n,6) %Trump Win
%         proportions(n,1) = 204;
%         proportions(n,2) = 61;
%         proportions(n,3) = 61;
%     elseif num(n,6) > num(n,2) && num(n,6) > num(n,4) %Johnson Win
%         proportions(n,2) = 173;
%         proportions(n,1) = 126;
%         proportions(n,3) = 83;
%     else %error
%         proportions(n,1) = 1;
%         proportions(n,2) = 1;
%         proportions(n,3) = 1;
%     end
%     n = n+1;
% end
% %square root to make states populations more linear.
% proportions = proportions ./ 255;


%% graph it

% use this to Just make all the states the same light grey
%proportions(:,:) = 225 ./ 255;

Colors = proportions;

figure('units','normalized','outerposition',[0 0 1 1])
ax = usamap('conus');
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});

faceColors = makesymbolspec('Polygon',...
    {'INDEX', [1 numel(states)], 'FaceColor', ... 
    Colors}); %NOTE - colors are random
geoshow(ax, states, 'DisplayType', 'polygon', ...
   'SymbolSpec', faceColors)
framem off; gridm off; mlabel off; plabel off;



%State labels
textm(37,-121.5,' CA ',...
    'fontweight','bold','Rotation',0)
textm(43.5,-122,' OR ',...
    'fontweight','bold','Rotation',0)
textm(47,-122,' WA ',...
    'fontweight','bold','Rotation',0)
textm(43.5,-115,' ID ',...
    'fontweight','bold','Rotation',0)
textm(40,-118.5,' NV ',...
    'fontweight','bold','Rotation',0)
textm(34.5,-113,' AZ ',...
    'fontweight','bold','Rotation',0)
textm(39,-113,' UT ',...
    'fontweight','bold','Rotation',0)
textm(47,-111,' MT ',...
    'fontweight','bold','Rotation',0)
textm(43,-109,' WY ',...
    'fontweight','bold','Rotation',0)
textm(39,-107,' CO ',...
    'fontweight','bold','Rotation',0)
textm(34.5,-107.5,' NM ',...
    'fontweight','bold','Rotation',0)
textm(31,-100,' TX ',...
    'fontweight','bold','Rotation',0)
textm(47.5,-101.5,' ND ',...
    'fontweight','bold','Rotation',0)
textm(44.5,-101.5,' SD ',...
    'fontweight','bold','Rotation',0)
textm(41.5,-101,' NE ',...
    'fontweight','bold','Rotation',0)
textm(39,-100,' KS ',...
    'fontweight','bold','Rotation',0)
textm(35.5,-99,' OK ',...
    'fontweight','bold','Rotation',0)
textm(47,-96,' MN ',...
    'fontweight','bold','Rotation',0)
textm(42,-95,' IA ',...
    'fontweight','bold','Rotation',0)
textm(38.5,-94,' MO ',...
    'fontweight','bold','Rotation',0)
textm(35,-94,' AR ',...
    'fontweight','bold','Rotation',0)
textm(31,-93.5,' LA ',...
    'fontweight','bold','Rotation',0)
textm(33,-91,' MS ',...
    'fontweight','bold','Rotation',0)
textm(40,-90,' IL ',...
    'fontweight','bold','Rotation',0)
textm(45,-91,' WI ',...
    'fontweight','bold','Rotation',0)
textm(43.5,-85.75,' MI ',...
    'fontweight','bold','Rotation',0)
textm(40,-87,' IN ',...
    'fontweight','bold','Rotation',0)
textm(38,-85.5,' KY ',...
    'fontweight','bold','Rotation',0)
textm(36,-87.5,' TN ',...
    'fontweight','bold','Rotation',0)
textm(33,-87.5,' AL ',...
    'fontweight','bold','Rotation',0)
textm(40.5,-84,' OH ',...
    'fontweight','bold','Rotation',0)
textm(33,-84,' GA ',...
    'fontweight','bold','Rotation',0)
textm(28,-82.25,' FL ',...
    'fontweight','bold','Rotation',0)
textm(34,-81.5,' SC ',...
    'fontweight','bold','Rotation',0)
textm(36,-80.5,' NC ',...
    'fontweight','bold','Rotation',0)
textm(37.75,-79.25,' VA ',...
    'fontweight','bold','Rotation',0)
textm(38.5,-82.5,' WV ',...
    'fontweight','bold','Rotation',0)
textm(41.25,-79,' PA ',...
    'fontweight','bold','Rotation',0)
textm(43.25,-76.75,' NY ',...
    'fontweight','bold','Rotation',0)
textm(45.75,-70.25,' ME ',...
    'fontweight','bold','Rotation',0)
textm(38,-75.5,' MD ',...
    'fontweight','bold','Rotation',0)
textm(40,-74.25,' NJ ',...
    'fontweight','bold','Rotation',0)
textm(41.25,-72.25,' CT ',...
    'fontweight','bold','Rotation',0)
textm(39,-74.75,' DE ',...
    'fontweight','bold','Rotation',0)
textm(41.25,-70,' RI ',...
    'fontweight','bold','Rotation',0)
textm(42.75,-70.5,' MA ',...
    'fontweight','bold','Rotation',0)
textm(37,-75.5,' DC ',...
    'fontweight','bold','Rotation',0)
textm(46,-74,' VT ',...
    'fontweight','bold','Rotation',0)
textm(46.5,-72.75,' NH ',...
    'fontweight','bold','Rotation',0)