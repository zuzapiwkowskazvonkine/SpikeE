function varargout = Analyze_PSTH_windows(varargin)
% ANALYZE_PSTH_WINDOWS M-file for Analyze_PSTH_windows.fig
%      ANALYZE_PSTH_WINDOWS, by itself, creates a new ANALYZE_PSTH_WINDOWS or raises the existing
%      singleton*.
%
%      H = ANALYZE_PSTH_WINDOWS returns the handle to a new ANALYZE_PSTH_WINDOWS or the handle to
%      the existing singleton*.
%
%      ANALYZE_PSTH_WINDOWS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZE_PSTH_WINDOWS.M with the given input arguments.
%
%      ANALYZE_PSTH_WINDOWS('Property','Value',...) creates a new ANALYZE_PSTH_WINDOWS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analyze_PSTH_windows_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analyze_PSTH_windows_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analyze_PSTH_windows

% Last Modified by GUIDE v2.5 30-Oct-2012 11:21:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analyze_PSTH_windows_OpeningFcn, ...
                   'gui_OutputFcn',  @Analyze_PSTH_windows_OutputFcn, ...
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


% --- Executes just before Analyze_PSTH_windows is made visible.
function Analyze_PSTH_windows_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analyze_PSTH_windows (see VARARGIN)

% Choose default command line output for Analyze_PSTH_windows
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analyze_PSTH_windows wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
    set(handles.GetMax,'Value',Settings.GetMaxValue);
    set(handles.GetMin,'Value',Settings.GetMinValue);
    set(handles.GetAvg,'Value',Settings.GetAvgValue);
    set(handles.StartBinBaseline,'String',Settings.StartBinBaselineString);
    set(handles.StopBinBaseline,'String',Settings.StopBinBaselineString);
    set(handles.NbStims,'String',Settings.NbStimsString);
    set(handles.ISI,'String',Settings.ISIString);
    set(handles.WinStart,'String',Settings.WinStartString);
    set(handles.WinDur,'String',Settings.WinDurString);
   
end

TextTrace{1}='All Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace2{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];

    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);

end


% --- Outputs from this function are returned to the command line.
function varargout = Analyze_PSTH_windows_OutputFcn(hObject, eventdata, handles) 
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
Settings.StartBinBaselineString=get(handles.StartBinBaseline,'String');
Settings.StopBinBaselineString=get(handles.StopBinBaseline,'String');
Settings.NbStimsString=get(handles.NbStims,'String');
Settings.ISIString=get(handles.ISI,'String');
Settings.WinStartString=get(handles.WinStart,'String');
Settings.WinDurString=get(handles.WinDur,'String');
Settings.GetMaxValue=get(handles.GetMax,'Value');
Settings.GetMinValue=get(handles.GetMin,'Value');
Settings.GetAvgValue=get(handles.GetAvg,'Value');

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

getmin=get(handles.GetMin,'Value');
getmax=get(handles.GetMax,'Value');
getavg=get(handles.GetAvg,'Value');
nbstims=str2num(get(handles.NbStims,'String'));
isi=str2num(get(handles.ISI,'String'));
winstart=str2num(get(handles.WinStart,'String'));
windur=str2num(get(handles.WinDur,'String'));

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

nbisis=nbstims-1;

if nbisis>0
onsets=[winstart:isi:winstart+(isi*nbisis)]
offsets=[winstart+windur:isi:winstart+windur+(isi*nbisis)]
else
    onsets=winstart;
    offsets=winstart+windur;
end;
    
for k=TracesToApply
    
    %naming:
    nametoparse=SpikeTraceData(k).Label.ListText;
    a=strfind(nametoparse,'X:');
    ipos=a+2;
    b=strfind(nametoparse,'Y:');
    jpos=b+2;
    numcharsi=jpos-ipos-3;
    
    istr=nametoparse(ipos:ipos+numcharsi-1)
    jstr=nametoparse(jpos:length(nametoparse))
    %
    
    %% event amplitudes (max of psth within event)
    if getmax
        up=1; %max
        starttime=SpikeTraceData(k).XVector(1)
        maxs=extevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,up,handles)
        
        SpikeTraceData(BeginTrace+n).XVector=1:1:length(maxs);
        SpikeTraceData(BeginTrace+n).Trace=maxs;
        SpikeTraceData(BeginTrace+n).DataSize=length(maxs);
        
        name=['PSTH maxima X:' istr ' Y:' jstr];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel='maxima (Hz)';
        SpikeTraceData(BeginTrace+n).Label.XLabel='';
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
        
        n=n+1;
    end
    %% event amplitudes (min of psth within event)
    if getmin
        up=0; %min
        starttime=SpikeTraceData(k).XVector(1)
        mins=extevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,up,handles)
        
        SpikeTraceData(BeginTrace+n).XVector=1:1:length(mins);
        SpikeTraceData(BeginTrace+n).Trace=mins;
        SpikeTraceData(BeginTrace+n).DataSize=length(mins);
        
        name=['PSTH minima X:' istr ' Y:' jstr];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel='minima (Hz)';
        SpikeTraceData(BeginTrace+n).Label.XLabel='';
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
        
        n=n+1;
    end
    %% event average activity level (avg of psth within event)
    if getavg
        starttime=SpikeTraceData(k).XVector(1)
        averages=avgevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,up,handles)
        
        SpikeTraceData(BeginTrace+n).XVector=1:1:length(averages);
        SpikeTraceData(BeginTrace+n).Trace=averages;
        SpikeTraceData(BeginTrace+n).DataSize=length(averages);
        
        name=['PSTH averages X:' istr ' Y:' jstr];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel='average (Hz)';
        SpikeTraceData(BeginTrace+n).Label.XLabel='';
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
        
        n=n+1;
    end
    %%
    
end
 
ValidateValues_Callback(hObject, eventdata, handles);


%% this function returns extreme value of original vector (ie psth) during each event (between onsets and offsets)

function extremes=extevents(onsets,offsets,psth,starttime,up,handles)

if onsets(1)<offsets(1)
    
    if up
        lengthtouse=min(length(onsets),length(offsets));
        for i=1:lengthtouse
            extremes(i)=max(psth(onsets(i)-starttime:offsets(i)-starttime));
        end
    else
        for i=1:length(onsets)
            extremes(i)=min(psth(onsets(i)-starttime:offsets(i)-starttime));
        end
    end
    
else
    msgbox('Onsets are not preceding Offsets, try something else.','Warning','error');
end


%% this function returns average value of original vector (ie psth) during each event (between onsets and offsets)

function averages=avgevents(onsets,offsets,psth,starttime,up,handles)

if onsets(1)<offsets(1)
    
        lengthtouse=min(length(onsets),length(offsets));
        for i=1:lengthtouse
            averages(i)=mean(psth(onsets(i)-starttime:offsets(i)-starttime));
        end
    
else
    msgbox('Onsets are not preceding Offsets, try something else.','Warning','error');
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


function StartBin_Callback(hObject, eventdata, handles)
% hObject    handle to StartBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBin as text
%        str2double(get(hObject,'String')) returns contents of StartBin as a double


% --- Executes during object creation, after setting all properties.
function StartBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopBin_Callback(hObject, eventdata, handles)
% hObject    handle to StopBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBin as text
%        str2double(get(hObject,'String')) returns contents of StopBin as a double


% --- Executes during object creation, after setting all properties.
function StopBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetMax.
function GetMax_Callback(hObject, eventdata, handles)
% hObject    handle to GetMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GetMax


% --- Executes on button press in GetAvg.
function GetAvg_Callback(hObject, eventdata, handles)
% hObject    handle to GetAvg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GetAvg



function StartBinBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to StartBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBinBaseline as text
%        str2double(get(hObject,'String')) returns contents of StartBinBaseline as a double


% --- Executes during object creation, after setting all properties.
function StartBinBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopBinBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to StopBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBinBaseline as text
%        str2double(get(hObject,'String')) returns contents of StopBinBaseline as a double


% --- Executes during object creation, after setting all properties.
function StopBinBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Baseline.
function Baseline_Callback(hObject, eventdata, handles)
% hObject    handle to Baseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    TracesToApply=1:length(SpikeTraceData);
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end

startbin=str2double(get(handles.StartBinBaseline,'String'));
stopbin=str2double(get(handles.StopBinBaseline,'String'));

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

bsavg=zeros(1,length(TracesToApply));
bsstd=zeros(1,length(TracesToApply));

i=1;

for k=TracesToApply
    
    firstbin=SpikeTraceData(k).XVector(1);
    
    bsavg(i)=mean(SpikeTraceData(k).Trace(startbin-firstbin+1:stopbin-firstbin));
    bsstd(i)=std(SpikeTraceData(k).Trace(startbin-firstbin+1:stopbin-firstbin));
    
    set(handles.BaselineAvg,'String',num2str(bsavg(i),3));
    set(handles.BaselineStd,'String',num2str(bsstd(i),3));
    i=i+1;
    
end

SpikeTraceData(BeginTrace+n).XVector=1:1:length(bsavg);
SpikeTraceData(BeginTrace+n).Trace=bsavg;
SpikeTraceData(BeginTrace+n).DataSize=length(bsavg);

name=['PSTH baseline averages, bins ' int2str(startbin) ' to ' int2str(stopbin)];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='baseline avg (Hz)';
SpikeTraceData(BeginTrace+n).Label.XLabel='psth nb.';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
n=n+1;

SpikeTraceData(BeginTrace+n).XVector=1:1:length(bsstd);
SpikeTraceData(BeginTrace+n).Trace=bsstd;
SpikeTraceData(BeginTrace+n).DataSize=length(bsstd);

name=['PSTH baseline stds, bins ' int2str(startbin) ' to ' int2str(stopbin)];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='baseline std (Hz)';
SpikeTraceData(BeginTrace+n).Label.XLabel='psth nb.';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
n=n+1;
   
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace2{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);
end


% --- Executes on button press in SubstractBaseline.
function SubstractBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to SubstractBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    msgbox('Select specific traces, do not use ''all''.','Warning','error');
    return;
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end
TracesToApply2=get(handles.TraceSelector2,'Value'); %trace with baselines

z=1;
BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

for k=TracesToApply

SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(k).XVector;
SpikeTraceData(BeginTrace+n).Trace=SpikeTraceData(k).Trace-SpikeTraceData(TracesToApply2).Trace(z); %substract baseline
SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(k).DataSize;

name=['-baseline avg ' SpikeTraceData(k).Label.ListText];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
n=n+1;

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end

z=z+1;
end

% --- Executes on button press in GetMin.
function GetMin_Callback(hObject, eventdata, handles)
% hObject    handle to GetMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GetMin



function NbStims_Callback(hObject, eventdata, handles)
% hObject    handle to NbStims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbStims as text
%        str2double(get(hObject,'String')) returns contents of NbStims as a double


% --- Executes during object creation, after setting all properties.
function NbStims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbStims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ISI_Callback(hObject, eventdata, handles)
% hObject    handle to ISI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ISI as text
%        str2double(get(hObject,'String')) returns contents of ISI as a double


% --- Executes during object creation, after setting all properties.
function ISI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ISI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function WinStart_Callback(hObject, eventdata, handles)
% hObject    handle to WinStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WinStart as text
%        str2double(get(hObject,'String')) returns contents of WinStart as a double


% --- Executes during object creation, after setting all properties.
function WinStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WinStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function WinDur_Callback(hObject, eventdata, handles)
% hObject    handle to WinDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WinDur as text
%        str2double(get(hObject,'String')) returns contents of WinDur as a double


% --- Executes during object creation, after setting all properties.
function WinDur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WinDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
