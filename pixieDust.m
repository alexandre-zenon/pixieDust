function figFilename = pixieDust( varargin )
% Applies a style to a figure.
%
% figureFileName = pixieDust('PropertyName1',value1,'PropertyName2',value2,...)
% This function modifies the current figure according to
% the style structure, and saves it in both .eps and .fig.
% All arguments are optional.
%
% Property names:
%   - 'style': corresponding value can be either a style structure or a style filename.
%   - 'labels': corresponding value is a cell array of string. First cell is for x label, second
% cell for y label, third cell is another cell array with the
% legend strings and the fourth cell is the legend title.
%   - 'filename': corresponding value is a string indicating the filename
%   of the figure.
%
% See loadDefaultStyle function for a list of style fields.
%
% Example: pixieDust('style',myStyle, 'filename','/User/bibi/newFigures/figure3.eps', 'labels',{'Time
% (s)', 'Amplitude (mV)',{'10 Hz','20 Hz'},'Frequency'});



%% INITIALIZE
[style,filename]=initializeVariables(varargin,nargin);

%% FIGURE STYLE
appliesStyle(style,'figure',gcf,[]);

%% AXES STYLE
figAxes=get(gcf,'Children');% takes each axis one by one
lgd=[];
for figAxis = figAxes'
    if strcmp(get(figAxis,'Tag'),'legend')
        lgd=figAxis;
    else
        set(gcf, 'CurrentAxes', figAxis);
        appliesStyle(style,'axes',gca,[]);
        appliesStyle(style,'labels',gca,[]);%axis handle is given for labels so as to allow the function to access both x and y labels
        
        %% changes each individual plot
        [children,plotType,plot2Label,xdata,ydata,colData,minX,maxX]=changesDataPlot(figAxis,style);
        
        %% ADDS LEGEND IF NEEDED %%
        lgd=addsLegend(style,plot2Label,lgd);
        
        %% ADDS REGRESSION LINE TO SCATTER PLOT IF NEEDED %%
        addsRegressionLine(plotType,style,xdata,ydata,colData);
        
        %% ADAPTS AXIS LENGTH AND X TICKS FOR BAR PLOTS %%
        adaptsAxes(children,plotType,figAxis,minX,maxX,lgd);
    end
end
set(gcf,'PaperPositionMode','auto');

%% SAVES FIGURE %%
figFilename=saveCurrentFigure(filename);

end







function [style,filename]=initializeVariables(arguments,narg)
style = struct;
labels={};
filename='untitled';
if narg/2 == round(narg/2)
    for args = 1:2:narg
        switch arguments{args}
            case 'style'
                if isstruct(arguments{args+1})
                    style=arguments{args+1};
                elseif isstr(arguments{args+1})
                    style=loadPixieStyle(arguments{args+1});
                else
                    error('Invalid style argument');
                end
            case 'labels'
                if iscell(arguments{args+1})
                    labels=arguments{args+1};
                else
                    error('Invalid labels argument');
                end
            case 'filename'
                if isstr(arguments{args+1})
                    filename=arguments{args+1};
                    if isempty(findstr('.eps',filename))
                        filename=[filename '.eps'];
                    end
                    if ~ispc
                        if isempty(findstr('/',filename))
                            filename=[pwd '/' filename];
                        end
                    else
                        if isempty(findstr('\',filename))
                            filename=[pwd '\' filename];
                        end
                    end
                else
                    error('Invalid filename argument');
                end
        end
    end
else
    error('Invalid number of arguments');
end

set(gcf,'Units','centimeters');

style=implementsDefaultStyle(style,labels);
end


