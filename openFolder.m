%opens folder and reads all files of specified extension. If no extension
%is specified - all files are listed
function [numOfFiles,fileList] = openFolder(destFolder,extension)

dirListing = dir(fullfile(destFolder,['*.' extension]));
%fileList=[];
numOfFiles=0;

% loop through the files and removing dirs from the list
for d = 1:length(dirListing)
    if ~dirListing(d).isdir
        numOfFiles=numOfFiles+1;
        fileList(numOfFiles,:)=dirListing(d).name;
    end % if-clause
end % for-loop

if (numOfFiles==0)
    fileList=[];
end
end