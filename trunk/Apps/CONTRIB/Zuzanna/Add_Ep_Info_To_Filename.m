function varargout = Add_Ep_Info_To_Filename(varargin)
% ADD_EP_INFO_TO_FILENAME MATLAB code for Add_Ep_Info_To_Filename.fig
%      ADD_EP_INFO_TO_FILENAME, by itself, creates a new ADD_EP_INFO_TO_FILENAME or raises the existing
%      singleton*.
%
%      H = ADD_EP_INFO_TO_FILENAME returns the handle to a new ADD_EP_INFO_TO_FILENAME or the handle to
%      the existing singleton*.
%
%      ADD_EP_INFO_TO_FILENAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADD_EP_INFO_TO_FILENAME.M with the given input arguments.
%
%      ADD_EP_INFO_TO_FILENAME('Property','Value',...) creates a new ADD_EP_INFO_TO_FILENAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Add_Ep_Info_To_Filename_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Add_Ep_Info_To_Filename_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Add_Ep_Info_To_Filename

% Last Modified by GUIDE v2.5 26-Oct-2012 18:18:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Add_Ep_Info_To_Filename_OpeningFcn, ...
                   'gui_OutputFcn',  @Add_Ep_Info_To_Filename_OutputFcn, ...
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


% --- Executes just before Add_Ep_Info_To_Filename is made visible.
function Add_Ep_Info_To_Filename_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Add_Ep_Info_To_Filename (see VARARGIN)

% Choose default command line output for Add_Ep_Info_To_Filename
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Add_Ep_Info_To_Filename wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.EpStart,'String',Settings.EpStartString);
    set(handles.EpLast,'String',Settings.EpLastString);
end

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
      
    end
    set(handles.TraceSelector,'String',TextTrace);
  
end

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.EpStartString=get(handles.EpStart,'String');
Settings.EpLastString=get(handles.EpLast,'String');


% --- Outputs from this function are returned to the command line.
function varargout = Add_Ep_Info_To_Filename_OutputFcn(hObject, eventdata, handles)
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

epstart=str2num(get(handles.EpStart,'String'));
eplast=str2num(get(handles.EpLast,'String'));

newname=get(handles.NewFilename,'String');

for k=TargetTraces   
    SpikeTraceData(k).Filename=newname; 
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




function EpStart_Callback(hObject, eventdata, handles)
% hObject    handle to EpStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EpStart as text
%        str2double(get(hObject,'String')) returns contents of EpStart as a double


% --- Executes during object creation, after setting all properties.
function EpStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EpStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EpLast_Callback(hObject, eventdata, handles)
% hObject    handle to EpLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EpLast as text
%        str2double(get(hObject,'String')) returns contents of EpLast as a double


% --- Executes during object creation, after setting all properties.
function EpLast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EpLast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NewFilenameButton.
function NewFilenameButton_Callback(hObject, eventdata, handles)
% hObject    handle to NewFilenameButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TargetTraces=get(handles.TraceSelector,'Value');

epstart=str2num(get(handles.EpStart,'String'));
eplast=str2num(get(handles.EpLast,'String'));

newname=[SpikeTraceData(TargetTraces(1)).Filename '_ep' int2str(epstart) '-ep' int2str(eplast)];
set(handles.NewFilename,'String',newname);

