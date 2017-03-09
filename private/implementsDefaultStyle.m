function style = implementsDefaultStyle(style,labels,varargin)

if length(varargin)==0
    labelType='axes';
elseif length(varargin)==1
    labelType=varargin{1};
else
    error('Too many arguments');
end

if ~isstruct(style) && isempty(style)
    style=struct;
end
defaultStyle=loadDefaultStyle;
fn = fieldnames(defaultStyle);
for ff = 1:length(fn)
    if ~isfield(style,fn{ff})
        style.(fn{ff})=defaultStyle.(fn{ff});
    end
end
if isfield(style,'cLabel')
    for ii = 1:length(style.cValues)
        if ~ischar(style.cValues)
            style.colorLabel{ii}=[style.cLabel ' - ' num2str(style.cValues(ii))];
        else
            style.colorLabel{ii}=[style.cLabel ' - ' (style.cValues(ii))];
        end
    end
end
switch labelType
    case 'axes'
        if ~isempty(labels)
            style.axes.XLabel                    =   labels{1};
            if length(labels)>1
                style.axes.YLabel                =   labels{2};
            end
            if length(labels)>2
                style.legend.colorLabel          =   labels{3};
            end
            if length(labels)>3
                style.legend.cLabel          =   labels{4};
            end
        end
    case 'panel'
        if ~isempty(labels)
            style.panel.labels                   =   labels;
        end
end
end