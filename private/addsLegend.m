function lgd=addsLegend(style,plot2Label,lgd)

if isfield(style,'legend') && isfield(style.legend,'addDefault') && islogical(style.legend.addDefault)
    addLegend = style.legend.addDefault;
else
    addLegend = false;
end
if addLegend
    if ~isempty(style.legend.colorLabel)
        lgd=legend(plot2Label,style.legend.colorLabel);
        title(lgd,style.legend.cLabel);
    elseif exist('plot2Label') && length(plot2Label)>1
        for ii = 1:length(plot2Label)
            colorLabel{ii}=['plot ' num2str(ii)];
        end
        lgd=legend(plot2Label,colorLabel);
        title(lgd,'Legend label');
    end
end
end