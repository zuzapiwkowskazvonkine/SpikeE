function varargout = Parse_Label_ListText(varargin)
% PARSE_LABEL_LISTTEXT M-file for Parse_Label_ListText.fig
%      PARSE_LABEL_LISTTEXT, by itself, creates a new PARSE_LABEL_LISTTEXT or raises the existing
%      singleton*.
%
%      H = PARSE_LABEL_LISTTEXT returns the handle to a new PARSE_LABEL_LISTTEXT or the handle to
%      the existing singleton*.
%
%      PARSE_LABEL_LISTTEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARSE_LABEL_LISTTEXT.M with the given input arguments.
%
%      PARSE_LABEL_LISTTEXT('Property','Value',...) creates a new PARSE_LABEL_LISTTEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Parse_Label_ListText_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Parse_Label_ListText_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Parse_Label_ListText

% Last Modified by GUIDE v2.5 07-Mar-2013 14:03:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Parse_Label_ListText_OpeningFcn, ...
                   'gui_OutputFcn',  @Parse_Label_ListText_OutputFcn, ...
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


% --- Executes just before Parse_Label_ListText is made visible.
function Parse_Label_ListText_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Parse_Label_ListText (see VARARGIN)

global SpikeTraceData;


% Choose default command line output for Parse_Label_ListText
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Parse_Label_ListText wait for user response (see UIRESUME)
% uiwait(handles.figure1);


TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelectorStim,'String',Settings.TraceSelectorStimString);
%     set(handles.TraceSelectorStim,'Value',Settings.TraceSelectorStimValue);
%     set(handles.TraceSelectorSpikes,'String',Settings.TraceSelectorSpikesString);
%     set(handles.TraceSelectorSpikes,'Value',Settings.TraceSelectorSpikesValue);
%     set(handles.TraceSelectorPlot,'String',Settings.TraceSelectorPlotString);
%     set(handles.TraceSelectorPlot,'Value',Settings.TraceSelectorPlotValue);
    set(handles.ParsePattern,'String',Settings.ParsePatternString);
    set(handles.NewName,'String',Settings.NewNameString);
end


% --- Outputs from this function are returned to the command line.
function varargout = Parse_Label_ListText_OutputFcn(hObject, eventdata, handles) 
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
Settings.ParsePatternString=get(handles.ParsePattern,'String');
Settings.NewNameString=get(handles.NewName,'String');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

Traces=get(handles.TraceSelector,'Value');
pattern=get(handles.ParsePattern,'String');
newname=get(handles.NewName,'String');

Values=zeros(1,length(Traces));

n=1;
for k=Traces
    
    name=SpikeTraceData(k).Label.ListText;
    sz=length(pattern);
    ind=strfind(name,pattern);
    
    if ~isempty(ind)
        namecut=name(ind+sz+1:end);
        
        val=sscanf(namecut,'%d %*s');
        Values(n)=val;
    end
    n=n+1;
end


BeginTrace=length(SpikeTraceData)+1;
SpikeTraceData(BeginTrace).XVector=1:length(Values);
SpikeTraceData(BeginTrace).Trace=Values;
SpikeTraceData(BeginTrace).DataSize=length(Values);

SpikeTraceData(BeginTrace).Label.ListText=newname;
SpikeTraceData(BeginTrace).Label.YLabel=newname;
SpikeTraceData(BeginTrace).Label.XLabel='';
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(Traces(1)).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(Traces(1)).Path;




% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function ParsePattern_Callback(hObject, eventdata, handles)
% hObject    handle to ParsePattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ParsePattern as text
%        str2double(get(hObject,'String')) returns contents of ParsePattern as a double


% --- Executes during object creation, after setting all properties.
function ParsePattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ParsePattern (see GCBO)
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

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NewName_Callback(hObject, eventdata, handles)
% hObject    handle to NewName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NewName as text
%        str2double(get(hObject,'String')) returns contents of NewName as a double


% --- Executes during object creation, after setting all properties.
function NewName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
