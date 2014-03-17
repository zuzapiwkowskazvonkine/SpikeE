function varargout = Remove_Artifacts_from_Spikes(varargin)
% REMOVE_ARTIFACTS_FROM_SPIKES M-file for Remove_Artifacts_from_Spikes.fig
%      REMOVE_ARTIFACTS_FROM_SPIKES, by itself, creates a new REMOVE_ARTIFACTS_FROM_SPIKES or raises the existing
%      singleton*.
%
%      H = REMOVE_ARTIFACTS_FROM_SPIKES returns the handle to a new REMOVE_ARTIFACTS_FROM_SPIKES or the handle to
%      the existing singleton*.
%
%      REMOVE_ARTIFACTS_FROM_SPIKES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_ARTIFACTS_FROM_SPIKES.M with the given input arguments.
%
%      REMOVE_ARTIFACTS_FROM_SPIKES('Property','Value',...) creates a new REMOVE_ARTIFACTS_FROM_SPIKES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_Artifacts_from_Spikes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_Artifacts_from_Spikes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_Artifacts_from_Spikes

% Last Modified by GUIDE v2.5 04-Mar-2014 14:19:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_Artifacts_from_Spikes_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_Artifacts_from_Spikes_OutputFcn, ...
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


% --- Executes just before Remove_Artifacts_from_Spikes is made visible.
function Remove_Artifacts_from_Spikes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_Artifacts_from_Spikes (see VARARGIN)

% Choose default command line output for Remove_Artifacts_from_Spikes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_Artifacts_from_Spikes wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.MinISI,'String',Settings.MinISIString);
%     set(handles.Extract,'Value',Settings.ExtractValue);
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
function varargout = Remove_Artifacts_from_Spikes_OutputFcn(hObject, eventdata, handles) 
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

startart=str2double(get(handles.Start_Artifact,'String'));
endart=str2double(get(handles.End_Artifact,'String'));

%%%%%%%%%%%%%
inds=[];

for k=TracesToApply
        
    inds=find((SpikeTraceData(k).XVector>=startart)&( SpikeTraceData(k).XVector<=endart))
    
    % is the Data a list of times (with all Trace values=1), or a Trace of 0s and 1s?
    
    if sum(SpikeTraceData(k).Trace(1:5))==5  % in this case all Trace values =1. Remove the datapoints in the window completely.
      
    SpikeTraceData(k).Trace(inds)=[];
    SpikeTraceData(k).XVector(inds)=[];
    SpikeTraceData(k).DataSize=length(SpikeTraceData(k).Trace);
        
    else   % a Trace of 0s and 1s. Replace 1s in the window with 0s.
        
    SpikeTraceData(k).Trace(inds)=0;    
        
    end
    
    
end

% ValidateValues_Callback(hObject, eventdata, handles);



% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


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



function Start_Artifact_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Artifact as text
%        str2double(get(hObject,'String')) returns contents of Start_Artifact as a double


% --- Executes during object creation, after setting all properties.
function Start_Artifact_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function End_Artifact_Callback(hObject, eventdata, handles)
% hObject    handle to End_Artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Artifact as text
%        str2double(get(hObject,'String')) returns contents of End_Artifact as a double


% --- Executes during object creation, after setting all properties.
function End_Artifact_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
