function varargout = Make_Intensities_vs_Position_Traces(varargin)
% MAKE_INTENSITIES_VS_POSITION_TRACES MATLAB code for Make_Intensities_vs_Position_Traces.fig
%      MAKE_INTENSITIES_VS_POSITION_TRACES, by itself, creates a new MAKE_INTENSITIES_VS_POSITION_TRACES or raises the existing
%      singleton*.
%
%      H = MAKE_INTENSITIES_VS_POSITION_TRACES returns the handle to a new MAKE_INTENSITIES_VS_POSITION_TRACES or the handle to
%      the existing singleton*.
%
%      MAKE_INTENSITIES_VS_POSITION_TRACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE_INTENSITIES_VS_POSITION_TRACES.M with the given input arguments.
%
%      MAKE_INTENSITIES_VS_POSITION_TRACES('Property','Value',...) creates a new MAKE_INTENSITIES_VS_POSITION_TRACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Make_Intensities_vs_Position_Traces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Make_Intensities_vs_Position_Traces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Make_Intensities_vs_Position_Traces

% Last Modified by GUIDE v2.5 25-Oct-2012 16:04:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Make_Intensities_vs_Position_Traces_OpeningFcn, ...
                   'gui_OutputFcn',  @Make_Intensities_vs_Position_Traces_OutputFcn, ...
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


% --- Executes just before Make_Intensities_vs_Position_Traces is made visible.
function Make_Intensities_vs_Position_Traces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Make_Intensities_vs_Position_Traces (see VARARGIN)

% Choose default command line output for Make_Intensities_vs_Position_Traces
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Make_Intensities_vs_Position_Traces wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.SingleIntStep,'String',Settings.SingleIntStepString);
    set(handles.Manual,'Value',Settings.ManualValue);
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
Settings.SingleIntStepString=get(handles.SingleIntStep,'String');
Settings.ManualValue=get(handles.Manual,'Value');




% --- Outputs from this function are returned to the command line.
function varargout = Make_Intensities_vs_Position_Traces_OutputFcn(hObject, eventdata, handles)
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

    TracesWithPSTH=get(handles.TraceSelector,'Value');
    TraceWithIntTable=get(handles.TraceSelector2,'Value');
    
    manual=get(handles.Manual,'Value');
    intstep=str2double(get(handles.SingleIntStep,'String'));
    
    BeginTrace=length(SpikeTraceData)+1;
    n=0;
    i=1;
    istr=zeros(1,length(TracesWithPSTH));
    jstr=zeros(1,length(TracesWithPSTH));
    ints=zeros(1,length(TracesWithPSTH));
    
    for k=TracesWithPSTH
        
        nametoparse=SpikeTraceData(k).Label.ListText;
        a=strfind(nametoparse,'X:');
        ipos=a+2;
        b=strfind(nametoparse,'Y:');
        jpos=b+2;
        
        numcharsi=jpos-ipos-3;
        
        istr(i)=str2double(nametoparse(ipos:ipos+numcharsi-1));
        jstr(i)=str2double(nametoparse(jpos:length(nametoparse)));
        
        i=i+1;
        
    end
    
    if manual==0
        ind=find(SpikeTraceData(TraceWithIntTable).XVector==intstep);
        val=SpikeTraceData(TraceWithIntTable).Trace(ind)
        ints(:)=val;    
    else

        for z=1:length(ints);
        prompt=['Enter step intensity for PSTH ' int2str(z) ':'];
        answer=inputdlg(prompt,'Step intensities',1); 
        ind=find(SpikeTraceData(TraceWithIntTable).XVector==str2double(answer));
        val=SpikeTraceData(TraceWithIntTable).Trace(ind);
        ints(z)=val;       
        end
        
    end
    
    SpikeTraceData(BeginTrace+n).XVector=istr;
    SpikeTraceData(BeginTrace+n).Trace=ints;
    SpikeTraceData(BeginTrace+n).DataSize=length(ints);
    
    name=['Intensity vs. X position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='intensity (microW)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='X position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithPSTH(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithPSTH(1)).Path;
    
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=jstr;
    SpikeTraceData(BeginTrace+n).Trace=ints;
    SpikeTraceData(BeginTrace+n).DataSize=length(ints);
    
    name=['Intensity vs. Y position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='intensity (microW)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='Y position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithPSTH(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithPSTH(1)).Path;
    
ValidateValues_Callback(hObject, eventdata, handles);

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



function SingleIntStep_Callback(hObject, eventdata, handles)
% hObject    handle to SingleIntStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SingleIntStep as text
%        str2double(get(hObject,'String')) returns contents of SingleIntStep as a double


% --- Executes during object creation, after setting all properties.
function SingleIntStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SingleIntStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Manual.
function Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Manual
