function [children,plotType,plot2Label,xdata,ydata,colData,minX,maxX]=changesDataPlot(figAxis,style)

% definition of types of plot is in plotTypes().
% Then each type is implemented differently in the switch statement

%% Change data plot %%
% determines type and color of each plots
children = get(figAxis,'Children');
nextBar=0;
plotType = plotTypes(children);
colors = plotColors(children,plotType);

% groups markers of same color
[scatterGroups,xdata,ydata]=groupScatterColors(children,colors,plotType);
colData=xdata;

% Implements type-dependent styles
next=0;
nextScatter=0;
nextBar=0;
nextShaded=0;
nextLine=0;
nextErrorBar=0;
nextLegend=0;
maxX=-Inf;
minX=Inf;
plot2Label=[];

for cc = children'
    next=next+1;
    x=get(cc,'XData');
    maxX=max([maxX; x(:)]);% for determining axis lengths
    minX=min([minX; x(:)]);
    switch plotType{next}
        case 'scatter'
            nextScatter=nextScatter+1;
            l=mod(nextScatter-1,size(style.scatter.MarkerFaceColor,1))+1;
            faceCol=style.scatter.MarkerFaceColor(l,:);
            edgeCol=style.scatter.MarkerEdgeColor(l,:);
            if scatterGroups(next)>0
                xdata{scatterGroups(next)}=[xdata{scatterGroups(next)}; get(cc,'XData')'];
                ydata{scatterGroups(next)}=[ydata{scatterGroups(next)}; get(cc,'YData')'];
                colData{scatterGroups(next)}=faceCol;
            end
            appliesStyle(style,'scatter',cc,l);
        case 'shaded'
            nextShaded=nextShaded+1;
            nextLegend=nextLegend+1;
            plot2Label(nextLegend)=cc;
            l=mod(nextShaded-1,size(style.shaded.FaceColor,1))+1;
            appliesStyle(style,'shaded',cc,l);
        case 'bar'
            nextBar=nextBar+1;
            nextLegend=nextLegend+1;
            plot2Label(nextLegend)=cc;
            l=mod(nextBar-1,size(style.bar.FaceColor,1))+1;
            appliesStyle(style,'bar',cc,l);
        case 'line'
            nextLine=nextLine+1;
            l=mod(nextLine-1,size(style.line.color,1))+1;
            if any(strcmp(plotType,'shaded'))% then we assume that the line is part of the shaded area
            else
                nextLegend=nextLegend+1;
                plot2Label(nextLegend)=cc;
            end
            appliesStyle(style,'shaded',cc,l);
        case 'errorBar'
            nextErrorBar=nextErrorBar+1;
            nextLegend=nextLegend+1;
            plot2Label(nextLegend)=cc;
            hE_c                   = ...
                get(cc     , 'Children'    );
            errorbarXData          = ...
                get(hE_c(end), 'XData'       );
            errorbarYData          = ...
                get(hE_c(end), 'YData'       );
            if any(strcmp(plotType,'bar'))
                uistack(cc, 'bottom');%puts error bars behind the bar plots
                EBgain=style.bar.errorBar.width;
                l=mod(nextErrorBar-1,size(style.bar.errorBar.color,1))+1;
                col=style.bar.errorBar.color(l,:);
                set(hE_c(1),'Visible','off');%turns off the line linking the error bars
            else
                EBgain=style.errorBar.width;
                l=mod(nextErrorBar-1,size(style.errorBar.color,1))+1;
                col=style.errorBar.color(l,:);
            end
            errorbarWidth=EBgain*(errorbarXData(5)-errorbarXData(4));
            errorbarXData(4:9:end) = ...
                errorbarXData(1:9:end) - (errorbarWidth);
            errorbarXData(7:9:end) = ....
                errorbarXData(1:9:end) - (errorbarWidth);
            errorbarXData(5:9:end) = ...
                errorbarXData(1:9:end) + (errorbarWidth);
            errorbarXData(8:9:end) = ...
                errorbarXData(1:9:end) + (errorbarWidth);
            set(hE_c(end), 'XData', errorbarXData);
            set(hE_c(end), 'YData', errorbarYData);
            appliesStyle(style,'errorbar',cc,l);
        otherwise
            appliesStyle(style,plotType{next},cc,[]);
        
    end
end
end
