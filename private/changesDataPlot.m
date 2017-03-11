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
    try 
        x=get(cc,'XData'); 
    catch
        x=[]; 
    end
    maxX=max([maxX; x(:)]);% for determining axis lengths
    minX=min([minX; x(:)]);
    switch plotType{next}
        case 'scatter'
            nextScatter=nextScatter+1;
            
            %%% TRANSPARENCY IN BETA VERSION
            if isfield(style,'scatter') && isfield(style.scatter,'Transparency') && style.scatter.Transparency
                set(cc,'Visible','off');
                fpos=get(gcf,'Position');
                fw=fpos(3);
                fh=fpos(4);
                apos=get(gca,'Position');
                aw=apos(3);
                ah=apos(4);
                w=fw*aw;
                h=ah*fh;
                sy=diff(get(gca,'YLim'));
                sx=diff(get(gca,'XLim'));
                xperunit=sx/w;
                yperunit=sy/h;
                t = linspace(0, 2*pi);
                rx = xperunit*style.scatter.MarkerSize/30;
                ry = yperunit*style.scatter.MarkerSize/30;
                x = bsxfun(@plus,get(cc,'XData')',rx*cos(t));
                y = bsxfun(@plus,get(cc,'YData')',ry*sin(t));
                p=patch(x', y',colData{scatterGroups(next)});
                appliesStyle(style,'transparentScatter',p,l);
            else
                %appliesStyle(style,'scatter',cc,l);
            end
            subfield=scatterMarkerField(cc);
            l=mod(nextScatter-1,size(style.scatter.(subfield).MarkerFaceColor,1))+1;
            faceCol=style.scatter.(subfield).MarkerFaceColor(l,:);
            edgeCol=style.scatter.(subfield).MarkerEdgeColor(l,:);
            if scatterGroups(next)>0
                xdata{scatterGroups(next)}=[xdata{scatterGroups(next)}; get(cc,'XData')'];
                ydata{scatterGroups(next)}=[ydata{scatterGroups(next)}; get(cc,'YData')'];
                colData{scatterGroups(next)}=faceCol;
            end
            appliesStyle(style.scatter,subfield,cc,l);
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
            l=mod(nextLine-1,size(style.line.Color,1))+1;
            if any(strcmp(plotType,'shaded'))% then we assume that the line is part of the shaded area
                appliesStyle(style.shaded,'line',cc,l);
            else
                nextLegend=nextLegend+1;
                plot2Label(nextLegend)=cc;
                appliesStyle(style,'line',cc,l);
            end
            
        case 'errorbar'
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
                EBgain=style.bar.errorbar.width;
                l=mod(nextErrorBar-1,size(style.bar.errorbar.Color,1))+1;
                col=style.bar.errorbar.Color(l,:);
                set(hE_c(1),'Visible','off');%turns off the line linking the error bars
            else
                EBgain=style.errorbar.width;
                l=mod(nextErrorBar-1,size(style.errorbar.Color,1))+1;
                col=style.errorbar.Color(l,:);
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
            
            if isfield(style,'errorbar') && isfield(style.errorbar,'Nudge') && style.errorbar.Nudge 
                numEB=sum(strcmp(plotType,'errorbar'));
                minSpace=min(diff(errorbarXData(1:9:end)));
                sep=minSpace/10;
                d=(sep*(l-1));
                errorbarXData=errorbarXData+d-(sep*(numEB-1))/2;
                
                errorbarLineXData          = ...
                get(hE_c(1), 'XData'       );
                errorbarLineXData=errorbarLineXData+d-(sep*(numEB-1))/2;
                set(hE_c(1), 'XData', errorbarLineXData);
            end
            set(hE_c(end), 'XData', errorbarXData);
            set(hE_c(end), 'YData', errorbarYData);
            appliesStyle(style,'errorbar',cc,l);
            
            maxX=max([maxX; errorbarXData(:)]);
            minX=min([minX; errorbarXData(:)]);
        otherwise
            appliesStyle(style,plotType{next},cc,[]);
        
    end
end
end
