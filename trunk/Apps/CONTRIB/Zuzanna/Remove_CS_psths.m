function varargout = Remove_CS_psths(varargin)
% REMOVE_CS_PSTHS M-file for Remove_CS_psths.fig
%      REMOVE_CS_PSTHS, by itself, creates a new REMOVE_CS_PSTHS or raises the existing
%      singleton*.
%
%      H = REMOVE_CS_PSTHS returns the handle to a new REMOVE_CS_PSTHS or the handle to
%      the existing singleton*.
%
%      REMOVE_CS_PSTHS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_CS_PSTHS.M with the given input arguments.
%
%      REMOVE_CS_PSTHS('Property','Value',...) creates a new REMOVE_CS_PSTHS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_CS_psths_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_CS_psths_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_CS_psths

% Last Modified by GUIDE v2.5 20-Dec-2012 17:45:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_CS_psths_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_CS_psths_OutputFcn, ...
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


% --- Executes just before Remove_CS_psths is made visible.
function Remove_CS_psths_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_CS_psths (see VARARGIN)

% Choose default command line output for Remove_CS_psths
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_CS_psths wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.TraceSelector2,'String',Settings.TraceSelector2String);
%     set(handles.TraceSelector2,'Value',Settings.TraceSelector2Value);
%     set(handles.TraceSelector3,'String',Settings.TraceSelector3String);
%     set(handles.TraceSelector3,'Value',Settings.TraceSelector3Value);
       
end


if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace);
    set(handles.TraceSelector3,'String',TextTrace);
end


% --- Outputs from this function are returned to the command line.
function varargout = Remove_CS_psths_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelector2String=get(handles.TraceSelector2,'String');
Settings.TraceSelector2Value=get(handles.TraceSelector2,'Value');
Settings.TraceSelector3String=get(handles.TraceSelector3,'String');
Settings.TraceSelector3Value=get(handles.TraceSelector3,'Value');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

PSTHsToRem=get(handles.TraceSelector,'Value');
TracesToUpdate=get(handles.TraceSelector2,'Value');
TracesToUpdateFile=get(handles.TraceSelector3,'Value');

%update selected Traces first (Xsize, Y size, int...)
for k=TracesToUpdate
   nbindices=length(SpikeTraceData(k).Trace);
   keepindices=setdiff(1:nbindices,PSTHsToRem); % assumes PSTHs start from Trace 1
   SpikeTraceData(k).Trace=SpikeTraceData(k).Trace(keepindices);
   SpikeTraceData(k).DataSize=length(SpikeTraceData(k).Trace);
   SpikeTraceData(k).XVector=1:length(SpikeTraceData(k).Trace);
end

%update Trace storing number of Traces per file:
traceind=0;
for i=1:length(SpikeTraceData(TracesToUpdateFile).Trace)   % loop over Files
    traceindstart=traceind;
    traceind=traceind+SpikeTraceData(TracesToUpdateFile).Trace(i);
    
    for j=PSTHsToRem  % for each File, loop over Trace indices to remove
        if j>traceindstart && j<=traceind  
            % remove one from total of Traces for this File IF the index of a Trace to remove is within indices originally belonging to File
            SpikeTraceData(TracesToUpdateFile).Trace(i)=SpikeTraceData(TracesToUpdateFile).Trace(i)-1;
        end
        
    end
end

% only now delete unwanted Traces:
NumberTraces=length(SpikeTraceData);
KeepTraces=setdiff(1:NumberTraces,PSTHsToRem);
SpikeTraceData=SpikeTraceData(KeepTraces);




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

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on TraceSelector and none of its controls.
function TraceSelector_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on selection change in TraceSelector3.
function TraceSelector3_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector3


% --- Executes during object creation, after setting all properties.
function TraceSelector3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
