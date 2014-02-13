function varargout = PSTH_Values_Per_File(varargin)
% PSTH_VALUES_PER_FILE M-file for PSTH_Values_Per_File.fig
%      PSTH_VALUES_PER_FILE, by itself, creates a new PSTH_VALUES_PER_FILE or raises the existing
%      singleton*.
%
%      H = PSTH_VALUES_PER_FILE returns the handle to a new PSTH_VALUES_PER_FILE or the handle to
%      the existing singleton*.
%
%      PSTH_VALUES_PER_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSTH_VALUES_PER_FILE.M with the given input arguments.
%
%      PSTH_VALUES_PER_FILE('Property','Value',...) creates a new PSTH_VALUES_PER_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PSTH_Values_Per_File_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PSTH_Values_Per_File_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PSTH_Values_Per_File

% Last Modified by GUIDE v2.5 13-Dec-2012 13:29:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PSTH_Values_Per_File_OpeningFcn, ...
                   'gui_OutputFcn',  @PSTH_Values_Per_File_OutputFcn, ...
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


% --- Executes just before PSTH_Values_Per_File is made visible.
function PSTH_Values_Per_File_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PSTH_Values_Per_File (see VARARGIN)

% Choose default command line output for PSTH_Values_Per_File
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PSTH_Values_Per_File wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
set(handles.SumElements,'Value',Settings.SumElementsValue);
end

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    TextTrace2{1}='All Traces';
    for i=1:length(SpikeTraceData)
        TextTrace2{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace1{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector1,'String',TextTrace1);
    set(handles.TraceSelector2,'String',TextTrace2);
end
% --- Outputs from this function are returned to the command line.
function varargout = PSTH_Values_Per_File_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelector1String=get(handles.TraceSelector1,'String');
Settings.TraceSelector1Value=get(handles.TraceSelector1,'Value');
Settings.TraceSelector2String=get(handles.TraceSelector2,'String');
Settings.TraceSelector2Value=get(handles.TraceSelector2,'Value');
Settings.SumElementsValue=get(handles.SumElements,'Value');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

TraceNbTraces=get(handles.TraceSelector1,'Value');

if (get(handles.TraceSelector2,'Value')==1)
    TracesToCompact=1:length(SpikeTraceData);
else
    TracesToCompact=get(handles.TraceSelector2,'Value')-1;
end

dosum=get(handles.SumElements,'Value');
%%%%%%%%%%%%%

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

newtrace=zeros(1,length(SpikeTraceData(TraceNbTraces).Trace));

for k=TracesToCompact
    m=1;
    
    for j=1:length(SpikeTraceData(TraceNbTraces).Trace)
        nbtraces=SpikeTraceData(TraceNbTraces).Trace(j);
        if dosum==0
            newtrace(j)=SpikeTraceData(k).Trace(m);
        else
            newtrace(j)=sum(SpikeTraceData(k).Trace(m:m+nbtraces-1));
        end
        m=m+nbtraces %jump to Traces from next file
    end
   
    SpikeTraceData(BeginTrace+n).XVector=1:length(newtrace);
    SpikeTraceData(BeginTrace+n).Trace=newtrace;
    SpikeTraceData(BeginTrace+n).DataSize=length(newtrace);
    
    name=[SpikeTraceData(k).Label.ListText ' ,per file'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
    SpikeTraceData(BeginTrace+n).Label.XLabel='file nb';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
    
    n=n+1;
    
end


% ValidateValues_Callback(hObject, eventdata, handles);





% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



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

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelector1.
function TraceSelector1_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector1


% --- Executes during object creation, after setting all properties.
function TraceSelector1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SumElements.
function SumElements_Callback(hObject, eventdata, handles)
% hObject    handle to SumElements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SumElements
