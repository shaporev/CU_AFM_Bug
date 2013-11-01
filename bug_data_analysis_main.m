%% The main script file for IGOR AFM data acquisition and analysis
%Created by Aleksey Shaporev, Clemson University
%(c) November 1, 2013


%% major parameters init
varStruct=struct('currentDir', '', ...     %current dir
                   'currentFile',  '', ...          %current file
                   'numOfFiles', 0, ...                    %number of files in the list
                   'currentFileNum',0 ...          %number of current file in the list
                );
targetExtension='ibw';
varStruct.currentDir=pwd;
varStruct.currentFile='';
varStruct.currentFileNum=0;
varStruct.numOfFiles=0;


[numOfFilesReceived,fileList]=openFolder(varStruct.currentDir,targetExtension);   %this loads the list of files with suitable extension
if (numOfFilesReceived>0)       %if any files found
    varStruct.currentFileNum=1;
    varStruct.currentFile=fileList(varStruct.currentFileNum,:);
    varStruct.numOfFiles=numOfFilesReceived;
else                    %no files found
    varStruct.currentFileNum=0;
    varStruct.currentFile='';
    varStruct.numOfFiles=0;    
end

%% GUI initialization 
varSendToGUI=varStruct;                                  
                              
                              
%% main cycle

% the model of the program:
% GUI hold control for while no user interaction is recorded
% as soon as user interacted with GUI, it returns to the main file
% the main file then analyzes user's actions,
% performs necessary response
% and send updated information back into GUI
                              
while (1)
    varReceivedFromGUI=GUI(varSendToGUI);
    %response received from GUI, checking for what has changed:
    
    %if working dir has changed, everything has to be reloaded
    if (~strcmp(varReceivedFromGUI.currentDir,varStruct.currentDir))
        varStruct.currentDir=varReceivedFromGUI.currentDir;
        [numOfFilesReceived,fileList]=openFolder(varStruct.currentDir,targetExtension);   %this loads the list of files with suitable extension
        if (numOfFilesReceived>0)       %if any files found
            varStruct.currentFileNum=1;
            varStruct.currentFile=fileList(varStruct.currentFileNum,:);
            varStruct.numOfFiles=numOfFilesReceived;
            %TODO: load corresponding data into graph
        else                    %no files found
            varStruct.currentFileNum=0;
            varStruct.currentFile='';
            varStruct.numOfFiles=0;
        end
    %checking whether file number has changed    
    elseif (varReceivedFromGUI.currentFileNum~=varStruct.currentFileNum)
        varStruct.currentFileNum=varReceivedFromGUI.currentFileNum;
        varStruct.currentFile=fileList(varStruct.currentFileNum,:);
        %TODO: reload corresponding graph
    end
    
    varSendToGUI=varStruct;
end



