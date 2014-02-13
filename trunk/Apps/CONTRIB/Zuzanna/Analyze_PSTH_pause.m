function varargout = Analyze_PSTH_pause(varargin)
% ANALYZE_PSTH_PAUSE M-file for Analyze_PSTH_pause.fig
%      ANALYZE_PSTH_PAUSE, by itself, creates a new ANALYZE_PSTH_PAUSE or raises the existing
%      singleton*.
%
%      H = ANALYZE_PSTH_PAUSE returns the handle to a new ANALYZE_PSTH_PAUSE or the handle to
%      the existing singleton*.
%
%      ANALYZE_PSTH_PAUSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZE_PSTH_PAUSE.M with the given input arguments.
%
%      ANALYZE_PSTH_PAUSE('Property','Value',...) creates a new ANALYZE_PSTH_PAUSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analyze_PSTH_pause_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analyze_PSTH_pause_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analyze_PSTH_pause

% Last Modified by GUIDE v2.5 25-Oct-2012 11:08:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analyze_PSTH_pause_OpeningFcn, ...
                   'gui_OutputFcn',  @Analyze_PSTH_pause_OutputFcn, ...
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


% --- Executes just before Analyze_PSTH_pause is made visible.
function Analyze_PSTH_pause_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analyze_PSTH_pause (see VARARGIN)

% Choose default command line output for Analyze_PSTH_pause
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analyze_PSTH_pause wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;


if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
    set(handles.CrossType1,'String',Settings.CrossType1String);
    set(handles.CrossType1,'Value',Settings.CrossType1Value);
    set(handles.Threshold1,'String',Settings.Threshold1String);
    set(handles.CrossType2,'String',Settings.CrossType2String);
    set(handles.CrossType2,'Value',Settings.CrossType2Value);
    set(handles.Threshold2,'String',Settings.Threshold2String);
    set(handles.StartBin,'String',Settings.StartBinString);
    set(handles.StopBin,'String',Settings.StopBinString);
    set(handles.Up,'Value',Settings.UpValue);
    set(handles.Down,'Value',Settings.DownValue);
    set(handles.NbStd,'String',Settings.NbStdString);
    set(handles.StartBinBaseline,'String',Settings.StartBinBaselineString);
    set(handles.StopBinBaseline,'String',Settings.StopBinBaselineString);
    set(handles.UseThreshVector,'Value',Settings.UseThreshVectorValue);   
end

TextTrace{1}='All Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace2{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace3{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);
    set(handles.TraceSelector3,'String',TextTrace3);
end


% --- Outputs from this function are returned to the command line.
function varargout = Analyze_PSTH_pause_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelector4String=get(handles.TraceSelector4,'String');
Settings.TraceSelector4Value=get(handles.TraceSelector4,'Value');
Settings.CrossType1String=get(handles.CrossType1,'String');
Settings.CrossType1Value=get(handles.CrossType1,'Value');
Settings.Threshold1String=get(handles.Threshold1,'String');
Settings.CrossType2String=get(handles.CrossType2,'String');
Settings.CrossType2Value=get(handles.CrossType2,'Value');
Settings.Threshold2String=get(handles.Threshold2,'String');
Settings.StartBinString=get(handles.StartBin,'String'); 
Settings.StopBinString=get(handles.StopBin,'String');
Settings.UpValue=get(handles.Up,'Value');
Settings.DownValue=get(handles.Down,'Value');
Settings.NbStdString=get(handles.NbStd,'String');
Settings.StartBinBaselineString=get(handles.StartBinBaseline,'String');
Settings.StopBinBaselineString=get(handles.StopBinBaseline,'String');
Settings.UseThreshVectorValue=get(handles.UseThreshVector,'Value');

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

TracesWithThresholds=get(handles.TraceSelector4,'Value');

%%%%%%%%%%%%%

thresh1=str2double(get(handles.Threshold1,'String'));
CrossType1Contents=cellstr(get(handles.CrossType1, 'String'));
CrossType1=CrossType1Contents{get(handles.CrossType1, 'Value')};

thresh2=str2double(get(handles.Threshold2,'String'));
CrossType2Contents=cellstr(get(handles.CrossType2, 'String'));
CrossType2=CrossType2Contents{get(handles.CrossType2, 'Value')};

startbin=str2double(get(handles.StartBin,'String'));
stopbin=str2double(get(handles.StopBin,'String'));

up=get(handles.Up,'Value');
down=get(handles.Down,'Value');

usethreshvec=get(handles.UseThreshVector,'Value');

if strcmp(CrossType1, 'low-to-high')
    lowhigh1=1;
elseif strcmp(CrossType1, 'high-to-low')
    lowhigh1=0;
end

if strcmp(CrossType2, 'low-to-high')
    lowhigh2=1;
elseif strcmp(CrossType2, 'high-to-low')
    lowhigh2=0;
end
 
%  lowhigh1
%  lowhigh2

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter
i=1;

h=waitbar(0,'Detecting crossings...');
for k=TracesToApply
    
    firstbin=SpikeTraceData(k).XVector(1);
    CutTrace=SpikeTraceData(k).Trace(startbin-firstbin+1:stopbin-firstbin+1);
    CutXVector=SpikeTraceData(k).XVector(startbin-firstbin+1:stopbin-firstbin+1);
    %
    % times1=Thresh_Cross(SpikeTraceData(k).Trace,SpikeTraceData(k).XVector',thresh1,lowhigh1,handles);
    % times2=Thresh_Cross(SpikeTraceData(k).Trace,SpikeTraceData(k).XVector',thresh2,lowhigh2,handles);
    
    if usethreshvec==1
       thresh1=SpikeTraceData(TracesWithThresholds).Trace(i); 
       thresh2=SpikeTraceData(TracesWithThresholds).Trace(i); 
    end
    
    times1=Thresh_Cross(CutTrace,CutXVector',thresh1,lowhigh1,handles);
    times2=Thresh_Cross(CutTrace,CutXVector',thresh2,lowhigh2,handles);
    
    if length(times1)>0 && length(times2)>0
        
        %naming of resulting traces:
        
        nametoparse=SpikeTraceData(k).Label.ListText;
        a=strfind(nametoparse,'X:');
        ipos=a+2;
        b=strfind(nametoparse,'Y:');
        jpos=b+2;
        
        numcharsi=jpos-ipos-3;
            
        istr=nametoparse(ipos:ipos+numcharsi-1)
        jstr=nametoparse(jpos:length(nametoparse))
           
        SpikeTraceData(BeginTrace+n).XVector=times1;
        SpikeTraceData(BeginTrace+n).Trace=ones(size(times1));
        SpikeTraceData(BeginTrace+n).DataSize=length(times1);
        
        name=['PSTH threshold 1 crossings X:' istr ' Y:' jstr];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel='detections';
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
        
        n=n+1;
        
        SpikeTraceData(BeginTrace+n).XVector=times2;
        SpikeTraceData(BeginTrace+n).Trace=ones(size(times2));
        SpikeTraceData(BeginTrace+n).DataSize=length(times2);
        
        name=['PSTH threshold 2 crossings X:' istr ' Y:' jstr];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel='detections';
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
        
        n=n+1;
        
        
        if up %onsets are lowtohigh crossings, offsets are hightolow
            
            %% event durations
            if lowhigh1==1
                onsets=times1;
                offsets=times2;
            else
                onsets=times2;
                offsets=times1;
            end
            
            eventdurations_up=diff2vecs(onsets,offsets,handles);
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(eventdurations_up);
            SpikeTraceData(BeginTrace+n).Trace=eventdurations_up;
            SpikeTraceData(BeginTrace+n).DataSize=length(eventdurations_up);
            
            name=['PSTH up durations X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='up durations (ms)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
            %% event amplitudes (max of psth within event)
            
            starttime=SpikeTraceData(k).XVector(1)
            extremes_up=extevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,up,handles)
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(extremes_up);
            SpikeTraceData(BeginTrace+n).Trace=extremes_up;
            SpikeTraceData(BeginTrace+n).DataSize=length(extremes_up);
            
            name=['PSTH up maxima X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='up maxima (Hz)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
            %% event average activity level (avg of psth within event)
            
            starttime=SpikeTraceData(k).XVector(1)
            averages_up=avgevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,up,handles)
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(averages_up);
            SpikeTraceData(BeginTrace+n).Trace=averages_up;
            SpikeTraceData(BeginTrace+n).DataSize=length(averages_up);
            
            name=['PSTH up averages X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='up average (Hz)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
            %%
            
        end
        
        if down %onsets are hightolow crossings, offsets are lowtohigh
            
            if lowhigh1==1
                onsets=times2;
                offsets=times1;
            else
                onsets=times1;
                offsets=times2;
            end
            
            eventdurations_down=diff2vecs(onsets,offsets,handles);
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(eventdurations_down);
            SpikeTraceData(BeginTrace+n).Trace=eventdurations_down;
            SpikeTraceData(BeginTrace+n).DataSize=length(eventdurations_down);
            
            name=['PSTH down durations X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='down durations (ms)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
            %% event amplitudes (max of psth within event)
            
            starttime=SpikeTraceData(k).XVector(1)
            extremes_down=extevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,0,handles)
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(extremes_down);
            SpikeTraceData(BeginTrace+n).Trace=extremes_down;
            SpikeTraceData(BeginTrace+n).DataSize=length(extremes_down);
            
            name=['PSTH down minima X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='down minima (Hz)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
            %% event average activity level (avg of psth within event)
            
            starttime=SpikeTraceData(k).XVector(1)
            averages_down=avgevents(onsets,offsets,SpikeTraceData(k).Trace,starttime,0,handles)
            
            SpikeTraceData(BeginTrace+n).XVector=1:1:length(averages_down);
            SpikeTraceData(BeginTrace+n).Trace=averages_down;
            SpikeTraceData(BeginTrace+n).DataSize=length(averages_down);
            
            name=['PSTH down average X:' istr ' Y:' jstr];
            SpikeTraceData(BeginTrace+n).Label.ListText=name;
            SpikeTraceData(BeginTrace+n).Label.YLabel='down average (Hz)';
            SpikeTraceData(BeginTrace+n).Label.XLabel='';
            SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
            
            n=n+1;
            
        end
        
        waitbar(k/length(TracesToApply));
        
    end
    i=i+1;
end

close(h);

ValidateValues_Callback(hObject, eventdata, handles);

% this function returns durations of events based on vectors of event
% onsets and offsets
function durations=diff2vecs(onsets,offsets,handles)

%check that first offset happens AFTER first onset:

if onsets(1)<offsets(1)
     
    lengthtouse=min(length(onsets),length(offsets));
    durations=offsets(1:lengthtouse)-onsets(1:lengthtouse);
       
else
    msgbox('Onsets are not preceding Offsets, try something else.','Warning','error');
end

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
    
    if up
        lengthtouse=min(length(onsets),length(offsets));
        for i=1:lengthtouse
            averages(i)=mean(psth(onsets(i)-starttime:offsets(i)-starttime));
        end
    else
        for i=1:length(onsets)
            averages(i)=mean(psth(onsets(i)-starttime:offsets(i)-starttime));
        end
    end
    
else
    msgbox('Onsets are not preceding Offsets, try something else.','Warning','error');
end



% this function does the big job, ie detecting threshold1 crossings in a trace,
% and creating a new trace (times) holding spike times 

function times=Thresh_Cross(trace,timepts,thresh,lowhigh,handles)

m2=[timepts trace];

clear th;

if lowhigh==1
    %low-to-high threshold crossings
    th = m2((m2(:,2)>thresh),1); %get all times (from m2(:,1)) when signal in m2 (m2(:,2)) is ABOVE threshold thresh
elseif lowhigh==0
    %high-to-low threshold crossings
    th = m2((m2(:,2)<thresh),1); %get all times (from m2(:,1)) when signal in m2 (m2(:,2)) is BELOW threshold thresh
end

jump = 1; %minimal interval between 2 pts of th such that these 2 pts belong to 2 diff. thresh crossings



if size(th)>0
    th_shift=zeros(length(th));
    th_shift = th(2:size(th),1); % th shifted 1 point to the left
    th_shift(length(th),1)=th(length(th),1); % duplicate last point of th to have same lenth vectors (assumes no threshold crossing on last datapoint;
    % such event could never be confirmed to be a spike anyway )
    
    th_m = [th th_shift];
    
    times = th_m(((th_m(:,2)-th_m(:,1))>jump),2); %threshold crossing times("jumps" in th)
    
    if lowhigh==1 && trace(1)<thresh
        times(size(times,1)+1,1) = th(1,1); % the first threshold crossing time is necessarily a spike onset
    end
    
    if lowhigh==0 && trace(1)>thresh
        times(size(times,1)+1,1) = th(1,1);
    end
    
    times = sort(times);
    
    global thtest
    global thmtest
    thtest=th;
    thmtest=th_m;
    
else
    times=[];
end

    




% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function Threshold1_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold1 as text
%        str2double(get(hObject,'String')) returns contents of Threshold1 as a double


% --- Executes during object creation, after setting all properties.
function Threshold1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CrossType1.
function CrossType1_Callback(hObject, eventdata, handles)
% hObject    handle to CrossType1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CrossType1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CrossType1



% --- Executes during object creation, after setting all properties.
function CrossType1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CrossType1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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


function Dur_Crossings_Callback(hObject, eventdata, handles)
% hObject    handle to Dur_Crossings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dur_Crossings as text
%        str2double(get(hObject,'String')) returns contents of Dur_Crossings as a double


% --- Executes during object creation, after setting all properties.
function Dur_Crossings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dur_Crossings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Threshold2_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold2 as text
%        str2double(get(hObject,'String')) returns contents of Threshold2 as a double


% --- Executes during object creation, after setting all properties.
function Threshold2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CrossType2.
function CrossType2_Callback(hObject, eventdata, handles)
% hObject    handle to CrossType2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CrossType2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CrossType2


% --- Executes during object creation, after setting all properties.
function CrossType2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CrossType2 (see GCBO)
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


% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Up


% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Down



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
        TextTrace3{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);
    set(handles.TraceSelector3,'String',TextTrace3);
end


% --- Executes on button press in SetThresholds.
function SetThresholds_Callback(hObject, eventdata, handles)
% hObject    handle to SetThresholds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    msgbox('Select specific traces, do not use ''all''.','Warning','error');
    return;
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end
TracesToApply2=get(handles.TraceSelector2,'Value');
TracesToApply3=get(handles.TraceSelector3,'Value');

nbstd=str2double(get(handles.NbStd,'String'));

i=1;
for k=TracesToApply
    threshstd(i)=nbstd*SpikeTraceData(TracesToApply2).Trace(i)+SpikeTraceData(TracesToApply3).Trace(i);
    i=i+1;
end

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

SpikeTraceData(BeginTrace+n).XVector=1:1:length(threshstd);
SpikeTraceData(BeginTrace+n).Trace=threshstd;
SpikeTraceData(BeginTrace+n).DataSize=length(threshstd);

name=['PSTH response thresholds, mean+std*' int2str(nbstd)];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='response thresholds (Hz)';
SpikeTraceData(BeginTrace+n).Label.XLabel='psth nb.';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
n=n+1;

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace4{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector4,'String',TextTrace4);
end



function NbStd_Callback(hObject, eventdata, handles)
% hObject    handle to NbStd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbStd as text
%        str2double(get(hObject,'String')) returns contents of NbStd as a double


% --- Executes during object creation, after setting all properties.
function NbStd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbStd (see GCBO)
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


% --- Executes on selection change in TraceSelector4.
function TraceSelector4_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector4


% --- Executes during object creation, after setting all properties.
function TraceSelector4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseThreshVector.
function UseThreshVector_Callback(hObject, eventdata, handles)
% hObject    handle to UseThreshVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseThreshVector
