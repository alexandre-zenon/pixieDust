function adaptsAxes(children,plotType,figAxis,minX,maxX,lgd)
if any(strcmp(plotType,'bar'))
    minX=minX-.5;
    maxX=maxX+.5;
    xd=get(children(find(strcmp(plotType,'bar'))),'XData');
    if iscell(xd)
        xd=xd{1};
    end
    set(figAxis,'XTick',xd);
end
if ~any(isinf([minX maxX]))
    xlim([minX maxX]);
end
if ~isempty(lgd)
    set(lgd,'Location','bestoutside');
end
end