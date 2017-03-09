function appliesStyle(style,fieldname,object,index)
if strcmp(get(object,'Tag'),'Colorbar')
    if isfield(style,'colorbar') && isfield(style.colorbar,fieldname)
        styl=style.colorbar.(fieldname);
    else
        return
    end
else
    if isfield(style,fieldname)
        styl=style.(fieldname);
    else
        return
    end
end
properties=fieldnames(styl);
if strcmp(fieldname,'labels')
    xObject=get(object,'XLabel');
    yObject=get(object,'YLabel');
    zObject=get(object,'ZLabel');
    if isempty(get(xObject,'String'))
        safeSet(xObject,'String', styl,'XLabel');
    end
    if isempty(get(yObject,'String'))
        safeSet(yObject,'String', styl,'YLabel');
    end
    if isempty(get(zObject,'String'))
        safeSet(zObject,'String', styl,'ZLabel');
    end

    for aa = 1:length(properties)
        if isempty(strfind(properties{aa},'LabelRotation')) & isempty(strfind(properties{aa},'Label'))
            if ~isempty(strfind(lower(properties{aa}),'color')) && ~isempty(index)
                safeSet(xObject,properties{aa},styl,properties{aa},index);
                safeSet(yObject,properties{aa},styl,properties{aa},index);
                safeSet(zObject,properties{aa},styl,properties{aa},index);
            elseif ~isempty(strfind(lower(properties{aa}),'color')) && isempty(index)
                safeSet(xObject,properties{aa},styl,properties{aa},1);
                safeSet(yObject,properties{aa},styl,properties{aa},1);
                safeSet(zObject,properties{aa},styl,properties{aa},1);
            else
                safeSet(xObject,properties{aa},styl);
                safeSet(yObject,properties{aa},styl);
                safeSet(zObject,properties{aa},styl);
            end
        elseif ~isempty(strfind(properties{aa},'XLabelRotation')) 
            safeSet(xObject,'Rotation',styl,properties{aa});
        elseif ~isempty(strfind(properties{aa},'YLabelRotation')) 
            safeSet(yObject,'Rotation',styl,properties{aa});
        elseif ~isempty(strfind(properties{aa},'ZLabelRotation'))
            safeSet(zObject,'Rotation',styl,properties{aa});
        end
    end

elseif strcmp(fieldname,'axes')
    for aa = 1:length(properties)
        if ~isempty(strfind(lower(properties{aa}),'color'))
            if ~isempty(strfind(lower(properties{aa}),'color')) && ~isempty(index)
                safeSet(object,properties{aa},styl,properties{aa},index);
            elseif isempty(strfind(lower(properties{aa}),'color')) && ~isempty(index)
                safeSet(object,properties{aa},styl);
            end
        elseif ~isempty(strfind(lower(properties{aa}),'title'))
            propertiesTitle=fieldnames(styl.Title);
            for aa = 1:length(propertiesTitle)
                safeSet(get(gca,'Title'),propertiesTitle{aa},styl.Title);
            end
        else
            safeSet(object,properties{aa},styl);
        end
    end
else
    for aa = 1:length(properties)
        if ~isempty(strfind(lower(properties{aa}),'color'))
            if ischar(styl.(properties{aa}))
                safeSet(object,properties{aa},styl);
            else
                if ~isempty(strfind(lower(properties{aa}),'color')) && ~isempty(index)
                    safeSet(object,properties{aa},styl,properties{aa},index);
                elseif isempty(strfind(lower(properties{aa}),'color')) && ~isempty(index)
                    safeSet(object,properties{aa},styl);
                end
            end
        elseif ~isempty(strfind(lower(properties{aa}),'axes'))
            propertiesAxes=fieldnames(styl.axes);
            for aa = 1:length(propertiesAxes)
                safeSet(gca,propertiesAxes{aa},styl.axes);
            end
        else
            safeSet(object,properties{aa},styl);
        end
    end
end
end

function err = safeSet(object,property,valueStruct,varargin)
err=false;
if isempty(varargin)
    indexing=NaN;
    valueField=property;
elseif length(varargin)==1
    valueField=varargin{1};
    indexing=NaN;
elseif length(varargin)==2
    valueField=varargin{1};
    indexing=varargin{2};
end
if isfield(get(object),property)
    if isfield(valueStruct,valueField)
        if ~any(isnan(indexing))
            set(object,property,valueStruct.(valueField)(indexing,:));
        else
            set(object,property,valueStruct.(valueField));
        end
    else
        err=true;
        %valueStruct
        %disp(['Invalid valueField: ' valueField])
    end
else
    err=true;
%     get(object)
%     disp(['Invalid property: ' property])
end
end