function dataTable=arff2table(arff_filelocation)

content = fileread(arff_filelocation);
tmp = extractBetween(content,'@relation','@data')
tmpa = strsplit(tmp{1}, '@attribute');
tmpa(1)=[];
varnames=[];
for i=1:numel(tmpa)
    tmpa{i}=strtrim(tmpa{i});
    tmpab{i} = strsplit(tmpa{i}, ' ');
    for j=1:2
        tmpab{i}{j}=strtrim(tmpab{i}{j});
    end
end
varnames=[];
for j=1:numel(tmpab)
    varnames=[varnames,tmpab{j}{1}];
    if j<numel(tmpab)
        varnames=[varnames,','];
    end
end
tmp = strsplit(content,'@data');
tmp=tmp{2};

csv_filelocation = strrep(arff_filelocation, '.arff', '.csv');

fileID = fopen(csv_filelocation, 'w');
fprintf(fileID, '%s%s', varnames,tmp);
fclose(fileID);

dataTable=readtable (csv_filelocation);
