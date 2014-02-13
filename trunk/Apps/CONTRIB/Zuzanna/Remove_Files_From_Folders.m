function varargout = Remove_Files_From_Folders(varargin)
% REMOVE_FILES_FROM_FOLDERS M-file for Remove_Files_From_Folders.fig
%      REMOVE_FILES_FROM_FOLDERS, by itself, creates a new REMOVE_FILES_FROM_FOLDERS or raises the existing
%      singleton*.
%
%      H = REMOVE_FILES_FROM_FOLDERS returns the handle to a new REMOVE_FILES_FROM_FOLDERS or the handle to
%      the existing singleton*.
%
%      REMOVE_FILES_FROM_FOLDERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_FILES_FROM_FOLDERS.M with the given input arguments.
%
%      REMOVE_FILES_FROM_FOLDERS('Property','Value',...) creates a new REMOVE_FILES_FROM_FOLDERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_Files_From_Folders_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_Files_From_Folders_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_Files_From_Folders

% Last Modified by GUIDE v2.5 07-Feb-2013 11:24:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_Files_From_Folders_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_Files_From_Folders_OutputFcn, ...
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


% --- Executes just before Remove_Files_From_Folders is made visible.
function Remove_Files_From_Folders_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_Files_From_Folders (see VARARGIN)

% Choose default command line output for Remove_Files_From_Folders
handles.output = hObject;



% UIWAIT makes Remove_Files_From_Folders wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

    set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai27_Pje');
    handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai27_Pje';

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.FilenameEnd,'String',Settings.FilenameEndString);
    set(handles.FilenameExtension,'String',Settings.FilenameExtensionString);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    handles.Path=Settings.Path;
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Remove_Files_From_Folders_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.PathForLoadingString=get(handles.PathForLoading,'String');
Settings.Path=handles.Path;
Settings.FilenameEndString=get(handles.FilenameEnd,'String');
Settings.FilenameExtensionString=get(handles.FilenameExtension,'String');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData


%%%%%%%%%%%%%

filenameend=get(handles.FilenameEnd,'String');
filenameextension=get(handles.FilenameExtension,'String');

% get list of folders (one per binsize and start point)
allfolders=dir(handles.Path);
nbdirs=length(allfolders);

for i=3:nbdirs %loop over folders (first 2 are '.' and '..')
    
    toremove=[handles.Path '\' allfolders(i).name '\*' filenameend filenameextension];
    
    delete(toremove);
    
end



% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;



% --- Executes on button press in SetPath.
function SetPath_Callback(hObject, eventdata, handles)
% hObject    handle to SetPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Oldpath=cd;

cd(handles.Path);

% Open directory interface
NewPath=uigetdir(handles.Path);

cd(Oldpath);

% If "Cancel" is selected then return
if isequal(NewPath,0)
    return
else
    handles.Path=NewPath;
    set(handles.PathForLoading,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end



function FilenameEnd_Callback(hObject, eventdata, handles)
% hObject    handle to FilenameEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilenameEnd as text
%        str2double(get(hObject,'String')) returns contents of FilenameEnd as a double


% --- Executes during object creation, after setting all properties.
function FilenameEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilenameEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function FilenameExtension_Callback(hObject, eventdata, handles)
% hObject    handle to FilenameExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilenameExtension as text
%        str2double(get(hObject,'String')) returns contents of FilenameExtension as a double


% --- Executes during object creation, after setting all properties.
function FilenameExtension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilenameExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
