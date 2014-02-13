function varargout = Convert_Hz_To_SpikeNbs(varargin)
% CONVERT_HZ_TO_SPIKENBS M-file for Convert_Hz_To_SpikeNbs.fig
%      CONVERT_HZ_TO_SPIKENBS, by itself, creates a new CONVERT_HZ_TO_SPIKENBS or raises the existing
%      singleton*.
%
%      H = CONVERT_HZ_TO_SPIKENBS returns the handle to a new CONVERT_HZ_TO_SPIKENBS or the handle to
%      the existing singleton*.
%
%      CONVERT_HZ_TO_SPIKENBS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_HZ_TO_SPIKENBS.M with the given input arguments.
%
%      CONVERT_HZ_TO_SPIKENBS('Property','Value',...) creates a new CONVERT_HZ_TO_SPIKENBS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Convert_Hz_To_SpikeNbs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Convert_Hz_To_SpikeNbs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Convert_Hz_To_SpikeNbs

% Last Modified by GUIDE v2.5 04-Dec-2012 16:25:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Convert_Hz_To_SpikeNbs_OpeningFcn, ...
                   'gui_OutputFcn',  @Convert_Hz_To_SpikeNbs_OutputFcn, ...
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


% --- Executes just before Convert_Hz_To_SpikeNbs is made visible.
function Convert_Hz_To_SpikeNbs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Convert_Hz_To_SpikeNbs (see VARARGIN)

% Choose default command line output for Convert_Hz_To_SpikeNbs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Convert_Hz_To_SpikeNbs wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
% %     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);
set(handles.Binsize,'String',Settings.BinsizeString);        
end

TextTrace{1}='All Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end


% --- Outputs from this function are returned to the command line.
function varargout = Convert_Hz_To_SpikeNbs_OutputFcn(hObject, eventdata, handles) 
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
Settings.BinsizeString=get(handles.Binsize,'String');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

binsize=str2double(get(handles.Binsize,'String'))/1000; %convert into sec the param in ms

if (get(handles.TraceSelector,'Value')==1)
    TracesToApply=1:length(SpikeTraceData);
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end

%%%%%%%%%%%%%

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter
nb_trials=zeros(1,length(TracesToApply));

h=waitbar(0,'Converting...');
for k=TracesToApply

[converted_psth,step]=Convert(SpikeTraceData(k).Trace,handles);

SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(k).XVector;
SpikeTraceData(BeginTrace+n).Trace=converted_psth;
SpikeTraceData(BeginTrace+n).DataSize=length(converted_psth);

name=['spike nbs ' SpikeTraceData(k).Label.ListText];
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='nb of events';
SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;


n=n+1;

if step>0
    nb_trials(n)=round(1/(step*binsize)); %for 1ms=0.001s bin size
    nbt=nb_trials(n);
else
    nb_trials(n)=0;
    nbt=nb_trials(n);
end
    
waitbar(k/length(TracesToApply));
 
end

SpikeTraceData(BeginTrace+n).XVector=1:1:length(nb_trials);
SpikeTraceData(BeginTrace+n).Trace=nb_trials;
SpikeTraceData(BeginTrace+n).DataSize=length(nb_trials);

name='nbs of trials for each psth';
SpikeTraceData(BeginTrace+n).Label.ListText=name;
SpikeTraceData(BeginTrace+n).Label.YLabel='nb of trials';
SpikeTraceData(BeginTrace+n).Label.XLabel='psth nb';
SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesToApply(1)).Filename;
SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesToApply(1)).Path;


set(handles.OneSpikeInHz,'String',num2str(step));
set(handles.NbTrials,'String',num2str(nbt));

close(h);
% ValidateValues_Callback(hObject, eventdata, handles);

% this function does the big job, ie extracting the value in Hz
% corresponding to 1 spike first (1 "quantum" or "step" in the psth),
% then converting the whole psth to spike numbers.

function [conv_psth,step]=Convert(psth,handles)

steps=diff(unique(psth));
step=min(steps(steps>1));

if step>0
    conv_psth=round(psth/step);
else
    conv_psth=psth;
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
