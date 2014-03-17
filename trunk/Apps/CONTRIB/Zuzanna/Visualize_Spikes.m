function varargout = Visualize_Spikes(varargin)
% VISUALIZE_SPIKES M-file for Visualize_Spikes.fig
%      VISUALIZE_SPIKES, by itself, creates a new VISUALIZE_SPIKES or raises the existing
%      singleton*.
%
%      H = VISUALIZE_SPIKES returns the handle to a new VISUALIZE_SPIKES or the handle to
%      the existing singleton*.
%
%      VISUALIZE_SPIKES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALIZE_SPIKES.M with the given input arguments.
%
%      VISUALIZE_SPIKES('Property','Value',...) creates a new VISUALIZE_SPIKES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Visualize_Spikes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Visualize_Spikes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Visualize_Spikes

% Last Modified by GUIDE v2.5 04-Mar-2014 17:04:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Visualize_Spikes_OpeningFcn, ...
                   'gui_OutputFcn',  @Visualize_Spikes_OutputFcn, ...
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


% --- Executes just before Visualize_Spikes is made visible.
function Visualize_Spikes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Visualize_Spikes (see VARARGIN)

% Choose default command line output for Visualize_Spikes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Visualize_Spikes wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.MinISI,'String',Settings.MinISIString);
%     set(handles.Extract,'Value',Settings.ExtractValue);
set(handles.Start_Window,'String',Settings.StartWindowString);
set(handles.End_Window,'String',Settings.EndWindowString);
set(handles.AlignThresh,'Value',Settings.AlignThreshValue);
set(handles.AlignMin,'Value',Settings.AlignMinValue);
set(handles.AlignMax,'Value',Settings.AlignMaxValue);
set(handles.Durms,'String',Settings.DurmsString);

end

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace);
end

global FigureCount;
FigureCount=0;
    
% --- Outputs from this function are returned to the command line.
function varargout = Visualize_Spikes_OutputFcn(hObject, eventdata, handles) 
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
Settings.StartWindowString=get(handles.Start_Window,'String');
Settings.EndWindowString=get(handles.End_Window,'String');
Settings.AlignThreshValue=get(handles.AlignThresh,'Value');
Settings.AlignMinValue=get(handles.AlignMin,'Value');
Settings.AlignMaxValue=get(handles.AlignMax,'Value');
Settings.DurmsString=get(handles.Durms,'String');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;
global FigureCount;


warning('off','MATLAB:colon:nonIntegerIndex');

TracesToApply=get(handles.TraceSelector,'Value');
EphysTrace=get(handles.TraceSelector2,'Value');


startwin=str2double(get(handles.Start_Window,'String'));
endwin=str2double(get(handles.End_Window,'String'));

alignthresh=get(handles.AlignThresh,'Value');
alignmin=get(handles.AlignMin,'Value');
alignmax=get(handles.AlignMax,'Value');

durms=str2double(get(handles.Durms,'String'));
dur=durms/1000; %same in sec

%%%%%%%%%%%%%
colortable{1}='r';
colortable{2}='b';
colortable{3}='g';
colortable{4}='m';
colortable{5}='y';

% dx=SpikeTraceData(EphysTrace).XVector(2)-SpikeTraceData(EphysTrace).XVector(1);
% 1/dx

clustnum=1;

sizetrace=length(SpikeTraceData(EphysTrace).Trace);

listfigs=[];

nbfigs=length(TracesToApply);

for f=1:nbfigs
    if alignthresh
        figure(100+f+FigureCount);
        clf;
        set(gcf,'Visible', 'off');
        listfigs(end+1)=gcf;
    end
    if alignmin
        figure(200+f+FigureCount);
        clf;
        set(gcf,'Visible', 'off');
        listfigs(end+1)=gcf;
    end
    if alignmax
        figure(300+f+FigureCount);
        clf;
        set(gcf,'Visible', 'off');
        listfigs(end+1)=gcf;
    end
end


for k=TracesToApply
    
    threshCrossings=double(SpikeTraceData(k).XVector);
    
    %restrict to the chosen analysis window:
    keepcrossinds=find((threshCrossings>=startwin)&(threshCrossings<=endwin));
    threshCrossings=threshCrossings(keepcrossinds);
    
    traceTimes=double(SpikeTraceData(EphysTrace).XVector);
    
    logInds=ismember(traceTimes, threshCrossings);
    crossInds=1:length(traceTimes);
    crossInds=crossInds(logInds);
    clear logInds traceTimes threshCrossings
    
    
    for n=1:length(crossInds)
        
        for f=1:nbfigs
            
            if f==clustnum
                colorstr=colortable{f};
                bottom=0;
            else
                colorstr='k';
                bottom=1;
            end
            
            if alignthresh
                figure(100+f+FigureCount);
                set(gcf,'Visible', 'off'); 
                
                cInd=crossInds(n);
                if (cInd>30*durms/2) && (cInd+30*durms/2<=sizetrace)
                    h=plot(SpikeTraceData(EphysTrace).Trace(cInd-durms*30/2:cInd+durms*30/2),colorstr);
                    hold on
                    if bottom
                        uistack(h,'bottom');
                    end
                end
                
            end
            
            
            if alignmin
                %             imins=zeros(length(crossInds));
             
                    cInd=crossInds(n);
                    [amin,imin]=min(SpikeTraceData(EphysTrace).Trace(cInd:cInd+durms*30/2));
                    %                 imins(n)=imin;
                    
                    figure(200+f+FigureCount)
                    set(gcf,'Visible', 'off');
                    
                    %put Vm of all peaks at 0 by substracting amin from
                    %whole trace
                    
                    if (cInd+imin-1>30*durms/2) && (cInd+imin-1+30*durms/2<=sizetrace)
                        h=plot(SpikeTraceData(EphysTrace).Trace(cInd+imin-1-durms*30/2:cInd+imin-1+durms*30/2)-amin,colorstr);
                        hold on
                        if bottom
                            uistack(h,'bottom');
                        end
                    end
                    
                
            end
            
            if alignmax
                %             imaxs=zeros(length(crossInds));
                
                    cInd=crossInds(n);
                    [amax,imax]=max(SpikeTraceData(EphysTrace).Trace(cInd:cInd+durms*30/2));
                    %                 imaxs(n)=imax;
                    figure(300+f+FigureCount)
                    set(gcf,'Visible', 'off');
                    
                    if (cInd+imax-1>30*durms/2) && (cInd+imax-1+30*durms/2<=sizetrace)
                        h=plot(SpikeTraceData(EphysTrace).Trace(cInd+imax-1-durms*30/2:cInd+imax-1+durms*30/2)-amax,colorstr);
                        hold on
                        if bottom
                            uistack(h,'bottom');
                        end
                    end
             
            end
            
            
        end
    end
    
    clustnum=clustnum+1;
    clear crossInds
end

for f=1:length(listfigs)
    figure(listfigs(f));
    set(gcf,'Visible', 'on');
end

FigureCount=FigureCount+nbfigs;

% ValidateValues_Callback(hObject, eventdata, handles);



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



function Start_Window_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Window as text
%        str2double(get(hObject,'String')) returns contents of Start_Window as a double


% --- Executes during object creation, after setting all properties.
function Start_Window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function End_Window_Callback(hObject, eventdata, handles)
% hObject    handle to End_Window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Window as text
%        str2double(get(hObject,'String')) returns contents of End_Window as a double


% --- Executes during object creation, after setting all properties.
function End_Window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold as text
%        str2double(get(hObject,'String')) returns contents of Threshold as a double


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AlignThresh.
function AlignThresh_Callback(hObject, eventdata, handles)
% hObject    handle to AlignThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AlignThresh


% --- Executes on button press in AlignMin.
function AlignMin_Callback(hObject, eventdata, handles)
% hObject    handle to AlignMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AlignMin


% --- Executes on button press in AlignMax.
function AlignMax_Callback(hObject, eventdata, handles)
% hObject    handle to AlignMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AlignMax



function Durms_Callback(hObject, eventdata, handles)
% hObject    handle to Durms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Durms as text
%        str2double(get(hObject,'String')) returns contents of Durms as a double


% --- Executes during object creation, after setting all properties.
function Durms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Durms (see GCBO)
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
