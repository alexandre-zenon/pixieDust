function pixiePanel(children,varargin)
% Arranges individual plots in several panels within a figure. 
%
% pixiePanel(children,style,labels) takes a cell array with figure names as input and arranges them in a panel. 
%   children:  cell array of length M, with M corresponding to the number
%   of rows in the panel. Within each cell, another cell array of figure
%   names indicates which plots to display in that row. 
%   style: optional pixie style. Leave empty if not wanted. 
%   labels: has to have the same size as children. Each label will be used
%   as a title for the panel
%
% Example: 
%           plot(rand(10,1),rand(10,1));
%           f1=pixieDust;
%           plot(rand(10,1),rand(10,1));
%           f2=pixieDust;
%           pixiePanel({{f1},{f2}});

if ~iscell(children)
    error('Input must be a cell array of strings')
end
style=[];
labels={};
if length(varargin)>=1
    style=varargin{1};
end
if length(varargin)==2
    labels=varargin{2};
end
if length(varargin)>2
    error('pixiePanel accepts max three arguments');
end
style=implementsDefaultStyle(style,labels,'panel');
letters=char([65:90]);

fig=figure;
afFigurePosition = style.figure.Position;
set(fig,'Units','centimeters','Position', afFigurePosition);  % [left bottom width height]
sy=length(children);
h=1/sy;
ypositions=linspace(1,0,sy+1);
ypositions=ypositions(2:end);
nextPanel=0;
for yy = 1:sy
    sx=length(children{yy});
    w=1/sx;
    xpositions=linspace(0,1,sx+1);
    for xx = 1:sx
        nextPanel=nextPanel+1;
        if isfield(style,'panel') && isfield(style.panel,'labels') && length(style.panel.label)==length(children) && length(style.panel.label{yy})==length(children{yy})
            label=style.panel.labels{yy}{xx};
        else
            lab=children{yy}{xx};
            f=strfind(lab,'/');
            if ~isempty(f)
                lab=lab(f(end)+1:end);
            end
            f=strfind(lab,'.');
            if ~isempty(f)
                lab=lab(1:f(end)-1);
            end
            label=[letters(nextPanel) '. ' lab];
        end
        pl=openfig(children{yy}{xx},'reuse','invisible');
        pnl=uipanel(fig,'Position',[xpositions(xx) ypositions(yy) w h],...
            'BorderType','none',...
            'Title',label,...
            'BackgroundColor',get(pl,'Color'),...
            'FontName',style.axes.FontName,...
            'FontSize',style.axes.FontSize,...
            'FontUnits',style.axes.FontUnits,...
            'FontWeight',style.axes.FontWeight);
        set(get(pl,'Children'),'Parent',pnl,'Units','normalized');
        close
    end
end
end