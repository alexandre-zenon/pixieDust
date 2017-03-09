function editPixieStyle(name)
% Opens matlab editor to edit style structure by hand.
%
% editPixieStyle(name)    opens the style structure with name 'name' in the editor.

currentDir=pwd;
dir=whichdir('loadPixieStyle.m');

if ispc
    parser='\';
elseif ismac
    parser='/';
else
    parser='/';
end
eval(['open(''pixieStyles.' name ''');']);

end