function plot_PCA(m,n,y1,y2,X)

% seperate X into year clusters
%y2005 = X(2:20,:);
%y2008 = X(31:54,:);
%y2011 = X(55:84,:);
%y2014 = X(85:end,:);

%% y1
if y1 == 2005
    y2005 = X(2:20,:);
    y2005x = y2005(:,m);
    y2005y = y2005(:,n);
    plot(y2005x,y2005y,'.','color',[163,33,26]./255,'MarkerSize',40)
    hold on
elseif y1 == 2008
    y2008 = X(31:54,:);
    y2008x = y2008(:,m);
    y2008y = y2008(:,n);
    plot(y2008x,y2008y,'.','color',[245,174,39]./255,'MarkerSize',40)
    hold on
elseif y1 == 2011
    y2011 = X(55:84,:);
    y2011x = y2011(:,m);
    y2011y = y2011(:,n);
    plot(y2011x,y2011y,'.','color',[72,167,12]./255,'MarkerSize',40)
    hold on
else
    y2014 = X(85:end,:);
    y2014x = y2014(:,m);
    y2014y = y2014(:,n);
    plot(y2014x,y2014y,'.','color',[80,216,250]./255,'MarkerSize',40)
    hold on
end

%% y2
if y2 == 2005
    y2005 = X(2:20,:);
    y2005x = y2005(:,m);
    y2005y = y2005(:,n);
    plot(y2005x,y2005y,'.','color',[163,33,26]./255,'MarkerSize',40)
elseif y2 == 2008
    y2008 = X(31:54,:);
    y2008x = y2008(:,m);
    y2008y = y2008(:,n);
    plot(y2008x,y2008y,'.','color',[245,174,39]./255,'MarkerSize',40)
elseif y2 == 2011
    y2011 = X(55:84,:);
    y2011x = y2011(:,m);
    y2011y = y2011(:,n);
    plot(y2011x,y2011y,'.','color',[72,167,12]./255,'MarkerSize',40)
else
    y2014 = X(85:end,:);
    y2014x = y2014(:,m);
    y2014y = y2014(:,n);
    plot(y2014x,y2014y,'.','color',[80,216,250]./255,'MarkerSize',40)
end
xlabel(sprintf('PC%d',m))
ylabel(sprintf('PC%d',n))

if y1 == 2011 || y2 == 2011
    set(gca,'xtick',-0.2:0.1:0.3)
else
    set(gca,'xtick',-0.2:0.1:0.15)
end

set(gca,'ytick',-0.4:0.1:0.4)
set(gca,'FontSize',20)
title(sprintf('SNPs changed from year %d to year %d',y1,y2),'FontSize',18)
legend(sprintf('year %d',y1),sprintf('year %d',y2))