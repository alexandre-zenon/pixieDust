function pixiePanel(children,varargin)
% Arranges individual plots in several panels within a figure.
%
% pixiePanel(children,figSize,panelPositions,style,labels) takes a cell array with figure names as input and arranges them in a panel.
%   children:  cell array of length M, with M corresponding to the number
%   of rows in the panel.
%   figSize: optional [r c] vector with r being the number of rows and c the number
%   of columns in the figure. Each panel can occupy several rows and/or
%   columns
%   panelPositions: optional cell array of length M (cfr. children), with each cell
%   containing a 4x1 vector [upperRow upperColumn lowerRow lowerColumn]
%   which defines the position of the panel. The panel will then extend
%   from uppeRow, upperColumn to lowerRown, lowerColumn.
%   style: optional pixie style. Leave empty if not wanted.
%   labels: has to have the same size as children. Each label will be used
%   as a title for the panel
%
% Example:
%           plot(rand(10,1),rand(10,1));f1=pixieDust;close
%           plot(rand(10,1),rand(10,1));f2=pixieDust;close
%           plot(rand(10,1),rand(10,1));f3=pixieDust;close
%           plot(rand(10,1),rand(10,1));f4=pixieDust;close
%           pixiePanel({f1,f2,f3,f4},[3 4],{[1 1 3 2],[1 3 1 4],[2 3 2 4],[3 3 3 4]});

if ~iscell(children)
    error('Input must be a cell array of strings')
end
style=[];
labels={};
figSize=[length(children) 1];
for ii = 1:length(children)
    panelPositions{ii}=[ii 1 ii 1];
end
if length(varargin)>=1
    figSize=varargin{1};
end
if length(varargin)>=2
    panelPositions=varargin{2};
end
if length(varargin)>=3
    style=varargin{3};
end
if length(varargin)==4
    labels=varargin{4};
end
if length(varargin)>4
    error('pixiePanel accepts max three arguments');
end
style=implementsDefaultStyle(style,labels,'panel');
letters=char([65:90]);

fig=figure;
afFigurePosition = style.figure.Position;
set(fig,'Units','centimeters','Position', afFigurePosition);  % [left bottom width height]

N=length(children);
sy=figSize(1);
sx=figSize(2);
ypositions=linspace(1,0,sy+1);
xpositions=linspace(0,1,sx+1);
pnlMargin=0;

nextPanel=0;
for pn = 1:N
    nextPanel=nextPanel+1;
    if isfield(style,'panel') && isfield(style.panel,'labels') && length(style.panel.labels)==length(children) && length(style.panel.labels{pn})==length(children{pn})
        label=style.panel.labels{pn};
    else
        lab=children{pn};
        f=union(strfind(lab,'/'),strfind(lab,'\'));
        if ~isempty(f)
            lab=lab(f(end)+1:end);
        end
        f=strfind(lab,'.');
        if ~isempty(f)
            lab=lab(1:f(end)-1);
        end
        %label=[letters(nextPanel) '. ' lab];
        label=[letters(nextPanel) '. '];
    end
    %pl=openfig(children{pn},'reuse','invisible');
    pl=openfig(children{pn});
    xx=panelPositions{pn}(2);
    yy=panelPositions{pn}(1);
    xx2=panelPositions{pn}(4)+1;
    yy2=panelPositions{pn}(3)+1;
    xpos=xpositions(xx);
    ypos=ypositions(yy2);
    w=xpositions(xx2)-xpos;
    h=ypositions(yy)-ypos;
    pnl=uipanel(fig,'Position',[xpos+pnlMargin ypos+pnlMargin w-pnlMargin*2 h-pnlMargin*2],...
        'BorderType','none',...
        'Title',label,...
        'BackgroundColor',get(pl,'Color'),...
        'FontName',style.axes.FontName,...
        'FontSize',style.axes.FontSize,...
        'FontUnits',style.axes.FontUnits,...
        'FontWeight',style.axes.FontWeight);
    
    axisMargin=.1;
    set(get(pl,'Children'),'Parent',pnl,'Units','normalized','OuterPosition',[0 axisMargin 1 1-axisMargin]);
    close
end
end