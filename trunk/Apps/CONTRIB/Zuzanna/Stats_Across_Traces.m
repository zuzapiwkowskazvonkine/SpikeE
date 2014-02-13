function varargout = Stats_Across_Traces(varargin)
% STATS_ACROSS_TRACES M-file for Stats_Across_Traces.fig
%      STATS_ACROSS_TRACES, by itself, creates a new STATS_ACROSS_TRACES or raises the existing
%      singleton*.
%
%      H = STATS_ACROSS_TRACES returns the handle to a new STATS_ACROSS_TRACES or the handle to
%      the existing singleton*.
%
%      STATS_ACROSS_TRACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATS_ACROSS_TRACES.M with the given input arguments.
%
%      STATS_ACROSS_TRACES('Property','Value',...) creates a new STATS_ACROSS_TRACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Stats_Across_Traces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Stats_Across_Traces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Stats_Across_Traces

% Last Modified by GUIDE v2.5 16-Oct-2012 14:54:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Stats_Across_Traces_OpeningFcn, ...
                   'gui_OutputFcn',  @Stats_Across_Traces_OutputFcn, ...
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


% --- Executes just before Stats_Across_Traces is made visible.
function Stats_Across_Traces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Stats_Across_Traces (see VARARGIN)

% Choose default command line output for Stats_Across_Traces
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Stats_Across_Traces wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;


if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);

    set(handles.Average,'Value',Settins.AverageValue);
    set(handles.Stdev,'Value',Settings.StdevValue);
    set(handles.Sem,'Value',Settings.SemValue);
    set(handles.Range,'Value',Settings.RangeValue);
    set(handles.DisplayStep,'String',Settings.DisplayStepString);
    set(handles.SaveFigs,'Value',Settings.SaveFigsValue); 
    set(handles.UseOriginalPath,'Value',Settings.UseOriginalPathValue);
    set(handles.PathText,'String',Settings.PathTextString);
    
    handles.Path=Settings.Path;
    handles.BasalFile=Settings.BasalFile;
    guidata(hObject,handles);

    UseOriginalPath_Callback(hObject, eventdata, handles);
    
    handles=guidata(hObject);
else

     if ~isempty(SpikeTraceData)
        
        if ~isempty(SpikeTraceData(1).Path) && 0<exist(SpikeTraceData(1).Path,'dir')
            handles.Path=SpikeTraceData(1).Path;
        else
            handles.Path=cd;
        end
        
        set(handles.PathText,'String',handles.Path);
        
        if ~isempty(SpikeTraceData(1).Filename)
            handles.BasalFile=SpikeTraceData(1).Filename;
        else
            handles.BasalFile='Trace.mat';
        end
        
        guidata(hObject, handles);
     end
      
end


TextTrace{1}='All Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=['Trace ',num2str(i)];
    end
    set(handles.TraceSelector,'String',TextTrace);
end


% --- Outputs from this function are returned to the command line.
function varargout = Stats_Across_Traces_OutputFcn(hObject, eventdata, handles) 
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
Settins.AverageValue=get(handles.Average,'Value');
Settings.StdevValue=get(handles.Stdev,'Value');
Settings.SemValue=get(handles.Sem,'Value');
Settings.RangeValue=get(handles.Range,'Value');
Settings.DisplayStepString=get(handles.DisplayStep,'String');
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.SaveFigsValue=get(handles.SaveFigs,'Value');
Settings.UseOriginalPathValue=get(handles.UseOriginalPath,'Value');
Settings.PathTextString=get(handles.PathText,'String');
Settings.Path=handles.Path;
Settings.BasalFile=handles.BasalFile;



% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;
global savefile_epstart;
global savefile_eplast;
global Data;

if (get(handles.TraceSelector,'Value')==1)
    TracesToApply=1:length(SpikeTraceData);
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end

%%%%%%%%%%%%%

step=str2double(get(handles.DisplayStep,'String'));
avg=get(handles.Average,'Value');
stdv=get(handles.Stdev,'Value');
sem=get(handles.Sem,'Value');
rangeb=get(handles.Range,'Value');
savefigs=get(handles.SaveFigs,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

% h=waitbar(0,'Processing...');

Data=zeros(1,SpikeTraceData(TracesToApply(1)).DataSize);
size(Data)

for k=TracesToApply
   Data=vertcat(Data, SpikeTraceData(k).Trace'); 
end

Data(1,:)=[];

    if avg
              
        SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(TracesToApply(1)).XVector;
        SpikeTraceData(BeginTrace+n).Trace=mean(Data);
        SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(TracesToApply(1)).DataSize;
        
        name=['avg ' int2str(TracesToApply(1)) '-' int2str(TracesToApply(end))];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(TracesToApply(1)).Label.YLabel;
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(TracesToApply(1)).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesToApply(1)).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesToApply(1)).Path;
        
        n=n+1;
        % waitbar(k/length(TracesToApply)); 
        
        figure(336)
        plot(SpikeTraceData(BeginTrace+n-1).Trace,'r')
        hold on
        
    end
    
    if stdv
              
        SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(TracesToApply(1)).XVector;
        SpikeTraceData(BeginTrace+n).Trace=std(Data);
        SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(TracesToApply(1)).DataSize;
        
        name=['std ' int2str(TracesToApply(1)) '-' int2str(TracesToApply(end))];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(TracesToApply(1)).Label.YLabel;
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(TracesToApply(1)).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesToApply(1)).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesToApply(1)).Path;
        
        n=n+1;
        % waitbar(k/length(TracesToApply));   
        figure(336)
        plot(SpikeTraceData(BeginTrace+n-1).Trace,'k')
        hold on
        
    end
    
      if sem
              
        SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(TracesToApply(1)).XVector;
        SpikeTraceData(BeginTrace+n).Trace=std(Data)/sqrt(size(Data,1));
        SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(TracesToApply(1)).DataSize;
        
        name=['sem ' int2str(TracesToApply(1)) '-' int2str(TracesToApply(end))];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(TracesToApply(1)).Label.YLabel;
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(TracesToApply(1)).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesToApply(1)).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesToApply(1)).Path;
        
        n=n+1;
        % waitbar(k/length(TracesToApply));   
        figure(336)
        plot(SpikeTraceData(BeginTrace+n-1).Trace,'m')
        hold on
        
    end

      if rangeb
              
        SpikeTraceData(BeginTrace+n).XVector=SpikeTraceData(TracesToApply(1)).XVector;
        % SpikeTraceData(BeginTrace+n).Trace=range(Data); 
        % Statistics Toolbox required
        
        mintraces=min(Data);
        maxtraces=max(Data);
        SpikeTraceData(BeginTrace+n).Trace=maxtraces-mintraces;
        
        SpikeTraceData(BeginTrace+n).DataSize=SpikeTraceData(TracesToApply(1)).DataSize;
        
        name=['range ' int2str(TracesToApply(1)) '-' int2str(TracesToApply(end))];
        SpikeTraceData(BeginTrace+n).Label.ListText=name;
        SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(TracesToApply(1)).Label.YLabel;
        SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(TracesToApply(1)).Label.XLabel;
        SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(TracesToApply(1)).Filename;
        SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(TracesToApply(1)).Path;
        
        n=n+1;
        % waitbar(k/length(TracesToApply));   
        
        figure(336)
        plot(SpikeTraceData(BeginTrace+n-1).Trace,'g')
        hold off
        
    end

% close(h);




if savefigs
[path,basefile,ext] = fileparts(handles.BasalFile);
 basename=[handles.Path '\' basefile '_ep' int2str(savefile_epstart) '-' int2str(savefile_eplast)]
%  basename=[savefile '_ep' int2str(savefile_epstart) '-' int2str(savefile_eplast)]
 fig_fig=[basename '_stats_across_traces' '.fig'];
 fig_tiff=[basename '_stats_across_traces' '.tif'];
 print(336,'-dtiff',fig_tiff);
 saveas(336,fig_fig);
end

ValidateValues_Callback(hObject, eventdata, handles);





% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


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


% --- Executes on button press in Average.
function Average_Callback(hObject, eventdata, handles)
% hObject    handle to Average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Average


% --- Executes on button press in Stdev.
function Stdev_Callback(hObject, eventdata, handles)
% hObject    handle to Stdev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Stdev


% --- Executes on button press in Sem.
function Sem_Callback(hObject, eventdata, handles)
% hObject    handle to Sem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Sem


% --- Executes on button press in Range.
function Range_Callback(hObject, eventdata, handles)
% hObject    handle to Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Range



function DisplayStep_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DisplayStep as text
%        str2double(get(hObject,'String')) returns contents of DisplayStep as a double


% --- Executes during object creation, after setting all properties.
function DisplayStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DisplayStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveFigs.
function SaveFigs_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFigs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveFigs


% --- Executes on button press in UseOriginalPath.
function UseOriginalPath_Callback(hObject, eventdata, handles)
% hObject    handle to UseOriginalPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseOriginalPath

global SpikeTraceData;

if (get(handles.UseOriginalPath,'Value')==1)
    set(handles.PathText,'String',SpikeTraceData(1).Path);
    handles.Path=SpikeTraceData(1).Path;
    guidata(hObject,handles);
end

% --- Executes on button press in ChangePath.
function ChangePath_Callback(hObject, eventdata, handles)
% hObject    handle to ChangePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Oldpath=cd;

cd(handles.Path);

% Open directory interface
NewPath=uigetdir(handles.Path);

cd(Oldpath);

% If "Cancel" is selected then return
if isequal(NewPath,0)
    return
else
    handles.Path=NewPath;
    set(handles.PathText,'String',NewPath);
    set(handles.UseOriginalPath,'Value',0);
    guidata(hObject,handles);
    CreateFileName(hObject, handles);
end
