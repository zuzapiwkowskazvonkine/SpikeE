function varargout = Convert_Intensities_using_Tables(varargin)
% CONVERT_INTENSITIES_USING_TABLES M-file for Convert_Intensities_using_Tables.fig
%      CONVERT_INTENSITIES_USING_TABLES, by itself, creates a new CONVERT_INTENSITIES_USING_TABLES or raises the existing
%      singleton*.
%
%      H = CONVERT_INTENSITIES_USING_TABLES returns the handle to a new CONVERT_INTENSITIES_USING_TABLES or the handle to
%      the existing singleton*.
%
%      CONVERT_INTENSITIES_USING_TABLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_INTENSITIES_USING_TABLES.M with the given input arguments.
%
%      CONVERT_INTENSITIES_USING_TABLES('Property','Value',...) creates a new CONVERT_INTENSITIES_USING_TABLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Convert_Intensities_using_Tables_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Convert_Intensities_using_Tables_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Convert_Intensities_using_Tables

% Last Modified by GUIDE v2.5 16-Feb-2013 14:04:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Convert_Intensities_using_Tables_OpeningFcn, ...
                   'gui_OutputFcn',  @Convert_Intensities_using_Tables_OutputFcn, ...
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


% --- Executes just before Convert_Intensities_using_Tables is made visible.
function Convert_Intensities_using_Tables_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Convert_Intensities_using_Tables (see VARARGIN)

% Choose default command line output for Convert_Intensities_using_Tables
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Convert_Intensities_using_Tables wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelectorIntTable,'String',TextTrace);
end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceSelector,'String',Settings.TraceSelectorString);
    set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
    set(handles.TraceSelectorIntTable,'String',Settings.TraceSelectorIntTableString);
    set(handles.TraceSelectorIntTable,'Value',Settings.TraceSelectorIntTableValue);
end


% --- Outputs from this function are returned to the command line.
function varargout = Convert_Intensities_using_Tables_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorIntTableString=get(handles.TraceSelectorIntTable,'String');
Settings.TraceSelectorIntTableValue=get(handles.TraceSelectorIntTable,'Value');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

TraceInts=get(handles.TraceSelector,'Value');
TraceIntTables=get(handles.TraceSelectorIntTable,'Value');

refnameints=SpikeTraceData(TraceInts).Label.ListText;
refnametables=SpikeTraceData(TraceIntTables).Label.ListText;

tot=length(SpikeTraceData);

indsints=[];
indstables=[];

for i=1:tot
    
    if strcmp(SpikeTraceData(i).Label.ListText,refnameints)
        indsints(end+1)=i;
    else
        if strcmp(SpikeTraceData(i).Label.ListText,refnametables)
            indstables(end+1)=i;
        end
    end
    
end

indsints
indstables

n=1; % counter for Tables
for k=indsints % loop over Intensities Traces
    
    table=indstables(n); % index od associated Int Table Trace
    
    if min(SpikeTraceData(k).Trace)<1
        intensities=10*SpikeTraceData(k).Trace;
    else
        intensities=SpikeTraceData(k).Trace;
    end

    convintensities=zeros(1,length(intensities));
    for i=1:length(intensities)    
        convind=find(SpikeTraceData(table).XVector==intensities(i))  %look for the right element in Int Table
        convintensities(i)=SpikeTraceData(table).Trace(convind) %get corresponding int value in uW from Int Table
    end
    
    BeginTrace=length(SpikeTraceData)+1;

    SpikeTraceData(BeginTrace).XVector=1:length(convintensities);
    SpikeTraceData(BeginTrace).Trace=convintensities;
    SpikeTraceData(BeginTrace).DataSize=length(convintensities);
    
    newname=['Converted ' refnameints];
    SpikeTraceData(BeginTrace).Label.ListText=newname;
    SpikeTraceData(BeginTrace).Label.YLabel='microW';
    SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
    
    
    n=n+1;
end












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


% --- Executes on selection change in TraceSelectorIntTable.
function TraceSelectorIntTable_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorIntTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorIntTable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorIntTable


% --- Executes during object creation, after setting all properties.
function TraceSelectorIntTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorIntTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




