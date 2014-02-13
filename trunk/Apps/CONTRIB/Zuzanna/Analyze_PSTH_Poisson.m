function varargout = Analyze_PSTH_Poisson(varargin)
% ANALYZE_PSTH_POISSON M-file for Analyze_PSTH_Poisson.fig
%      ANALYZE_PSTH_POISSON, by itself, creates a new ANALYZE_PSTH_POISSON or raises the existing
%      singleton*.
%
%      H = ANALYZE_PSTH_POISSON returns the handle to a new ANALYZE_PSTH_POISSON or the handle to
%      the existing singleton*.
%
%      ANALYZE_PSTH_POISSON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZE_PSTH_POISSON.M with the given input arguments.
%
%      ANALYZE_PSTH_POISSON('Property','Value',...) creates a new ANALYZE_PSTH_POISSON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analyze_PSTH_Poisson_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analyze_PSTH_Poisson_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analyze_PSTH_Poisson

% Last Modified by GUIDE v2.5 12-Dec-2012 17:28:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analyze_PSTH_Poisson_OpeningFcn, ...
                   'gui_OutputFcn',  @Analyze_PSTH_Poisson_OutputFcn, ...
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


% --- Executes just before Analyze_PSTH_Poisson is made visible.
function Analyze_PSTH_Poisson_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analyze_PSTH_Poisson (see VARARGIN)

% Choose default command line output for Analyze_PSTH_Poisson
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analyze_PSTH_Poisson wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.CrossType1,'String',Settings.CrossType1String);
%     set(handles.CrossType1,'Value',Settings.CrossType1Value);
%     set(handles.Threshold1,'String',Settings.Threshold1String);
%     set(handles.CrossType2,'String',Settings.CrossType2String);
%     set(handles.CrossType2,'Value',Settings.CrossType2Value);
%     set(handles.Threshold2,'String',Settings.Threshold2String);
%     set(handles.StartBin,'String',Settings.StartBinString);
%     set(handles.StopBin,'String',Settings.StopBinString);
    set(handles.Binsize,'String',Settings.BinsizeString);
    set(handles.Up,'Value',Settings.UpValue);
    set(handles.Down,'Value',Settings.DownValue);
%     set(handles.NbStd,'String',Settings.NbStdString);
    set(handles.StartBinBaseline,'String',Settings.StartBinBaselineString);
    set(handles.StopBinBaseline,'String',Settings.StopBinBaselineString);
%     set(handles.UseThreshVector,'Value',Settings.UseThreshVectorValue);  
    set(handles.NbRepsBurst,'String',Settings.NbRepsBurstString);
    set(handles.ThresholdSurprise,'String',Settings.ThresholdSurpriseString);
end


if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace3{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector3,'String',TextTrace3);
end


% --- Outputs from this function are returned to the command line.
function varargout = Analyze_PSTH_Poisson_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelector3String=get(handles.TraceSelector3,'String');
Settings.TraceSelector3Value=get(handles.TraceSelector3,'Value');
Settings.TraceSelector4String=get(handles.TraceSelector4,'String');
Settings.TraceSelector4Value=get(handles.TraceSelector4,'Value');
% Settings.CrossType1String=get(handles.CrossType1,'String');
% Settings.CrossType1Value=get(handles.CrossType1,'Value');
% Settings.Threshold1String=get(handles.Threshold1,'String');
% Settings.CrossType2String=get(handles.CrossType2,'String');
% Settings.CrossType2Value=get(handles.CrossType2,'Value');
% Settings.Threshold2String=get(handles.Threshold2,'String');
% Settings.StartBinString=get(handles.StartBin,'String'); 
% Settings.StopBinString=get(handles.StopBin,'String');
Settings.UpValue=get(handles.Up,'Value');
Settings.DownValue=get(handles.Down,'Value');
Settings.StartBinBaselineString=get(handles.StartBinBaseline,'String');
Settings.StopBinBaselineString=get(handles.StopBinBaseline,'String');
Settings.BinsizeString=get(handles.Binsize,'String');
% Settings.UseThreshVectorValue=get(handles.UseThreshVector,'Value');
Settings.NbRepsBurstString=get(handles.NbRepsBurst,'String');
Settings.ThresholdSurpriseString=get(handles.ThresholdSurprise,'String');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;


TracesToApply=get(handles.TraceSelector,'Value');
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


% --- Executes on button press in GetMeanRate.
function GetMeanRate_Callback(hObject, eventdata, handles)
% hObject    handle to GetMeanRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TracesToApply=get(handles.TraceSelector,'Value');
TraceNbTrials=get(handles.TraceSelector3,'Value');

startbin=str2double(get(handles.StartBinBaseline,'String'));
stopbin=str2double(get(handles.StopBinBaseline,'String'));
binsize=str2double(get(handles.Binsize,'String'))/1000; % ms converted to sec
nbreps=str2double(get(handles.NbRepsBurst,'String'));

bsavg=zeros(1,length(TracesToApply));
bsavghz=zeros(1,length(TracesToApply));
i=1;

for k=TracesToApply 
    firstbin=SpikeTraceData(k).XVector(1);   
    psth_order=k-TracesToApply(1)+1;  %eg for psths k=13,14,15, order will be 1,2,3
    bsavg(i)=mean(SpikeTraceData(k).Trace(startbin-firstbin+1:stopbin-firstbin)); % this is now in spike numbers per bin (for all trials)  
    if SpikeTraceData(TraceNbTrials).Trace(psth_order)>0
        bsavghz(i)=bsavg(i)/(nbreps*binsize*SpikeTraceData(TraceNbTrials).Trace(psth_order)); % and this is in Hz
    else
        bsavghz(i)=0;
    end
    i=i+1;  
end

bsavghzall=mean(bsavghz)
set(handles.BaselineAvg,'String',num2str(bsavghzall));


% --- Executes on button press in GetSurprise.
function GetSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to GetSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TracesToApply=get(handles.TraceSelector,'Value');
TraceNbTrials=get(handles.TraceSelector3,'Value');

bsmeanrate=str2double(get(handles.BaselineAvg,'String'))
binsize=str2double(get(handles.Binsize,'String'))/1000; %in sec
nbreps=str2double(get(handles.NbRepsBurst,'String'));

startbin=str2double(get(handles.StartBinBaseline,'String'));
stopbin=str2double(get(handles.StopBinBaseline,'String'));

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter
global baseline_vec
baseline_vec=[];
startbinind=startbin-SpikeTraceData(TracesToApply(1)).XVector(1)+1;
stopbinind=stopbin-SpikeTraceData(TracesToApply(1)).XVector(1)+1;

for k=TracesToApply
    
    psth_order=k-TracesToApply(1)+1;
    trialnb=SpikeTraceData(TraceNbTrials).Trace(psth_order);
    PoissonExpspikenb=bsmeanrate*binsize*trialnb*nbreps;
    
    for z=1:length(SpikeTraceData(k).Trace)
        m=SpikeTraceData(k).Trace(z); % this is for 1ms bins only
        tempsurprise=poissoncdf(PoissonExpspikenb,m);  %  m needs to be an integer (spike number, not possible to use an averaged spike number)
        
        if m>PoissonExpspikenb
            if tempsurprise>1-10^(-15)   %double precision limitation
            surprise(z)=15;
            else
            surprise(z)=-log10(1-tempsurprise); %big positive values will be Significant Increases in Firing
            end
        else
            surprise(z)=log10(tempsurprise);   %big negative values will be Significant Firing Suppressions
        end;
    end;
    
    for i=startbinind:stopbinind
    baseline_vec(end+1)=surprise(i);
    end
    
    % Surprise PSTH
    SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(k).XVector;
    SpikeTraceData(BeginTrace+n).Trace=surprise;
    SpikeTraceData(BeginTrace+n).DataSize=length(surprise);
    
    name=['surprise ' SpikeTraceData(k).Label.ListText(11:end)];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='Surprise';
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
    n=n+1;
    
    if ~isempty(SpikeTraceData)
        for i=1:length(SpikeTraceData)
            TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        end
        set(handles.TraceSelector,'String',TextTrace);
    end
  
end
  figure;
  hist(baseline_vec);
  set(handles.MaxBaselineSurprise,'String',num2str(max(baseline_vec)));

function out=poissoncdf(lambda,k)
% cumulative distribution function for the Poisson distribution (from Luc/Valerie's Elphy code)

sum=0;
temp=exp(-lambda);
for i=0:k
    sum = sum + temp;
    temp=temp*lambda/(i+1);  % temp is the next term to be added, at step i+1
end;
out=sum;



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
function TraceSelector4_CreateFcn(hObject, eventdata, ~)
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



function Binsize_Callback(hObject, eventdata, handles)
% hObject    handle to Binsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Binsize as text
%        str2double(get(hObject,'String')) returns contents of Binsize as a double


% --- Executes during object creation, after setting all properties.
function Binsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Binsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NbRepsBurst_Callback(hObject, eventdata, handles)
% hObject    handle to NbRepsBurst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbRepsBurst as text
%        str2double(get(hObject,'String')) returns contents of NbRepsBurst as a double


% --- Executes during object creation, after setting all properties.
function NbRepsBurst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbRepsBurst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Psth1_Callback(hObject, eventdata, handles)
% hObject    handle to Psth1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Psth1 as text
%        str2double(get(hObject,'String')) returns contents of Psth1 as a double


% --- Executes during object creation, after setting all properties.
function Psth1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Psth1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ThresholdSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ThresholdSurprise as text
%        str2double(get(hObject,'String')) returns contents of ThresholdSurprise as a double


% --- Executes during object creation, after setting all properties.
function ThresholdSurprise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThresholdSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetSignificantBins.
function GetSignificantBins_Callback(hObject, eventdata, handles)
% hObject    handle to GetSignificantBins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

threshsurp=str2double(get(handles.ThresholdSurprise,'String'));

TracesToApply=get(handles.TraceSelector,'Value');
% TraceNbTrials=get(handles.TraceSelector3,'Value');

% startbin=str2double(get(handles.StartBin,'String'));
% stopbin=str2double(get(handles.StopBin,'String'));
n=0; % new Trace counter
BeginTrace=length(SpikeTraceData)+1;

for k=TracesToApply
    
    if threshsurp>0
        signbins=getbinsabovethresh(threshsurp,SpikeTraceData(k).Trace);
    else
        signbins=getbinsbelowthresh(threshsurp,SpikeTraceData(k).Trace);
    end
    
    SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(k).XVector;
    SpikeTraceData(BeginTrace+n).Trace=signbins;
    SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(k).DataSize;
    
    name=['sign.' SpikeTraceData(k).Label.ListText];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='Bin significance';
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
    n=n+1;
end

  if ~isempty(SpikeTraceData)
        for i=1:length(SpikeTraceData)
            TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        end
        set(handles.TraceSelector4,'String',TextTrace);
        set(handles.TraceSelector5,'String',TextTrace);
    end


% 1 if bin is above threshold, 0 otherwise

function times=getbinsabovethresh(thresh,trace)

times=zeros(1,length(trace));

for i=1:length(trace)
   if trace(i)>= thresh
    times(i)=1; 
   end
end


function times=getbinsbelowthresh(thresh,trace)

times=zeros(1,length(trace));

for i=1:length(trace)
   if trace(i)<= thresh
    times(i)=1; 
   end
end


% --- Executes on selection change in TraceSelector5.
function TraceSelector5_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector5


% --- Executes during object creation, after setting all properties.
function TraceSelector5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetRespAmplitude.
function GetRespAmplitude_Callback(hObject, eventdata, handles)
% hObject    handle to GetRespAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TracesNbSpikes=get(handles.TraceSelector4,'Value');
TracesSign=get(handles.TraceSelector5,'Value');
TraceNbTrials=get(handles.TraceSelector3,'Value');

bsmeanrate=str2double(get(handles.BaselineAvg,'String'))
binsize=str2double(get(handles.Binsize,'String'))/1000; %in sec
nbreps=str2double(get(handles.NbRepsBurst,'String'));

n=0; % new Trace counter
BeginTrace=length(SpikeTraceData)+1;

TotRespSpikeNb=zeros(1,length(TracesNbSpikes));
RespSign=zeros(1,length(TracesNbSpikes));

i=1; % counter for TracesSign

for k=TracesNbSpikes
    
    psth_order=k-TracesNbSpikes(1)+1;
    trialnb=SpikeTraceData(TraceNbTrials).Trace(psth_order);
    PoissonExpspikenb=bsmeanrate*binsize*trialnb*nbreps   %expected number of spikes per bin under spont. Poisson hypothesis: to subtract from significant response bins.
    
    resp_only = times(SpikeTraceData(k).Trace'-PoissonExpspikenb,SpikeTraceData(TracesSign(i)).Trace);
    
    TotRespSpikeNb(i)=sum(resp_only)/trialnb;
    
    if TotRespSpikeNb(i)~=0
        RespSign(i)=1;
    end
    
    i=i+1;
end

SpikeTraceData(BeginTrace+n).XVector=1:1:length(TotRespSpikeNb);
SpikeTraceData(BeginTrace+n).Trace=TotRespSpikeNb;
SpikeTraceData(BeginTrace+n).DataSize=length(TotRespSpikeNb);

name='Total Nb of Spikes per Trial in Responsive Bins';
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='Spike Nb';
SpikeTraceData(BeginTrace+n).Label.XLabel='PSTH Nb';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesNbSpikes(1)).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesNbSpikes(1)).Path;

n=n+1;

SpikeTraceData(BeginTrace+n).XVector=1:1:length(RespSign);
SpikeTraceData(BeginTrace+n).Trace=RespSign;
SpikeTraceData(BeginTrace+n).DataSize=length(RespSign);

name='Response presence/absence';
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='Response presence';
SpikeTraceData(BeginTrace+n).Label.XLabel='PSTH Nb';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesNbSpikes(1)).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesNbSpikes(1)).Path;
