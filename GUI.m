function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
handles.inputData=varargin{1};


% Update handles structure
guidata(hObject, handles);

%check whether something should be done accordingly to received parameters
set(handles.dirText,'String',handles.inputData.currentDir);
set(handles.fileText,'String',handles.inputData.currentFile);
if (handles.inputData.currentFileNum<=1)      %should not be possible to go to previous file
    set(handles.prevButton,'Enable','off');
else
    set(handles.prevButton,'Enable','on');
end

if (handles.inputData.currentFileNum>=handles.inputData.numOfFiles)      %should not be possible to go to next file
    set(handles.nextButton,'Enable','off');
else
    set(handles.nextButton,'Enable','on');
end

if (handles.inputData.currentFileNum==0)      %no files found - no navigation must be available
    set(handles.nextButton,'Enable','off');
    set(handles.prevButton,'Enable','off');
end

%TODO: add graph to show

% UIWAIT makes GUI wait for user response (see UIRESUME)
 uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
varargout{1}=handles.inputData;
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over fileText.
function fileText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to fileText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end
% --- Executes on button press in prevButton.
function prevButton_Callback(hObject, eventdata, handles)
% hObject    handle to prevButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%if button was pressed - it means that there is still where to move back
handles.inputData.currentFileNum=handles.inputData.currentFileNum-1;
guidata(hObject, handles);
%send signal to outer function
uiresume(handles.figure1);

end

% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%if button was pressed - it means that there is still where to move forward
handles.inputData.currentFileNum=handles.inputData.currentFileNum+1;
guidata(hObject, handles);
%send signal to outer function
uiresume(handles.figure1);

end


% --- Executes on button press in dirText.
function dirText_Callback(hObject, eventdata, handles)
% hObject    handle to dirText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    disp('Dir change button pressed...');
    folder_name = uigetdir(get(handles.dirText,'String'),'Select IGOR data folder');
    if (folder_name==0)     %checking whether user selected a folder or not
        disp('No folder selected');
        return;
    end
    if (strcmp(folder_name,get(handles.dirText,'String')))  %checking whether the folder changed or not
        %folder unchanged, no action required
        disp(['Folder not changed. The folder is: ',folder_name]);
    else
        %folder changed
        disp(['Folder changed to: ',folder_name]);
        set(handles.dirText,'String',folder_name);
        handles.inputData.currentDir=folder_name;
        guidata(hObject, handles);
        %send signal to outer function
        uiresume(handles.figure1);
    end

    
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
