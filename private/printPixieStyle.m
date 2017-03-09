function printPixieStyle(fid,style)
browseFields(fid,style,'style');
end


function browseFields(fid,struc,baseName)
tabLength=4;% number of characters per tab: 8 for screen output, 4 for editor
totalTabDist=10;% final distance of structures values in tabs
fields=fieldnames(struc);
for ff = 1:length(fields)
    f=struc.(fields{ff});
    bn=[baseName '.' fields{ff}];
    structNameLength=(length(bn))+3;%3 corresponds to addition of " = "
    bnTabNum=floor((structNameLength)/tabLength)+1;%distance of first tab after structure name. 
    totalTabNum=totalTabDist-bnTabNum;
    tab=repmat('\t',1,totalTabNum+1);
    if isstruct(f)
        browseFields(fid,f,bn);
    else
        if isnumeric(f)
            if isvector(f)
                fprintf(fid,[bn ' = ' tab '[' num2str(f) '];\n']);
            else
                if length(size(f))==2
                    fprintf(fid,[bn ' = ' tab '[' num2str(f(1,:)) ';...\n']);
                    for rr = 2:size(f,1)-1
                        fprintf(fid,[repmat('\t',1,totalTabDist) num2str(f(rr,:)) ';...\n']);
                    end
                    fprintf(fid,[repmat('\t',1,totalTabDist) num2str(f(end,:)) '];\n']);
                else
                    error([bn ' is a matrix of more than 2 dimensions. We cannot handle this type of data.']);
                end
            end
        elseif ischar(f)
            fprintf(fid,[bn ' = ' tab '''' f ''';\n']);
        elseif islogical(f)
            if f
                fprintf(fid,[bn ' = ' tab 'true;\n']);
            else
                fprintf(fid,[bn ' = ' tab 'false;\n']);
            end
        end
    end
end
end