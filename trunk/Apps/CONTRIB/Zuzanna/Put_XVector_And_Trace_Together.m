function varargout = Put_XVector_And_Trace_Together(varargin)
% PUT_XVECTOR_AND_TRACE_TOGETHER MATLAB code for Put_XVector_And_Trace_Together.fig
%      PUT_XVECTOR_AND_TRACE_TOGETHER, by itself, creates a new PUT_XVECTOR_AND_TRACE_TOGETHER or raises the existing
%      singleton*.
%
%      H = PUT_XVECTOR_AND_TRACE_TOGETHER returns the handle to a new PUT_XVECTOR_AND_TRACE_TOGETHER or the handle to
%      the existing singleton*.
%
%      PUT_XVECTOR_AND_TRACE_TOGETHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PUT_XVECTOR_AND_TRACE_TOGETHER.M with the given input arguments.
%
%      PUT_XVECTOR_AND_TRACE_TOGETHER('Property','Value',...) creates a new PUT_XVECTOR_AND_TRACE_TOGETHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Put_XVector_And_Trace_Together_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Put_XVector_And_Trace_Together_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Put_XVector_And_Trace_Together

% Last Modified by GUIDE v2.5 25-Oct-2012 18:00:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Put_XVector_And_Trace_Together_OpeningFcn, ...
                   'gui_OutputFcn',  @Put_XVector_And_Trace_Together_OutputFcn, ...
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


% --- Executes just before Put_XVector_And_Trace_Together is made visible.
function Put_XVector_And_Trace_Together_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Put_XVector_And_Trace_Together (see VARARGIN)

% Choose default command line output for Put_XVector_And_Trace_Together
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Put_XVector_And_Trace_Together wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.UseXVforXV,'Value',Settings.UseXVforXVValue);
    set(handles.UseTraceforXV,'Value',Settings.UseTraceforXVValue);
    set(handles.UseXVforTrace,'Value',Settings.UseXVforTraceValue);
    set(handles.UseTraceforTrace,'Value',Settings.UseTraceforTraceValue);
    set(handles.ManyOutputs,'Value',Settings.ManyOutputsValue);
    set(handles.OneOutput,'Value',Settings.OneOutputValue);
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
Settings.UseXVforXVValue=get(handles.UseXVforXV,'Value');
Settings.UseXVforTraceValue=get(handles.UseXVforTrace,'Value');
Settings.UseTraceforXVValue=get(handles.UseTraceforXV,'Value');
Settings.UseTraceforTraceValue=get(handles.UseTraceforTrace,'Value');
Settings.ManyOutputsValue=get(handles.ManyOutputs,'Value');
Settings.OneOutputValue=get(handles.OneOutput,'Value');


% --- Outputs from this function are returned to the command line.
function varargout = Put_XVector_And_Trace_Together_OutputFcn(hObject, eventdata, handles)
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

ForXV=get(handles.TraceSelector,'Value');
xvforxv=get(handles.UseXVforXV,'Value');
traceforxv=get(handles.UseTraceforXV,'Value');

ForTrace=get(handles.TraceSelector2,'Value');
tracefortrace=get(handles.UseTraceforTrace,'Value');
xvfortrace=get(handles.UseXVforTrace,'Value');

manyoutputs=get(handles.ManyOutputs,'Value');
oneoutput=get(handles.OneOutput,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0;
i=1;

if manyoutputs
    many=length(ForXV);
    
    for z=1:many
        
    if xvforxv       
    SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(ForXV(z)).XVector;
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(ForXV(z)).Label.XLabel; 
    elseif traceforxv
    SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(ForXV(z)).Trace;
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(ForXV(z)).Label.YLabel;
    end
    
    if xvfortrace    
    SpikeTraceData(BeginTrace+n).Trace=SpikeTraceData(ForTrace(z)).XVector;
    SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(ForTrace(z)).Label.XLabel;
    elseif tracefortrace
    SpikeTraceData(BeginTrace+n).Trace=SpikeTraceData(ForTrace(z)).Trace;
    SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(ForTrace(z)).Label.YLabel;
    end
    SpikeTraceData(BeginTrace+n).DataSize=length(SpikeTraceData(BeginTrace+n).XVector);
    
    name=[SpikeTraceData(BeginTrace+n).Label.YLabel ' vs. ' SpikeTraceData(BeginTrace+n).Label.XLabel ',nb. ' int2str(z)];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(ForXV(z)).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(ForXV(z)).Path;
    
    n=n+1;
        
    end 
end

if oneoutput
    
    numpieces=length(ForXV);
    newend=0;
    
    for z=1:numpieces
        
        addend=SpikeTraceData(ForXV(z)).DataSize;
        
        if xvforxv
            SpikeTraceData(BeginTrace+n).XVector(newend+1:newend+addend)=SpikeTraceData(ForXV(z)).XVector;
            SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(ForXV(z)).Label.XLabel;
        elseif traceforxv
            SpikeTraceData(BeginTrace+n).XVector(newend+1:newend+addend)=SpikeTraceData(ForXV(z)).Trace;
            SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(ForXV(z)).Label.YLabel;
        end
        
        if xvfortrace
            SpikeTraceData(BeginTrace+n).Trace(newend+1:newend+addend)=SpikeTraceData(ForTrace(z)).XVector;
            SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(ForTrace(z)).Label.XLabel;
        elseif tracefortrace
            SpikeTraceData(BeginTrace+n).Trace(newend+1:newend+addend)=SpikeTraceData(ForTrace(z)).Trace;
            SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(ForTrace(z)).Label.YLabel;
        end
        SpikeTraceData(BeginTrace+n).DataSize=length(SpikeTraceData(BeginTrace+n).XVector);
        
        name=[SpikeTraceData(BeginTrace+n).Label.YLabel ' vs. ' SpikeTraceData(BeginTrace+n).Label.XLabel ',from ' int2str(z) ' traces'];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(ForXV(z)).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(ForXV(z)).Path;
        
        newend=newend+addend;
        
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



% --- Executes on button press in UseXVforXV.
function UseXVforXV_Callback(hObject, eventdata, handles)
% hObject    handle to UseXVforXV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseXVforXV


% --- Executes on button press in UseTraceforXV.
function UseTraceforXV_Callback(hObject, eventdata, handles)
% hObject    handle to UseTraceforXV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseTraceforXV


% --- Executes on button press in UseTraceforTrace.
function UseTraceforTrace_Callback(hObject, eventdata, handles)
% hObject    handle to UseTraceforTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseTraceforTrace


% --- Executes on button press in UseXVforTrace.
function UseXVforTrace_Callback(hObject, eventdata, handles)
% hObject    handle to UseXVforTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseXVforTrace


% --- Executes on button press in ManyOutputs.
function ManyOutputs_Callback(hObject, eventdata, handles)
% hObject    handle to ManyOutputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ManyOutputs


% --- Executes on button press in OneOutput.
function OneOutput_Callback(hObject, eventdata, handles)
% hObject    handle to OneOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OneOutput
