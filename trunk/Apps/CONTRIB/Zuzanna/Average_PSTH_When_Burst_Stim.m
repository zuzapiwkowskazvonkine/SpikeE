function varargout = Average_PSTH_When_Burst_Stim(varargin)
% AVERAGE_PSTH_WHEN_BURST_STIM M-file for Average_PSTH_When_Burst_Stim.fig
%      AVERAGE_PSTH_WHEN_BURST_STIM, by itself, creates a new AVERAGE_PSTH_WHEN_BURST_STIM or raises the existing
%      singleton*.
%
%      H = AVERAGE_PSTH_WHEN_BURST_STIM returns the handle to a new AVERAGE_PSTH_WHEN_BURST_STIM or the handle to
%      the existing singleton*.
%
%      AVERAGE_PSTH_WHEN_BURST_STIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVERAGE_PSTH_WHEN_BURST_STIM.M with the given input arguments.
%
%      AVERAGE_PSTH_WHEN_BURST_STIM('Property','Value',...) creates a new AVERAGE_PSTH_WHEN_BURST_STIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Average_PSTH_When_Burst_Stim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Average_PSTH_When_Burst_Stim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Average_PSTH_When_Burst_Stim

% Last Modified by GUIDE v2.5 05-Dec-2012 18:21:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Average_PSTH_When_Burst_Stim_OpeningFcn, ...
                   'gui_OutputFcn',  @Average_PSTH_When_Burst_Stim_OutputFcn, ...
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


% --- Executes just before Average_PSTH_When_Burst_Stim is made visible.
function Average_PSTH_When_Burst_Stim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Average_PSTH_When_Burst_Stim (see VARARGIN)

% Choose default command line output for Average_PSTH_When_Burst_Stim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Average_PSTH_When_Burst_Stim wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);
    set(handles.BurstPeriod,'String',Settings.BinsizeString);
    set(handles.FirstBin,'String',Settings.FirstBinString);
    set(handles.NbReps,'String',Settings.NbRepsString);
       
end

TextTrace{1}='All Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end


% --- Outputs from this function are returned to the command line.
function varargout = Average_PSTH_When_Burst_Stim_OutputFcn(hObject, eventdata, handles) 
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
Settings.BurstPeriodString=get(handles.BurstPeriod,'String');
Settings.FirstBinString=get(handles.FirstBin,'String');
Settings.NbRepsString=get(handles.NbReps,'String');

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

%%%%%%%%%%%%%

burstperiod=str2double(get(handles.BurstPeriod,'String')); %in ms
burstonset=str2double(get(handles.FirstBin,'String'));
nbreps=str2double(get(handles.NbReps,'String'));

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

h=waitbar(0,'Averaging...');
for k=TracesToApply

time0=SpikeTraceData(k).XVector(1);
avgburst_evoked=AverageBurst(SpikeTraceData(k).Trace,time0,burstperiod,nbreps,burstonset,handles);
avgburst_spont=AverageBurst(SpikeTraceData(k).Trace,time0,-burstperiod,nbreps,burstonset,handles);

avgburst=[avgburst_spont; avgburst_evoked];
global test_avgburst
test_avgburst=avgburst;

SpikeTraceData(BeginTrace+n).XVector=-burstperiod:1:burstperiod-1;
SpikeTraceData(BeginTrace+n).Trace=avgburst;
SpikeTraceData(BeginTrace+n).DataSize=length(avgburst);

name=['burst avg ' SpikeTraceData(k).Label.ListText];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;

n=n+1;
waitbar(k/length(TracesToApply));
 
end

close(h);
ValidateValues_Callback(hObject, eventdata, handles);

% this function does the big job, ie averaging succesive fragments
% of a psth, each fragment being of burstperiod size, starting from time burstonset
% (and going in either direction from burstonset depending on burstperiod sign)

function avgpsth=AverageBurst(psth,time0,burstperiod,nbreps,burstonset,handles)

t1=burstonset-time0
t2=t1+burstperiod-1*sign(burstperiod)
sum=zeros(abs(burstperiod),1);

for k=1:nbreps   
    sum=sum+psth(min(t1,t2):max(t1,t2));   %use min/max so that burstperiod can be positive as well as negative
    t1=t1+burstperiod;
    t2=t2+burstperiod;
end

avgpsth=sum/nbreps;





% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


function BurstPeriod_Callback(hObject, eventdata, handles)
% hObject    handle to BurstPeriod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BurstPeriod as text
%        str2double(get(hObject,'String')) returns contents of BurstPeriod as a double


% --- Executes during object creation, after setting all properties.
function BurstPeriod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BurstPeriod (see GCBO)
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


% --- Executes on key press with focus on TraceSelector and none of its controls.
function TraceSelector_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function FirstBin_Callback(hObject, eventdata, handles)
% hObject    handle to FirstBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstBin as text
%        str2double(get(hObject,'String')) returns contents of FirstBin as a double


% --- Executes during object creation, after setting all properties.
function FirstBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NbReps_Callback(hObject, eventdata, handles)
% hObject    handle to NbReps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbReps as text
%        str2double(get(hObject,'String')) returns contents of NbReps as a double


% --- Executes during object creation, after setting all properties.
function NbReps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbReps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
