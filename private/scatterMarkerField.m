function [subfield,fieldIndex]=scatterMarkerField(cc)
subfield=[];
fieldIndex=0;
if isfield(get(cc),'Marker')
    switch get(cc,'Marker')
        case 'o'
            subfield='circle';
            fieldIndex=1;
        case '.'
            subfield='point';
            fieldIndex=2;
        case '*'
            subfield='star';
            fieldIndex=3;
        case 'x'
            subfield='xmark';
            fieldIndex=4;
        case '+'
            subfield='plus';
            fieldIndex=5;
        case 'square'
            subfield='square';
            fieldIndex=6;
        case 'diamond'
            subfield='diamond';
            fieldIndex=7;
        case 'v'
            subfield='tridown';
            fieldIndex=8;
        case '^'
            subfield='triup';
            fieldIndex=9;
        case '<'
            subfield='trileft';
            fieldIndex=10;
        case '>'
            subfield='triright';
            fieldIndex=11;
    end
end