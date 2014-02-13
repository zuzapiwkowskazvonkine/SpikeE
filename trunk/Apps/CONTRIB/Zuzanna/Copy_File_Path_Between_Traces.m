function varargout = Copy_File_Path_Between_Traces(varargin)
% COPY_FILE_PATH_BETWEEN_TRACES MATLAB code for Copy_File_Path_Between_Traces.fig
%      COPY_FILE_PATH_BETWEEN_TRACES, by itself, creates a new COPY_FILE_PATH_BETWEEN_TRACES or raises the existing
%      singleton*.
%
%      H = COPY_FILE_PATH_BETWEEN_TRACES returns the handle to a new COPY_FILE_PATH_BETWEEN_TRACES or the handle to
%      the existing singleton*.
%
%      COPY_FILE_PATH_BETWEEN_TRACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COPY_FILE_PATH_BETWEEN_TRACES.M with the given input arguments.
%
%      COPY_FILE_PATH_BETWEEN_TRACES('Property','Value',...) creates a new COPY_FILE_PATH_BETWEEN_TRACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Copy_File_Path_Between_Traces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Copy_File_Path_Between_Traces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Copy_File_Path_Between_Traces

% Last Modified by GUIDE v2.5 25-Oct-2012 17:36:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Copy_File_Path_Between_Traces_OpeningFcn, ...
                   'gui_OutputFcn',  @Copy_File_Path_Between_Traces_OutputFcn, ...
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


% --- Executes just before Copy_File_Path_Between_Traces is made visible.
function Copy_File_Path_Between_Traces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Copy_File_Path_Between_Traces (see VARARGIN)

% Choose default command line output for Copy_File_Path_Between_Traces
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Copy_File_Path_Between_Traces wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.CopyFile,'Value',Settings.CopyFileValue);
    set(handles.CopyPath,'Value',Settings.CopyPathValue);
end

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace2{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);
end

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.TraceSelector2String=get(handles.TraceSelector2,'String');
Settings.TraceSelector2Value=get(handles.TraceSelector2,'Value');
Settings.CopyFileValue=get(handles.CopyFile,'Value');
Settings.CopyPathValue=get(handles.CopyPath,'Value');

% --- Outputs from this function are returned to the command line.
function varargout = Copy_File_Path_Between_Traces_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'hFigImage')
    if (ishandle(handles.hFigImage))
        delete(handles.hFigImage);
    end
end
uiresume;

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TargetTraces=get(handles.TraceSelector,'Value');
TraceWithInfo=get(handles.TraceSelector2,'Value');

cpf=get(handles.CopyFile,'Value');
cpp=get(handles.CopyPath,'Value');

for k=TargetTraces
    
    if cpf
        SpikeTraceData(k).Filename=SpikeTraceData(TraceWithInfo).Filename;
    end
    
    if cpp
        SpikeTraceData(k).Path=SpikeTraceData(TraceWithInfo).Path;
    end
    
end
    



ValidateValues_Callback(hObject, eventdata, handles)






% --- Executes on selection change in TraceSelector.
function TraceSelector_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector


% --- Executes during object creation, after setting all properties.
function TraceSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelector2.
function TraceSelector2_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector2


% --- Executes during object creation, after setting all properties.
function TraceSelector2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in CopyFile.
function CopyFile_Callback(hObject, eventdata, handles)
% hObject    handle to CopyFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CopyFile


% --- Executes on button press in CopyPath.
function CopyPath_Callback(hObject, eventdata, handles)
% hObject    handle to CopyPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CopyPath
