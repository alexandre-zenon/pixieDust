function addsRegressionLine(plotType,style,xdata,ydata,colData)
if any(strcmp(plotType,'scatter')) && isfield(style,'regressionLineOption')
    if style.regressionLineOption
        for ng = 1:length(xdata)
            x=xdata{ng};
            y=ydata{ng};
            col=colData{ng};
            regression_line_ci(.05,x,y,dark(col),style.regressionLine.LineWidth);
        end
    end
end
end