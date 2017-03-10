function figFilename=saveCurrentFigure(filename)
MAXINDEX=20;% maximum number of figures in the fifo buffer

figdir=whichdir('pixieDust');
epsdir=pwd;

if ~isempty(strfind(filename,'.'))
    f=strfind(filename,'.');
    filename=filename(1:f(end)-1);
end
if ispc
    figdir=[figdir 'tmpFigures\'];
    epsdir=[epsdir '\'];
    if ~exist(figdir,'dir')
        mkdir(figdir)
    end
else
    figdir=[figdir 'tmpFigures/'];
    epsdir=[epsdir '/'];
    if ~exist(figdir,'dir')
        mkdir(figdir)
    end
end
if exist([figdir 'currentFigIndex.mat'],'file')
    load([figdir 'currentFigIndex.mat']);
    currentFigIndex=currentFigIndex+1;
    if currentFigIndex>MAXINDEX
        currentFigIndex=1;
    end
    save([figdir 'currentFigIndex.mat'],'currentFigIndex');
else
    currentFigIndex=1;
    save([figdir 'currentFigIndex.mat'],'currentFigIndex');
end

figFilename='fig';
figFilename=[figdir figFilename num2str(currentFigIndex) '.fig'];

if isempty(strfind(filename,'/')) && isempty(strfind(filename,'\'))
    epsFilename=[epsdir filename '.eps'];
else
    epsFilename=[filename '.eps'];
end

shg

saveas(gcf,figFilename);

ATTEMPTS_LIMIT=10;
attempts=0;
success=0;
while ~success && attempts<ATTEMPTS_LIMIT
    try
        print('-depsc2', epsFilename)
        disp(['Figure saved as ' epsFilename]);
        success=1;
    catch
        attempts=attempts+1;
        pause(.5);
    end
end
if ~success
    error('Unable to save the figure');
end
end
