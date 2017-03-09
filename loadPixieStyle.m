function style=loadPixieStyle(filename)
% Loads style structure.
%
% loadPixieStyle(filename)    loads the style structure from the file with
% name 'filename' and provides it as an output. These files are located in the +pixieStyles
% subdirectory. 

currentDir=pwd;
dir=whichdir('loadPixieStyle.m');

if ispc
    parser='\';
elseif ismac
    parser='/';
else
    parser='/';
end

eval(['style = pixieStyles.' filename ';']);

end