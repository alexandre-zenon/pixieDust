function [scatterGroups,xdata,ydata]=groupScatterColors(children,colors,plotType)
scatterGroups=false(length(children),1);
xdata={};
ydata={};
if ~isempty(colors)
    if iscell(colors)
        allColors=cell2mat(get(children,'Color'));
    else
        allColors=colors;
    end
    allColors=allColors(:,1)+10*allColors(:,2)+100*allColors(:,3);
    if ~any(strcmp(plotType,'bar'))
        allScatters=strcmp(get(children,'Marker'),'o')|strcmp(get(children,'Marker'),'.');
        [a,b,scatterGroups]=unique(allColors);
        scatterGroups=scatterGroups.*allScatters;
        allG=unique(scatterGroups);
        numGroups=length(allG(allG>0));% number of groups of markers with distinct color
        for ng = 1:numGroups
            xdata{ng}=[];
            ydata{ng}=[];
        end
    end
else
end
end