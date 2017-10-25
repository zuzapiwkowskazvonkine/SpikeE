function varargout = Load_LFP_puff_loom(varargin)
%LOAD_LFP_PUFF_LOOM M-file for Load_LFP_puff_loom.fig
%      LOAD_LFP_PUFF_LOOM, by itself, creates a new LOAD_LFP_PUFF_LOOM or raises the existing
%      singleton*.
%
%      H = LOAD_LFP_PUFF_LOOM returns the handle to a new LOAD_LFP_PUFF_LOOM or the handle to
%      the existing singleton*.
%
%      LOAD_LFP_PUFF_LOOM('Property','Value',...) creates a new LOAD_LFP_PUFF_LOOM using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Load_LFP_puff_loom_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      LOAD_LFP_PUFF_LOOM('CALLBACK') and LOAD_LFP_PUFF_LOOM('CALLBACK',hObject,...) call the
%      local function named CALLBACK in LOAD_LFP_PUFF_LOOM.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Load_LFP_puff_loom

% Last Modified by GUIDE v2.5 17-Oct-2017 15:39:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Load_LFP_puff_loom_OpeningFcn, ...
                   'gui_OutputFcn',  @Load_LFP_puff_loom_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Load_LFP_puff_loom is made visible.
function Load_LFP_puff_loom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Load_LFP_puff_loom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Load_LFP_puff_loom wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% We get the input settings to restore state if needed
if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.FilenameShow,'String',Settings.FilenameShowString);
    set(handles.TraceSelectionList,'String',Settings.TraceSelectionListString);
    set(handles.TraceSelectionList,'Value',Settings.TraceSelectionListValue);
    set(handles.LoadBehSelect,'Value',Settings.LoadBehSelectValue);
    set(handles.LoadBehSelect,'String',Settings.LoadBehSelectString);
    %set(handles.SelectAllTrace,'Value',Settings.SelectAllTraceValue);
end

set(handles.SelectAllTrace,'Value',1);
set(handles.SelectAllTrace,'Enable','off');
    
SelectAllTrace_Callback(hObject, eventdata, handles);

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.FilenameShowString=get(handles.FilenameShow,'String');
Settings.TraceSelectionListString=get(handles.TraceSelectionList,'String');
Settings.TraceSelectionListValue=get(handles.TraceSelectionList,'Value');
Settings.LoadBehSelectValue=get(handles.LoadBehSelect,'Value');
Settings.LoadBehSelectString=get(handles.LoadBehSelect,'String');
% Settings.SelectAllTraceValue=get(handles.SelectAllTrace,'Value');


% --- Outputs from this function are returned to the command line.
function varargout = Load_LFP_puff_loom_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;


% initialize stitched trace
% SpikeTraceData(BeginTrace).DataSize=tot_size;
% SpikeTraceData(BeginTrace).Trace=zeros(tot_size,1);
% SpikeTraceData(BeginTrace).XVector=zeros(tot_size,1);

%name='stitched';
% SpikeTraceData(BeginTrace).Label.ListText=name;
% SpikeTraceData(BeginTrace).Label.YLabel=SpikeTraceData(TracesToApply(1)).Label.YLabel;
% SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(TracesToApply(1)).Label.XLabel;
% SpikeTraceData(BeginTrace).Filename=SpikeTraceData(TracesToApply(1)).Filename;
% SpikeTraceData(BeginTrace).Path=SpikeTraceData(TracesToApply(1)).Path;

try
    InterfaceObj=findobj(handles.output,'Enable','on');
    set(InterfaceObj,'Enable','off');
    
    if (get(handles.LoadBehSelect,'Value')==1)
        InitTraces();
        BeginTrace=1;
    else
        BeginTrace=length(SpikeTraceData)+1;
    end
    
    h=waitbar(0,'loading data...');
    LocalFile=get(handles.FilenameShow,'String');
    [pth,fl,ex]=fileparts(LocalFile);
       
    if exist('matfile')==2
        matObj = matfile(LocalFile);
        info=whos(matObj);
    else
        info=whos('-file',LocalFile);
    end
    
    NumberTrace=sum(~cellfun('isempty',{info.name}));
    
    % always load all the variables, no possibility to select here:
    ListTraceToLoad=1:NumberTrace;
    
    NbNewTraces=5; %given the structure of the loaded data
    
    if exist('matfile')==2
        matObj = matfile(LocalFile);
          
        SpikeTraceData(BeginTrace).Trace=matObj.LFP_data;
        SpikeTraceData(BeginTrace).XVector=0.001*matObj.LFP_times; %converting to seconds
        SpikeTraceData(BeginTrace).DataSize=length(matObj.LFP_data);
        SpikeTraceData(BeginTrace).Label.ListText='LFP';
        SpikeTraceData(BeginTrace).Label.YLabel='mV';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=matObj.speed_data;
        SpikeTraceData(BeginTrace).XVector=0.001*matObj.speed_times; %converting to seconds
        SpikeTraceData(BeginTrace).DataSize=length(matObj.speed_data);
        SpikeTraceData(BeginTrace).Label.ListText='speed';
        SpikeTraceData(BeginTrace).Label.YLabel='cm/s';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=matObj.loom_diameter;
        SpikeTraceData(BeginTrace).XVector=matObj.loom_times; %already in seconds
        SpikeTraceData(BeginTrace).DataSize=length(matObj.loom_diameter);
        SpikeTraceData(BeginTrace).Label.ListText='loom diam';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=matObj.loom_positionvert;
        SpikeTraceData(BeginTrace).XVector=matObj.loom_times; %already in seconds
        SpikeTraceData(BeginTrace).DataSize=length(matObj.loom_positionvert);
        SpikeTraceData(BeginTrace).Label.ListText='loom position vert';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=ones(1,length(matObj.event_times));
        SpikeTraceData(BeginTrace).XVector=0.001*matObj.event_times; %converting to seconds
        SpikeTraceData(BeginTrace).DataSize=length(matObj.event_times);
        SpikeTraceData(BeginTrace).Label.ListText='airpuffs';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
     
        
    else
        Tmp=load(LocalFile);
        
        SpikeTraceData(BeginTrace).Trace=Tmp.LFP_data;
        SpikeTraceData(BeginTrace).XVector=0.001*Tmp.LFP_times; %converting to seconds
        SpikeTraceData(BeginTrace).DataSize=length(Tmp.LFP_data);
        SpikeTraceData(BeginTrace).Label.ListText='LFP';
        SpikeTraceData(BeginTrace).Label.YLabel='mV';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=Tmp.speed_data;
        SpikeTraceData(BeginTrace).XVector=0.001*Tmp.speed_times; %converting to seconds
        SpikeTraceData(BeginTrace).DataSize=length(Tmp.speed_data);
        SpikeTraceData(BeginTrace).Label.ListText='speed';
        SpikeTraceData(BeginTrace).Label.YLabel='cm/s';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=Tmp.loom_diameter;
        SpikeTraceData(BeginTrace).XVector=Tmp.loom_times; %already in seconds
        SpikeTraceData(BeginTrace).DataSize=length(Tmp.loom_diameter);
        SpikeTraceData(BeginTrace).Label.ListText='loom diam';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=Tmp.loom_positionvert;
        SpikeTraceData(BeginTrace).XVector=Tmp.loom_times; %already in seconds
        SpikeTraceData(BeginTrace).DataSize=length(Tmp.loom_positionvert);
        SpikeTraceData(BeginTrace).Label.ListText='loom position vert';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
        BeginTrace=BeginTrace+1;
        
        SpikeTraceData(BeginTrace).Trace=ones(1,length(Tmp.event_times));
        SpikeTraceData(BeginTrace).XVector=0.001*Tmp.event_times; %already in seconds
        SpikeTraceData(BeginTrace).DataSize=length(Tmp.event_times);
        SpikeTraceData(BeginTrace).Label.ListText='airpuffs';
        SpikeTraceData(BeginTrace).Label.YLabel='a.u.';
        SpikeTraceData(BeginTrace).Label.XLabel='s';
        SpikeTraceData(BeginTrace).Filename=fl;
        SpikeTraceData(BeginTrace).Path=pth;
    end
    
    delete(h);
    
 
    
    ValidateValues_Callback(hObject, eventdata, handles);
    set(InterfaceObj,'Enable','on');
    
catch errorObj
    set(InterfaceObj,'Enable','on');
    
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
    if exist('h','var')
        if ishandle(h)
            delete(h);
        end
    end
end



% --- Executes on button press in SelectFile.
function SelectFile_Callback(hObject, eventdata, handles)
% hObject    handle to SelectFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;


% Open file path
[filename, pathname] = uigetfile( ...
    {'*.mat','All Files (*.mat)'},'Select MAT File');

% Open file if exist
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
    
    % Otherwise construct the fullfilename and Check and load the file
else
    % To keep the path accessible to futur request
    cd(pathname);
    try
        InterfaceObj=findobj(handles.output,'Enable','on');
        set(InterfaceObj,'Enable','off');
        h=waitbar(0,'Checking data...');
        
        LocalFile=fullfile(pathname,filename);
        
        if exist('matfile')==2
            matObj = matfile(LocalFile);
            info=whos(matObj);
        else
            info=whos('-file',LocalFile);
        end
        
        if ~isempty(info)
            
            for i=1:sum(~cellfun('isempty',{info.name})); % total number of variable names
                TextTrace{i}=[,info(i).name];
            end
            set(handles.FilenameShow,'String',LocalFile);
            set(handles.TraceSelectionList,'String',TextTrace);
        else
            msgbox('No variables in this file');
        end
        
        delete(h);
        set(InterfaceObj,'Enable','on');
        
    catch errorObj
        set(InterfaceObj,'Enable','on');
        % If there is a problem, we display the error message
        errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
        if exist('h','var')
            if ishandle(h)
                delete(h);
            end
        end
    end
end

% --- Executes on selection change in LoadBehSelect.
function LoadBehSelect_Callback(hObject, eventdata, handles)
% hObject    handle to LoadBehSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LoadBehSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LoadBehSelect


% --- Executes during object creation, after setting all properties.
function LoadBehSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadBehSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectionList.
function TraceSelectionList_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectionList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectionList


% --- Executes during object creation, after setting all properties.
function TraceSelectionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectAllTrace.
function SelectAllTrace_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectAllTrace
% Hint: get(hObject,'Value') returns toggle state of SelectAllTrace
if (get(handles.SelectAllTrace,'Value')==1)
    set(handles.TraceSelectionList,'Enable','off');
else
    set(handles.TraceSelectionList,'Enable','on');
end
