function savePixieStyle(style,filename)
% Saves style structure. 
%
% savePixieStyle(style,filename)    saves the style structure in a file with
% name 'filename'. These files are located in the +pixieStyles
% subdirectory. 

dir=whichdir('savePixieStyle.m');

if ispc
    parser='\';
elseif ismac
    parser='/';
else
    parser='/';
end

f=strfind(filename,'.');
if ~isempty(f)
    filename=filename(1:f(end)-1);
end

styleName=[dir '+pixieStyles' parser filename];

%save(styleName,'style');
fid = fopen([styleName '.m'],'wt');
fprintf(fid,['function style = ' filename '()\n']);
printPixieStyle(fid,style)
fprintf(fid,'end');
fclose(fid);

end