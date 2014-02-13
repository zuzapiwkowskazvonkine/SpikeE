function varargout = Make_Response_vs_Position_Traces(varargin)
% MAKE_RESPONSE_VS_POSITION_TRACES MATLAB code for Make_Response_vs_Position_Traces.fig
%      MAKE_RESPONSE_VS_POSITION_TRACES, by itself, creates a new MAKE_RESPONSE_VS_POSITION_TRACES or raises the existing
%      singleton*.
%
%      H = MAKE_RESPONSE_VS_POSITION_TRACES returns the handle to a new MAKE_RESPONSE_VS_POSITION_TRACES or the handle to
%      the existing singleton*.
%
%      MAKE_RESPONSE_VS_POSITION_TRACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE_RESPONSE_VS_POSITION_TRACES.M with the given input arguments.
%
%      MAKE_RESPONSE_VS_POSITION_TRACES('Property','Value',...) creates a new MAKE_RESPONSE_VS_POSITION_TRACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Make_Response_vs_Position_Traces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Make_Response_vs_Position_Traces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Make_Response_vs_Position_Traces

% Last Modified by GUIDE v2.5 30-Oct-2012 16:14:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Make_Response_vs_Position_Traces_OpeningFcn, ...
                   'gui_OutputFcn',  @Make_Response_vs_Position_Traces_OutputFcn, ...
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


% --- Executes just before Make_Response_vs_Position_Traces is made visible.
function Make_Response_vs_Position_Traces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Make_Response_vs_Position_Traces (see VARARGIN)

% Choose default command line output for Make_Response_vs_Position_Traces
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Make_Response_vs_Position_Traces wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.MaxTrace,'Value',Settings.MaxTraceValue);
    set(handles.MinTrace,'Value',Settings.MinTraceValue);
    set(handles.AvgTrace,'Value',Settings.AvgTraceValue);
    set(handles.GetOneResp,'Value',Settings.GetOneRespValue);
    set(handles.StimNb,'String',Settings.StimNbString);
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
Settings.MaxTraceValue=get(handles.MaxTrace,'Value');
Settings.MinTraceValue=get(handles.MinTrace,'Value');
Settings.AvgTraceValue=get(handles.AvgTrace,'Value');
Settings.GetOneRespValue=get(handles.GetOneResp,'Value');
Settings.StimNbString=get(handles.StimNb,'String');


% --- Outputs from this function are returned to the command line.
function varargout = Make_Response_vs_Position_Traces_OutputFcn(hObject, eventdata, handles)
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

    TracesWithRes=get(handles.TraceSelector,'Value');
    
    maxtrace=get(handles.MaxTrace,'Value');
    mintrace=get(handles.MinTrace,'Value');
    avgtrace=get(handles.AvgTrace,'Value');
    oneresp=get(handles.GetOneResp,'Value');
    stimnb=str2num(get(handles.StimNb,'String'));
   
    
    BeginTrace=length(SpikeTraceData)+1;
    n=0;
    i=1;
    istr=zeros(1,length(TracesWithRes));
    jstr=zeros(1,length(TracesWithRes));
    maxs=zeros(1,length(TracesWithRes));
    mins=zeros(1,length(TracesWithRes));
    avgs=zeros(1,length(TracesWithRes));
    
    for k=TracesWithRes
        
        nametoparse=SpikeTraceData(k).Label.ListText;
        a=strfind(nametoparse,'X:');
        ipos=a+2;
        b=strfind(nametoparse,'Y:');
        jpos=b+2;
        
        numcharsi=jpos-ipos-3;
        
        istr(i)=str2double(nametoparse(ipos:ipos+numcharsi-1));
        jstr(i)=str2double(nametoparse(jpos:length(nametoparse)));
        
        if maxtrace
        maxs(i)=max(SpikeTraceData(k).Trace);
        end
        
        if mintrace
        mins(i)=min(SpikeTraceData(k).Trace);
        end
        
        if avgtrace
        avgs(i)=mean(SpikeTraceData(k).Trace);
        end
        
        if oneresp
        resp(i)=SpikeTraceData(k).Trace(stimnb);    
        end    
        
        i=i+1;
        
    end
    
if maxtrace
    
    SpikeTraceData(BeginTrace+n).XVector=istr;
    SpikeTraceData(BeginTrace+n).Trace=maxs;
    SpikeTraceData(BeginTrace+n).DataSize=length(maxs);
    
    name=['Max response vs. X position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='max resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='X position';
    SpikeTraceData(BeginTrace+n).Filename= SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=jstr;
    SpikeTraceData(BeginTrace+n).Trace=maxs;
    SpikeTraceData(BeginTrace+n).DataSize=length(maxs);
    
    name=['Max response vs. Y position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='max resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='Y position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
end

if mintrace
    
    SpikeTraceData(BeginTrace+n).XVector=istr;
    SpikeTraceData(BeginTrace+n).Trace=mins;
    SpikeTraceData(BeginTrace+n).DataSize=length(mins);
    
    name=['Min response vs. X position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='min resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='X position';
    SpikeTraceData(BeginTrace+n).Filename= SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=jstr;
    SpikeTraceData(BeginTrace+n).Trace=mins;
    SpikeTraceData(BeginTrace+n).DataSize=length(mins);
    
    name=['Min response vs. Y position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='min resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='Y position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
end

if avgtrace
    
    SpikeTraceData(BeginTrace+n).XVector=istr;
    SpikeTraceData(BeginTrace+n).Trace=avgs;
    SpikeTraceData(BeginTrace+n).DataSize=length(avgs);
    
    name=['Avg response vs. X position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='avg resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='X position';
    SpikeTraceData(BeginTrace+n).Filename= SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=jstr;
    SpikeTraceData(BeginTrace+n).Trace=avgs;
    SpikeTraceData(BeginTrace+n).DataSize=length(avgs);
    
    name=['Avg response vs. Y position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='avg resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='Y position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
end

if oneresp

    SpikeTraceData(BeginTrace+n).XVector=istr;
    SpikeTraceData(BeginTrace+n).Trace=resp;
    SpikeTraceData(BeginTrace+n).DataSize=length(resp);
    
    name=['Response nb.' int2str(stimnb) ' vs. X position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='X position';
    SpikeTraceData(BeginTrace+n).Filename= SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=jstr;
    SpikeTraceData(BeginTrace+n).Trace=resp;
    SpikeTraceData(BeginTrace+n).DataSize=length(resp);
    
    name=['Response nb.' int2str(stimnb) ' vs. Y position'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='resp (Hz)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='Y position';
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesWithRes(1)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesWithRes(1)).Path;
    
    n=n+1;    
    
end

    
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


% --- Executes on button press in MaxTrace.
function MaxTrace_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MaxTrace


% --- Executes on button press in MinTrace.
function MinTrace_Callback(hObject, eventdata, handles)
% hObject    handle to MinTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MinTrace


% --- Executes on button press in AvgTrace.
function AvgTrace_Callback(hObject, eventdata, handles)
% hObject    handle to AvgTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AvgTrace


% --- Executes on button press in GetOneResp.
function GetOneResp_Callback(hObject, eventdata, handles)
% hObject    handle to GetOneResp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GetOneResp



function StimNb_Callback(hObject, eventdata, handles)
% hObject    handle to StimNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StimNb as text
%        str2double(get(hObject,'String')) returns contents of StimNb as a double


% --- Executes during object creation, after setting all properties.
function StimNb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StimNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
