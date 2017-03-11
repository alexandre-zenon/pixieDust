function plotType = plotTypes(h)
% plotType = plotTypes(h) takes a handle input or a vector of
% inputs and outputs a cell array of strings indicating the type of each plot
plotType={};
for ii = 1:length(h)
    if strcmp(get(h(ii),'type'),'patch')
        floorValues=get(h(ii),'Ydata');
        if all(floorValues(1,:)==0) && all(floorValues(end,:)==0)%bottom of shape is fixed on zero
            plotType{ii}='hist';
        else
            plotType{ii}='shaded';
        end
    elseif strcmp(get(h(ii),'type'),'surface')
        plotType{ii}='surf';
    elseif isfield(get(h(ii)),'ContourMatrix')
        plotType{ii}='line';% contour plots have the same style as lines
    elseif strcmp(get(h(ii),'type'),'text')
        plotType{ii}='legend';
    else
        if strcmp(get(h(ii),'Tag'),'TMW_COLORBAR')
            plotType{ii}='colorbar';
        elseif strcmp(get(h(ii),'Type'),'image')
            plotType{ii}='image';
        elseif strcmp(get(h(ii),'type'),'hggroup')
            if isfield(get(h(ii)),'BarLayout')
                plotType{ii}='bar';
            else
                plotType{ii}='errorbar';
            end
        else
            if ~strcmp(get(h(ii),'Marker'),'none')
            %if logical(all(get(h(ii),'Marker')=='.' | get(h(ii),'Marker')=='o'))
                plotType{ii}='scatter';
            elseif ~strcmp(get(h(ii),'LineStyle'),'none')
                if strcmp(get(h(ii),'UserData'),'regressionLine')
                    plotType{ii}='regressionLine';
                elseif strcmp(get(h(ii),'UserData'),'regressionCI')
                    plotType{ii}='regressionCI';
                else
                    plotType{ii}='line';
                end
            else
                plotType{ii}='unknown';
            end
        end
    end
end
end