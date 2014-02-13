function varargout = Get_Baseline_Rate_from_Stitched_File(varargin)
% GET_BASELINE_RATE_FROM_STITCHED_FILE M-file for Get_Baseline_Rate_from_Stitched_File.fig
%      GET_BASELINE_RATE_FROM_STITCHED_FILE, by itself, creates a new GET_BASELINE_RATE_FROM_STITCHED_FILE or raises the existing
%      singleton*.
%
%      H = GET_BASELINE_RATE_FROM_STITCHED_FILE returns the handle to a new GET_BASELINE_RATE_FROM_STITCHED_FILE or the handle to
%      the existing singleton*.
%
%      GET_BASELINE_RATE_FROM_STITCHED_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GET_BASELINE_RATE_FROM_STITCHED_FILE.M with the given input arguments.
%
%      GET_BASELINE_RATE_FROM_STITCHED_FILE('Property','Value',...) creates a new GET_BASELINE_RATE_FROM_STITCHED_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Get_Baseline_Rate_from_Stitched_File_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Get_Baseline_Rate_from_Stitched_File_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Get_Baseline_Rate_from_Stitched_File

% Last Modified by GUIDE v2.5 05-Mar-2013 14:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Get_Baseline_Rate_from_Stitched_File_OpeningFcn, ...
                   'gui_OutputFcn',  @Get_Baseline_Rate_from_Stitched_File_OutputFcn, ...
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


% --- Executes just before Get_Baseline_Rate_from_Stitched_File is made visible.
function Get_Baseline_Rate_from_Stitched_File_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Get_Baseline_Rate_from_Stitched_File (see VARARGIN)

global SpikeTraceData;
global savefile;
global savefile_epstart;
global savefile_eplast;

% set(handles.SavingFilename,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\072612\cell1\psths');
% handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\072612\cell1\psths';

if isempty(savefile)
    savename=cd;
else
    savename=[savefile '_ep' num2str(savefile_epstart) '-' num2str(savefile_eplast) '_baseline.mat'];
end

set(handles.SavingFilename,'String',savename);
handles.Filename=savename;


% Choose default command line output for Get_Baseline_Rate_from_Stitched_File
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Get_Baseline_Rate_from_Stitched_File wait for user response (see UIRESUME)
% uiwait(handles.figure1);


TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelectorStim,'String',TextTrace);
    set(handles.TraceSelectorSpikes,'String',TextTrace);
    set(handles.TraceSelectorPlot,'String',TextTrace);
end

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelectorStim,'String',Settings.TraceSelectorStimString);
%     set(handles.TraceSelectorStim,'Value',Settings.TraceSelectorStimValue);
%     set(handles.TraceSelectorSpikes,'String',Settings.TraceSelectorSpikesString);
%     set(handles.TraceSelectorSpikes,'Value',Settings.TraceSelectorSpikesValue);
%     set(handles.TraceSelectorPlot,'String',Settings.TraceSelectorPlotString);
%     set(handles.TraceSelectorPlot,'Value',Settings.TraceSelectorPlotValue);

end


% --- Outputs from this function are returned to the command line.
function varargout = Get_Baseline_Rate_from_Stitched_File_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorStimString=get(handles.TraceSelectorStim,'String');
Settings.TraceSelectorStimValue=get(handles.TraceSelectorStim,'Value');
Settings.TraceSelectorSpikesString=get(handles.TraceSelectorSpikes,'String');
Settings.TraceSelectorSpikesValue=get(handles.TraceSelectorSpikes,'Value');
Settings.TraceSelectorPlotString=get(handles.TraceSelectorPlot,'String');
Settings.TraceSelectorPlotValue=get(handles.TraceSelectorPlot,'Value');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;
global savefile;
global savefile_epstart;
global savefile_eplast;

TraceStim=get(handles.TraceSelectorStim,'Value');
TraceSpikes=get(handles.TraceSelectorSpikes,'Value');
TracePlot=get(handles.TraceSelectorPlot,'Value');

firststimtime=SpikeTraceData(TraceStim).XVector(1); %time in sec
firststimbin=floor(firststimtime*1000); %for 1ms bins
nbspikes=sum(SpikeTraceData(TraceSpikes).Trace(1:firststimbin-1));
baserate=nbspikes/(firststimtime-0.001);

set(handles.BaselineRate,'String',[num2str(baserate) ' Hz']);

% Update handles structure
guidata(hObject, handles);

endind=floor(firststimtime/(SpikeTraceData(TracePlot).XVector(2)-SpikeTraceData(TracePlot).XVector(1)));
figure
plot(SpikeTraceData(TracePlot).XVector(1:endind),SpikeTraceData(TracePlot).Trace(1:endind));


BeginTrace=length(SpikeTraceData)+1;
SpikeTraceData(BeginTrace).XVector=1;
SpikeTraceData(BeginTrace).Trace=baserate;
SpikeTraceData(BeginTrace).DataSize=1;

newname=['baseline rate, 0 to ' num2str(firststimtime) ' s'];
SpikeTraceData(BeginTrace).Label.ListText=newname;
SpikeTraceData(BeginTrace).Label.YLabel='Hz';
SpikeTraceData(BeginTrace).Label.XLabel='';
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(TracePlot).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(TracePlot).Path;


OldData=SpikeTraceData;
SpikeTraceData=SpikeTraceData(BeginTrace);
save(handles.Filename,'SpikeTraceData');

SpikeTraceData=OldData;







% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


% --- Executes on selection change in TraceSelectorStim.
function TraceSelectorStim_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorStim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorStim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorStim


% --- Executes during object creation, after setting all properties.
function TraceSelectorStim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorStim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectorSpikes.
function TraceSelectorSpikes_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorSpikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorSpikes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorSpikes


% --- Executes during object creation, after setting all properties.
function TraceSelectorSpikes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorSpikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectorPlot.
function TraceSelectorPlot_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorPlot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorPlot


% --- Executes during object creation, after setting all properties.
function TraceSelectorPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GetFilename_Callback(hObject, eventdata, handles)
% hObject    handle to GetFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Oldpath=cd;

[pathname,filename,ext]=fileparts(handles.Filename)
cd(pathname);

% Open file path
[filename, pathname] = uiputfile( ...
    {'*.mat','All Files (*.mat)'},'Select Data File');

cd(Oldpath);

% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
else
    totname=[pathname filename];
    set(handles.SavingFilename,'String',totname);
    handles.Filename=totname;
    guidata(hObject,handles);
    
end
