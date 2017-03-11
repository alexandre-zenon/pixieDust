function style = exportPixieStyle
% Exports a style structure from a figure.
%
% style = exportPixieStyle      exports a style structure from a figure.
% This is useful when the style has been modified by hand in the figure.

style=loadDefaultStyle;

%% FIGURE PROPERTIES %%
defaultColors=[0 0 1; 0 0.5 0; 1 0 0; 0 0.75 0.75; 0.75 0 0.75; 0.75 0.75 0; 0.25 0.25 0.25];
fig=gcf;
currentPos=get(fig,'Position');
figW=currentPos(3);
figH=currentPos(4);
style.figure.width                      =   figW;
style.figure.height                     =   figH;

%% AXES PROPERTIES %%
ax=gca;
style=fillDefaultProperties(style,'axes',ax);
xl=get(ax,'XLabel');
yl=get(ax,'YLabel');
zl=get(ax,'ZLabel');
defaultStyle=loadDefaultStyle;
defaultLabelProperties=fieldnames(defaultStyle.labels);
for aa = 1:length(defaultLabelProperties)
    if strcmp(defaultLabelProperties{aa},'XLabel')
        style.labels.XLabel=get(xl,'String');
    elseif strcmp(defaultLabelProperties{aa},'YLabel')
        style.labels.YLabel=get(yl,'String');
    elseif strcmp(defaultLabelProperties{aa},'ZLabel')
        style.labels.ZLabel=get(zl,'String');
    elseif strcmp(defaultLabelProperties{aa},'fXLabelRotation')
        style.labels.fXLabelRotation=get(xl,'Rotation');
    elseif strcmp(defaultLabelProperties{aa},'fYLabelRotation')
        style.labels.fYLabelRotation=get(yl,'Rotation');
    elseif strcmp(defaultLabelProperties{aa},'fZLabelRotation')
        style.labels.fZLabelRotation=get(zl,'Rotation');
    else
        style.labels.(defaultLabelProperties{aa})=get(xl,defaultLabelProperties{aa});
    end
end

%% LEGEND PROPERTIES %%
style.legend.colorLabel              =   {};

%% TYPES OF PLOTS %%
children = get(ax,'Children');
plotType = plotTypes(children);
colors = plotColors(children,plotType);
next=0;
nextScatter=0;
nextBar=0;
nextShaded=0;
nextLine=0;
nextErrorBar=0;
nextRegressionLine=0;
for cc=children'
    next=next+1;
    switch plotType{next}
        case 'scatter'
            nextScatter=nextScatter+1;
            style=fillDefaultProperties(style,'scatter',cc,nextScatter);
            subfield=scatterMarkerField(cc);
            style.scatter=fillDefaultProperties(style.scatter,subfield,cc,nextScatter);
        case 'line'
            nextLine=nextLine+1;
            style=fillDefaultProperties(style,'line',cc,nextLine);
        case 'regressionLine'
            nextRegressionLine=nextRegressionLine+1;
            style=fillDefaultProperties(style,'regressionLine',cc,nextRegressionLine);
        case 'shaded'
            nextShaded=nextShaded+1;
            style=fillDefaultProperties(style,'shaded',cc,nextShaded);
        case 'bar'
            nextBar=nextBar+1;
            style=fillDefaultProperties(style,'bar',cc,nextBar);
        otherwise
            style=fillDefaultProperties(style,plotType{next},cc);
    end
end
end

function style=fillDefaultProperties(style,fieldname,object,varargin)
if isempty(varargin)
    index=1;
else
    index=varargin{1};
end
defaultStyle=loadDefaultStyle;
if isfield(defaultStyle,fieldname)
    defaultProperties=fieldnames(defaultStyle.(fieldname));
    for aa = 1:length(defaultProperties)
        if ~isempty(strfind(lower(defaultProperties{aa}),'color')) && ~ischar(get(object,defaultProperties{aa}))
            style.(fieldname).(defaultProperties{aa})(index,:)=get(object,defaultProperties{aa});
        elseif ~isempty(strfind(lower(defaultProperties{aa}),'axes'))
            axesProperties=fieldnames(defaultStyle.(fieldname).axes);
            for aa = 1:length(axesProperties)
                style.(fieldname).axes.(axesProperties{aa})=get(gca,axesProperties{aa});
            end
            style.axes=defaultStyle.axes;%general axes properties are reverted back to default since the particular axis style of this figure will go in the axes subfield of that plot type
        elseif ~isempty(strfind(fieldname,'axes')) && ~isempty(strfind(lower(defaultProperties{aa}),'title'))
            titleProperties=fieldnames(defaultStyle.(fieldname).Title);
            for aa = 1:length(titleProperties)
                style.(fieldname).axes.(titleProperties{aa})=get(get(gca,'Title'),titleProperties{aa});
            end
        else
            if isfield(get(object),defaultProperties{aa})
                style.(fieldname).(defaultProperties{aa})=get(object,defaultProperties{aa});
            end
        end
    end
end
end