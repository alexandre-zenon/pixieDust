function colors = plotColors(h,plotType)
nextBar=0;
defaultColors=get(gca,'ColorOrder');
colors=[];
for ii = 1:length(h)
    switch plotType{ii}
        case 'shaded'
            colors(ii,:)=get(h(ii),'FaceColor');
        case 'bar'
            fc=get(h(ii),'FaceColor');
            if strcmp(fc,'flat')
                nextBar=nextBar+1;
                colors(ii,:)=defaultColors(nextBar,:);
            else
                colors(ii,:)=fc;
            end
        case 'surf'
        case 'image'
        case 'colorbar'
        otherwise
            colors(ii,:)=get(h(ii),'Color');
    end
end
end