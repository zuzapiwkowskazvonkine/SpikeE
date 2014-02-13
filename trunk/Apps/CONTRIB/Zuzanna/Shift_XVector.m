function varargout = Shift_XVector(varargin)
% SHIFT_XVECTOR M-file for Shift_XVector.fig
%      SHIFT_XVECTOR, by itself, creates a new SHIFT_XVECTOR or raises the existing
%      singleton*.
%
%      H = SHIFT_XVECTOR returns the handle to a new SHIFT_XVECTOR or the handle to
%      the existing singleton*.
%
%      SHIFT_XVECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIFT_XVECTOR.M with the given input arguments.
%
%      SHIFT_XVECTOR('Property','Value',...) creates a new SHIFT_XVECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Shift_XVector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Shift_XVector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Shift_XVector

% Last Modified by GUIDE v2.5 06-Dec-2012 14:22:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Shift_XVector_OpeningFcn, ...
                   'gui_OutputFcn',  @Shift_XVector_OutputFcn, ...
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


% --- Executes just before Shift_XVector is made visible.
function Shift_XVector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Shift_XVector (see VARARGIN)

% Choose default command line output for Shift_XVector
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Shift_XVector wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
    set(handles.FirstXValue,'String',Settings.FirstXValueString);
    set(handles.XStep,'String',Settings.XStepString);
end

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    TextTrace{1}='All Traces';
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end
% --- Outputs from this function are returned to the command line.
function varargout = Shift_XVector_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.FirstXValueString=get(handles.FirstXValue,'String');
Settings.XStepString=get(handles.XStep,'String');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    TracesToApply=1:length(SpikeTraceData);
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end

%%%%%%%%%%%%%

firstx=str2double(get(handles.FirstXValue,'String'));
stepx=str2double(get(handles.XStep,'String'));
 
BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter


for k=TracesToApply
    
    
    SpikeTraceData(BeginTrace+n).XVector=firstx:stepx:firstx+SpikeTraceData(k).DataSize-1;
    SpikeTraceData(BeginTrace+n).Trace=SpikeTraceData(k).Trace;
    SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(k).DataSize;
    
    SpikeTraceData(BeginTrace+n).Label.ListText=SpikeTraceData(k).Label.ListText;
    SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
 
    
    n=n+1;
    
end

% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function FirstXValue_Callback(hObject, eventdata, handles)
% hObject    handle to FirstXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstXValue as text
%        str2double(get(hObject,'String')) returns contents of FirstXValue as a double


% --- Executes during object creation, after setting all properties.
function FirstXValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function XStep_Callback(hObject, eventdata, handles)
% hObject    handle to XStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XStep as text
%        str2double(get(hObject,'String')) returns contents of XStep as a double


% --- Executes during object creation, after setting all properties.
function XStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
