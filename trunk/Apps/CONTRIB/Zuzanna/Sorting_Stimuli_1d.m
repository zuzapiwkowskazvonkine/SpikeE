function varargout = Sorting_Stimuli_1d(varargin)
% SORTING_STIMULI_1D M-file for Sorting_Stimuli_1d.fig
%      SORTING_STIMULI_1D, by itself, creates a new SORTING_STIMULI_1D or raises the existing
%      singleton*.
%
%      H = SORTING_STIMULI_1D returns the handle to a new SORTING_STIMULI_1D or the handle to
%      the existing singleton*.
%
%      SORTING_STIMULI_1D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SORTING_STIMULI_1D.M with the given input arguments.
%
%      SORTING_STIMULI_1D('Property','Value',...) creates a new SORTING_STIMULI_1D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sorting_Stimuli_1d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sorting_Stimuli_1d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sorting_Stimuli_1d

% Last Modified by GUIDE v2.5 15-Oct-2012 11:29:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sorting_Stimuli_1d_OpeningFcn, ...
                   'gui_OutputFcn',  @Sorting_Stimuli_1d_OutputFcn, ...
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


% --- Executes just before Sorting_Stimuli_1d is made visible.
function Sorting_Stimuli_1d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sorting_Stimuli_1d (see VARARGIN)

% Choose default command line output for Sorting_Stimuli_1d
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sorting_Stimuli_1d wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;
global DLPstim

   if ~isempty(SpikeTraceData)
        for i=1:length(SpikeTraceData)
            TextTrace_Stims{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        end
        set(handles.TraceSelector_Stims,'String',TextTrace_Stims);
        set(handles.TraceSelector_Stims,'Value',5);
    end
    
    
    if ~isempty(SpikeTraceData)
        for i=1:length(SpikeTraceData)
            TextTrace_Spikes{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        end
        set(handles.TraceSelector_Spikes,'String',TextTrace_Spikes);
        set(handles.TraceSelector_Spikes,'Value',3);
    end

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector_Stims,'String',Settings.TraceSelectorStimsString);
%     set(handles.TraceSelector_Stims,'Value',Settings.TraceSelectorStimsValue);
% %     set(handles.TraceSelector_Spikes,'String',Settings.TraceSelectorSpikesString);
%     set(handles.TraceSelector_Spikes,'Value',Settings.TraceSelectorSpikesValue);
    set(handles.First_Stim,'String',Settings.FirstStimString);
    set(handles.Last_Stim,'String',Settings.LastStimString);
    set(handles.Prestim,'String',Settings.PrestimString);
    set(handles.Poststim,'String',Settings.PoststimString);
    set(handles.First_Stim_In_Detstim,'String',Settings.FirstStimInDetStimString);
    set(handles.DLPNotLoaded,'Value',Settings.DLPNotLoadedValue); 
    set(handles.SaveFigs,'Value',Settings.SaveFigsValue); 
    set(handles.UseOriginalPath,'Value',Settings.UseOriginalPathValue);
    set(handles.PathText,'String',Settings.PathTextString);
    

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
    else
        handles.Path=cd;
        handles.BasalFile='Trace.mat';
    end
     
    guidata(hObject,handles);

    UseOriginalPath_Callback(hObject, eventdata, handles);
    
    handles=guidata(hObject);
    
else

    if ~isempty(DLPstim)
        set(handles.Last_Stim,'String',size(DLPstim.SaveParam.Savedxin,2));
    else
        set(handles.DLPNotLoaded,'Value',1);
    end
    
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


% --- Outputs from this function are returned to the command line.
function varargout = Sorting_Stimuli_1d_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorStimsString=get(handles.TraceSelector_Stims,'String');
Settings.TraceSelectorStimsValue=get(handles.TraceSelector_Stims,'Value');
Settings.TraceSelectorSpikesString=get(handles.TraceSelector_Spikes,'String');
Settings.TraceSelectorSpikesValue=get(handles.TraceSelector_Spikes,'Value');
Settings.FirstStimString=get(handles.First_Stim,'String');
Settings.LastStimString=get(handles.Last_Stim,'String');
Settings.PrestimString=get(handles.Prestim,'String');
Settings.PoststimString=get(handles.Poststim,'String');
Settings.FirstStimInDetStimString=get(handles.First_Stim_In_Detstim,'String');
Settings.DLPNotLoadedValue=get(handles.DLPNotLoaded,'Value');
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
global DLPstim;
global savefile_epstart;
global savefile_eplast;
% global savefile;

TracesToApply_Stims=get(handles.TraceSelector_Stims,'Value');
TracesToApply_Spikes=get(handles.TraceSelector_Spikes,'Value');


%%%%%%%%%%%%%

first_stim=str2double(get(handles.First_Stim,'String'));
last_stim=str2double(get(handles.Last_Stim,'String'));
first_stim_in_detstim=str2double(get(handles.First_Stim_In_Detstim,'String')); %this is the rank of the stim in TracesToApply_Stims corresponding to first_stim (rank of first stim to analyze in DLPstim, usually 1)
prestim=str2double(get(handles.Prestim,'String'))/1000; %converting to s
poststim=str2double(get(handles.Poststim,'String'))/1000; %converting to s

NoDLP=get(handles.DLPNotLoaded,'Value');

savefigs=get(handles.SaveFigs,'Value');

Savedxin={};
Savedyin={};

if NoDLP==1
    for k=1:length(SpikeTraceData(TracesToApply_Stims).XVector)
    Savedxin{k}=1;
    Savedyin{k}=1;
    end
else
    Savedxin=DLPstim.SaveParam.Savedxin;
    Savedyin=DLPstim.SaveParam.Savedyin;
end

Stims_array_2=sort_stimuli(Savedxin,Savedyin,SpikeTraceData(TracesToApply_Stims).XVector,SpikeTraceData(TracesToApply_Spikes).XVector,prestim,poststim,first_stim,last_stim,first_stim_in_detstim,handles);


[path,basefile,ext] = fileparts(handles.BasalFile) %test
if savefigs
[path,basefile,ext] = fileparts(handles.BasalFile)
 basename=[handles.Path '\' basefile '_ep' int2str(savefile_epstart) '-' int2str(savefile_eplast)]
%  basename=[savefile '_ep' int2str(savefile_epstart) '-' int2str(savefile_eplast)]
 fig_fig=[basename '_raster-vs-stim-location' '.fig'];
 fig_tiff=[basename '_raster-vs-stim-location' '.tif'];
 print(333,'-dtiff',fig_tiff);
 saveas(333,fig_fig);
end

ValidateValues_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%


%make rasters after sorting stimuli according to location of light stimulus
%this version works for single squares/stimuli only
function Stims_array = sort_stimuli(Savedxin, Savedyin, stimontimes_def, spiketimes, prestim, poststim,first_stim, last_stim,first_stim_in_detstim,handles)

    clear Stims_array
    clear spikes_ind
    clear vec_x
    clear vec_y

    
    %copy to vectors for ease of manipulation:
    vec_x = zeros(length(Savedxin),1);
    vec_y = zeros(length(Savedxin),1);
    
    for i = 1:length(Savedxin)
        vec_x(i)=Savedxin{i};
        vec_y(i)=Savedyin{i};
    end
    
    max_x=max(vec_x);
    max_y=max(vec_y);
    
    % create an array in which the case of coords x,y
    % will contain the list of stims associated with stim x,y
    %(ie the indices of this particular x,y combination)
    
    Stims_array = cell(max_x,max_y);
    
    for i=1:max_x
        for j=1:max_y
            Stims_array{i,j}.list={};
        end
    end
    
    stim_lag = first_stim_in_detstim-first_stim; 
    % if for ex. first_stim (in DLPstim sequence of stims) is 3, and
    % this corresponds to the first stim detected by the photodiode (ie
    % first_stim_in_detstim=1), stim_lag = -2.
    % Then the stimulus rank that will get written in the corresponding cell
    % in Stims_arrays below is 1.
    
   
    
    for n=first_stim:last_stim
        Stims_array{vec_x(n),vec_y(n)}.list{end+1}=n+stim_lag;
    end
    
%     global Stims_array
    
    %%%%
   
    
    z=1;
    

     
    for i=1:max_x
        for j=1:max_y
            
            sz=size(Stims_array{i,j}.list,2);
            
            if sz>0
                
                for k=1:sz  %loop over stimuli corresponding to the same stim location (=listed in the same Stims_array cell) to plot rasters
                    
                   
                    figure(333);
                    subplot(max_x,max_y,z)
                    tmin = stimontimes_def(Stims_array{i,j}.list{k})-prestim;
                    tmax = stimontimes_def(Stims_array{i,j}.list{k})+poststim;
                    
                    a = spiketimes>tmin;
                    b = spiketimes<tmax;
                    c = a+b;
                    spikes_ind = find(c>1);
                    
                    
                    
                    if length(spikes_ind)>0
                        plot(spiketimes(spikes_ind(1):spikes_ind(end))-stimontimes_def(Stims_array{i,j}.list{k})+prestim,k*ones(size(spikes_ind)),'k.')
                        hold on
                    end
                    
                    
                    plot(prestim,k,'r.')
                    axis([0 prestim+poststim 0 k])
                    hold on
                    
                end
                
            end
            
            %%%
            
            z=z+1;
        end
        
    end
    
    figure(333);
    hold off
    
    %  fig_fig=[basename 'rasters-vs-stim-location' '.fig'];
    %  fig_tiff=[basename 'rasters-vs-stim-location' '.tif'];
    %  print(323,'-dtiff',fig_tiff);
    %  saveas(323,fig_fig);
   



% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



function First_Stim_Callback(hObject, eventdata, handles)
% hObject    handle to First_Stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of First_Stim as text
%        str2double(get(hObject,'String')) returns contents of First_Stim as a double


% --- Executes during object creation, after setting all properties.
function First_Stim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to First_Stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelector_Stims.
function TraceSelector_Stims_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector_Stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector_Stims contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector_Stims

global SpikeTraceData
global TracesToApply_Stims
TracesToApply_Stims=get(handles.TraceSelector_Stims,'Value');

stimsdet_size=SpikeTraceData(TracesToApply_Stims).DataSize(1);
stimsdlp_size=str2num(get(handles.Last_Stim,'String'));
stims_size=min(stimsdet_size,stimsdlp_size); %analysis impossible for more stims than recorded in DLPstim
set(handles.Last_Stim,'String',num2str(stims_size));


% --- Executes during object creation, after setting all properties.
function TraceSelector_Stims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector_Stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Last_Stim_Callback(hObject, eventdata, handles)
% hObject    handle to Last_Stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Last_Stim as text
%        str2double(get(hObject,'String')) returns contents of Last_Stim as a double


% --- Executes during object creation, after setting all properties.
function Last_Stim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Last_Stim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Prestim_Callback(hObject, eventdata, handles)
% hObject    handle to Prestim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prestim as text
%        str2double(get(hObject,'String')) returns contents of Prestim as a double


% --- Executes during object creation, after setting all properties.
function Prestim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prestim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Poststim_Callback(hObject, eventdata, handles)
% hObject    handle to Poststim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Poststim as text
%        str2double(get(hObject,'String')) returns contents of Poststim as a double


% --- Executes during object creation, after setting all properties.
function Poststim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Poststim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelector_Spikes.
function TraceSelector_Spikes_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector_Spikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector_Spikes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector_Spikes


% --- Executes during object creation, after setting all properties.
function TraceSelector_Spikes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector_Spikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function First_Stim_In_Detstim_Callback(hObject, eventdata, handles)
% hObject    handle to First_Stim_In_Detstim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of First_Stim_In_Detstim as text
%        str2double(get(hObject,'String')) returns contents of First_Stim_In_Detstim as a double


% --- Executes during object creation, after setting all properties.
function First_Stim_In_Detstim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to First_Stim_In_Detstim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DLPNotLoaded.
function DLPNotLoaded_Callback(hObject, eventdata, handles)
% hObject    handle to DLPNotLoaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DLPNotLoaded


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
end
