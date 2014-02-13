function varargout = Remove_CSs_from_Total_Detections(varargin)
% REMOVE_CSS_FROM_TOTAL_DETECTIONS M-file for Remove_CSs_from_Total_Detections.fig
%      REMOVE_CSS_FROM_TOTAL_DETECTIONS, by itself, creates a new REMOVE_CSS_FROM_TOTAL_DETECTIONS or raises the existing
%      singleton*.
%
%      H = REMOVE_CSS_FROM_TOTAL_DETECTIONS returns the handle to a new REMOVE_CSS_FROM_TOTAL_DETECTIONS or the handle to
%      the existing singleton*.
%
%      REMOVE_CSS_FROM_TOTAL_DETECTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_CSS_FROM_TOTAL_DETECTIONS.M with the given input arguments.
%
%      REMOVE_CSS_FROM_TOTAL_DETECTIONS('Property','Value',...) creates a new REMOVE_CSS_FROM_TOTAL_DETECTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_CSs_from_Total_Detections_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_CSs_from_Total_Detections_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_CSs_from_Total_Detections

% Last Modified by GUIDE v2.5 23-Nov-2012 17:18:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_CSs_from_Total_Detections_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_CSs_from_Total_Detections_OutputFcn, ...
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


% --- Executes just before Remove_CSs_from_Total_Detections is made visible.
function Remove_CSs_from_Total_Detections_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_CSs_from_Total_Detections (see VARARGIN)

% Choose default command line output for Remove_CSs_from_Total_Detections
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_CSs_from_Total_Detections wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.MinISI,'String',Settings.MinISIString);
%     set(handles.Extract,'Value',Settings.ExtractValue);
end

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    TextTrace{1}='All Traces';
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace);
end
% --- Outputs from this function are returned to the command line.
function varargout = Remove_CSs_from_Total_Detections_OutputFcn(hObject, eventdata, handles) 
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



% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    TracesToApplySS=1:length(SpikeTraceData);
else
    TracesToApplySS=get(handles.TraceSelector,'Value')-1;
end

if (get(handles.TraceSelector2,'Value')==1)
    TracesToApplyCS=1:length(SpikeTraceData);
else
    TracesToApplyCS=get(handles.TraceSelector2,'Value')-1;
end

%%%%%%%%%%%%%

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter
m=1;
h=waitbar(0,'Removing Complex Spikes...');
for k=TracesToApplySS
    
    [times_def,nb] = remtimes(SpikeTraceData(k).XVector,SpikeTraceData(TracesToApplyCS(m)).XVector, handles);
    
    SpikeTraceData(BeginTrace+n).XVector=times_def;
    SpikeTraceData(BeginTrace+n).Trace=ones(size(times_def));
    SpikeTraceData(BeginTrace+n).DataSize=length(times_def);
    
    name='SS time list, with CSs removed';
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='detections';
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
 
    
    n=n+1;
    m=m+1;
    
    
%     binsize=str2double(get(handles.Binsize,'String'))/1000; %convert binsize to sec
%     firstbin=str2double(get(handles.FirstBin,'String'));
%     
    binsize=1/1000; % 1ms in sec
    firstbin=0;
    
    binned_events=Digitize(SpikeTraceData(BeginTrace+n-1).XVector,binsize,firstbin,handles);
    
    SpikeTraceData(BeginTrace+n).XVector=firstbin:binsize:firstbin+binsize*(length(binned_events)-1);
    SpikeTraceData(BeginTrace+n).Trace=binned_events;
    SpikeTraceData(BeginTrace+n).DataSize=length(binned_events);
    
    name='binned events SS (CS removed)';
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='nb of events';
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(BeginTrace+n-1).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(BeginTrace+n-1).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(BeginTrace+n-1).Path;
    
    n=n+1;
  
    waitbar(k/length(TracesToApplySS));
    
end

close(h);

set(handles.Det_Nb,'String',int2str(nb));
% ValidateValues_Callback(hObject, eventdata, handles);



function [times_def, nb] = remtimes(timesSS,timesCS, handles)



% return remaining events in vector times_def
% return nb of removed events in nb

times_def = [];
rem_inds=[];
 
for k=1:length(timesCS)
   
    ind=find(timesSS==timesCS(k));
    if ~isempty(ind)
    rem_inds(end+1)=ind;
    end
    
end

times_def=timesSS;
times_def(rem_inds)=[];
nb=length(rem_inds);

function binned_events=Digitize(events,binsize,firstbin,handles)

last_time=events(end);
bins_with_event = floor((events-firstbin)/binsize);

start_time=firstbin;

    
bin_nb = floor((last_time-start_time+1)/binsize)+1;

binned_events=zeros(bin_nb,1);

    
    for k=1:length(bins_with_event)
        binned_events(bins_with_event(k)+1)=binned_events(bins_with_event(k)+1)+1;
    end;


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



function Det_Nb_Callback(hObject, eventdata, handles)
% hObject    handle to Det_Nb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Det_Nb as text
%        str2double(get(hObject,'String')) returns contents of Det_Nb as a double


% --- Executes during object creation, after setting all properties.
function Det_Nb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Det_Nb (see GCBO)
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

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
