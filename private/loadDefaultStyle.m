function defaultStyle = loadDefaultStyle

%% FIGURE PROPERTIES %%
defaultColors=[0 0 1; 0 0.5 0; 1 0 0; 0 0.75 0.75; 0.75 0 0.75; 0.75 0.75 0; 0.25 0.25 0.25];
set(0,'units','centimeters');
screenSize=get(0,'screensize');
screenW=screenSize(3);
screenH=screenSize(4);
defaultStyle.figure.Position                =   [screenW*1/20 screenH*1/20 screenW*9/10 screenH*9/10];
defaultStyle.figure.ColorMap                =   hsv2rgb([linspace(0,0.6,64)' ones(64,1)*.8 ones(64,1)*.9]);

%% AXES PROPERTIES %%

defaultStyle.axes.XGrid                     = 'off';
defaultStyle.axes.YGrid                     = 'off';
defaultStyle.axes.GridLineStyle             = ':';
defaultStyle.axes.XMinorGrid                = 'off';
defaultStyle.axes.YMinorGrid                = 'off';
defaultStyle.axes.MinorGridLineStyle        = ':';
defaultStyle.axes.XMinorTick                = 'off';
defaultStyle.axes.YMinorTick                = 'off';
defaultStyle.axes.TickDir                   = 'out';
defaultStyle.axes.XAxisLocation             = 'bottom';
defaultStyle.axes.YAxisLocation             = 'left';
defaultStyle.axes.XDir                      = 'normal';
defaultStyle.axes.YDir                      = 'normal';
defaultStyle.axes.Box                       = 'off';
defaultStyle.axes.LineWidth                 = 2 ;
defaultStyle.axes.ActivePositionProperty    = 'outerposition';
defaultStyle.axes.Units                     = 'normalized';
    
defaultStyle.axes.FontSize                  =   20;
defaultStyle.axes.FontName                  =   'Arial';  % [Times | Courier | ]
defaultStyle.axes.FontWeight                =   'normal'; % [light | {normal} | demi | bold]
defaultStyle.axes.FontUnits                 =   'points'; % [{points} | normalized | inches | centimeters | pixels]
defaultStyle.axes.FontAngle                 =   'normal'; % [{normal} | italic | oblique]     ps: only for axes

defaultStyle.axes.Title.FontSize            =   24;
defaultStyle.axes.Title.FontName            =   'Arial';  % [Times | Courier | ]
defaultStyle.axes.Title.FontWeight          =   'bold'; % [light | {normal} | demi | bold]
defaultStyle.axes.Title.FontUnits           =   'points'; % [{points} | normalized | inches | centimeters | pixels]
defaultStyle.axes.Title.FontAngle           =   'normal'; % [{normal} | italic | oblique]     ps: only for axes

defaultStyle.axes.LineWidth                 =   2.0;      % width of the line of the axes
defaultStyle.axes.TickLength                =   [.02 .02];% length of the ticks
defaultStyle.axes.XColor                    =   [.1 .1 .1];% color of x axis
defaultStyle.axes.YColor                    =   [.1 .1 .1];% color of y axis

defaultStyle.labels.FontSize                  =   defaultStyle.axes.FontSize;
defaultStyle.labels.FontName                  =   defaultStyle.axes.FontName; 
defaultStyle.labels.FontWeight                =   defaultStyle.axes.FontWeight; 
defaultStyle.labels.FontUnits                 =   defaultStyle.axes.FontUnits; 
defaultStyle.labels.FontAngle                 =   defaultStyle.axes.FontAngle;
defaultStyle.labels.XLabel                    =   'label of x axis';
defaultStyle.labels.YLabel                    =   'label of y axis';
defaultStyle.labels.ZLabel                    =   'label of z axis';
defaultStyle.labels.Interpreter            =   'latex';  % [{tex} | latex]
%defaultStyle.labels.fXLabelRotation           =   0.0;
%defaultStyle.labels.fYLabelRotation           =   90.0;
%defaultStyle.labels.fZLabelRotation           =   90.0;
%defaultStyle.axes.Position                  =   [0.2 0.2 0.75 0.7];

%% LEGEND PROPERTIES %%
defaultStyle.legend.addDefault              =   false;%if true adds legend to plots lacking one
defaultStyle.legend.colorLabel              =   {};

%% COLORBAR PROPERTIES %%
% colorbar axes
defaultStyle.colorbar.axes.Location         = 'EastOutside';
defaultStyle.colorbar.labels.YLabel            = 'Color label';
defaultStyle.colorbar.labels.fYLabelRotation    = 270;
defaultStyle.colorbar.labels.FontSize                  =   defaultStyle.axes.FontSize;
defaultStyle.colorbar.labels.FontName                  =   defaultStyle.axes.FontName; 
defaultStyle.colorbar.labels.FontWeight                =   defaultStyle.axes.FontWeight; 
defaultStyle.colorbar.labels.FontUnits                 =   defaultStyle.axes.FontUnits; 
defaultStyle.colorbar.labels.FontAngle                 =   defaultStyle.axes.FontAngle;
defaultStyle.colorbar.labels.VerticalAlignment      = 'bottom';
% % colorbar images
defaultStyle.colorbar.AlphaDataMapping      =   'none';

%% TYPES OF PLOTS %%
%BARS
defaultStyle.bar.FaceColor                  =   pastel(defaultColors);
defaultStyle.bar.EdgeColor                  =   dark(defaultColors);
defaultStyle.bar.LineWidth                  =   2;
defaultStyle.bar.errorBar.width             =   3;
defaultStyle.bar.errorBar.color             =   [0 0 0];
%LINES
defaultStyle.line.LineWidth                 =   2;
defaultStyle.line.color                     =   pastel(defaultColors);
%REGRESSION LINES
defaultStyle.regressionLine.LineWidth       =   2;
%ERRORBARS
defaultStyle.errorBar.width                 =   1;% multiplies current width of error bar => 1 doesn't change the width of the error bar
defaultStyle.errorBar.LineWidth             =   2.5;
defaultStyle.errorBar.color                 =   pastel(defaultColors);
%SHADED
defaultStyle.shaded.LineWidth               =   2;
defaultStyle.shaded.FaceColor               =   pastel(defaultColors);
defaultStyle.shaded.EdgeColor               =   dark(defaultColors);
%SCATTER
defaultStyle.scatter.Marker                 =   'o';
defaultStyle.scatter.MarkerSize             =   6;
defaultStyle.scatter.MarkerFaceColor        =   pastel(defaultColors);
defaultStyle.scatter.MarkerEdgeColor        =   dark(defaultColors);
%SURF
defaultStyle.surf.FaceColor                 =   'texturemap';
defaultStyle.surf.EdgeColor                 =   'none';
defaultStyle.surf.FaceLighting              =   'gouraud';
defaultStyle.surf.axes.XGrid                = 'on';
defaultStyle.surf.axes.YGrid                = 'on';
defaultStyle.surf.axes.ZGrid                = 'on';
defaultStyle.surf.axes.GridLineStyle        = '-';
defaultStyle.surf.axes.LineWidth            = 1 ;

%IMAGES
defaultStyle.image.AlphaDataMapping         =   'none';
defaultStyle.image.axes.TickDir             = 'in';
defaultStyle.image.axes.Box                 = 'on';
defaultStyle.image.axes.LineWidth           = 1 ;
%defaultStyle.image.axes.Position            =   [0.1 0.1 0.8 0.8];

%% OPTIONS
defaultStyle.regressionLineOption           =   true;
savePixieStyle(defaultStyle,'default');
end
