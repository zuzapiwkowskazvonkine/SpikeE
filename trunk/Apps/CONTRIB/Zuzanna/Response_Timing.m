function varargout = Response_Timing(varargin)
% RESPONSE_TIMING M-file for Response_Timing.fig
%      RESPONSE_TIMING, by itself, creates a new RESPONSE_TIMING or raises the existing
%      singleton*.
%
%      H = RESPONSE_TIMING returns the handle to a new RESPONSE_TIMING or the handle to
%      the existing singleton*.
%
%      RESPONSE_TIMING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_TIMING.M with the given input arguments.
%
%      RESPONSE_TIMING('Property','Value',...) creates a new RESPONSE_TIMING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Response_Timing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Response_Timing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Response_Timing

% Last Modified by GUIDE v2.5 11-Mar-2013 16:40:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Response_Timing_OpeningFcn, ...
                   'gui_OutputFcn',  @Response_Timing_OutputFcn, ...
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


% --- Executes just before Response_Timing is made visible.
function Response_Timing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Response_Timing (see VARARGIN)

% Choose default command line output for Response_Timing
handles.output = hObject;



% UIWAIT makes Response_Timing wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

    set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_Pje_2\Analysis_Windows');
    handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_Pje_2\Analysis_Windows';
    
    set(handles.PathForLoadingPSTHs,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_Pje_2\PSTHs');
    handles.Path2='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_Pje_2\PSTHs';

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);
    set(handles.PosResponse,'Value',Settings.PosResponseValue);
    set(handles.NegResponse,'Value',Settings.NegResponseValue);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    set(handles.PathForLoadingPSTHs,'String',Settings.PathForLoadingPSTHsString);
    handles.Path=Settings.Path;
    handles.Path2=Settings.Path2;
    set(handles.StartOnset,'String',Settings.StartOnsetString);
    set(handles.RespDuration,'Value',Settings.RespDurationValue);
    set(handles.RespOnset,'Value',Settings.RespOnsetValue);
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Response_Timing_OutputFcn(hObject, eventdata, handles) 
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
Settings.PosResponseValue=get(handles.PosResponse,'Value');
Settings.NegResponseValue=get(handles.NegResponse,'Value');
Settings.PathForLoadingString=get(handles.PathForLoading,'String');
Settings.PathForLoadingPSTHsString=get(handles.PathForLoadingPSTHs,'String');
Settings.Path=handles.Path;
Settings.Path2=handles.Path2;
Settings.StartOnsetString=get(handles.StartOnset,'String');
Settings.RespDurationValue=get(handles.RespDuration,'Value');
Settings.RespOnsetValue=get(handles.RestOnset,'Value');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData
global SpikeTraceDataHidden

%%%%%%%%%%%%%

posresp=get(handles.PosResponse,'Value');
negresp=get(handles.NegResponse,'Value');
respdur=get(handles.RespDuration,'Value');
responset=get(handles.RespOnset,'Value');
startonset=str2num(get(handles.StartOnset,'String'));

allfiles=dir(handles.Path2); % PSTH files
nbfiles=length(allfiles);

global cells %put in cells the base names for the different files present in PSTHs folder
cells=struct([]);
i=1;
posexist=0;
negexist=0;

for n=3:nbfiles
    nameend=allfiles(n).name(end-7:end-4);
    if strcmp(nameend,'info')
    else
        nameind=strfind(allfiles(n).name,'_psths');
        name=allfiles(n).name(1:nameind-1);
        cells(i).name=name;
        i=i+1;
    end
end

for i=1:length(cells)
    InitTraces();
    psthfile=[handles.Path2 '\' cells(i).name '_psths.mat'];
    infofile=[handles.Path2 '\' cells(i).name '_info.mat'];
    if posresp
        poswinfile=[handles.Path '\' cells(i).name '_Window_SignSurprise_Pos.mat'];
        if exist(poswinfile,'file')
            posexist=1;
        else
            posexist=0;
        end
    end
    if negresp
        negwinfile=[handles.Path '\' cells(i).name '_Window_SignSurprise_Neg.mat'];
        if exist(negwinfile,'file')
            negexist=1;
        else
            negexist=0;
        end
    end
    
%     % load PSTHs
%     BeginTrace=length(SpikeTraceData)+1;
%     if exist('matfile')==2
%         matObj = matfile(psthfile);
%         info=whos(matObj,'SpikeTraceData');
%     else
%         info=whos('-file',psthfile,'SpikeTraceData');
%     end
%     
%     NumberTrace=max(info.size);
%     ListTraceToLoad=1:NumberTrace;
%     
%     if exist('matfile')==2
%         matObj = matfile(psthfile);
%         SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
%         
%     else
%         Tmp=load(psthfile,'SpikeTraceData');
%         SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);   
%     end
%     psthtraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
%     
%     % load info
%      BeginTrace=length(SpikeTraceData)+1;
%     if exist('matfile')==2
%         matObj = matfile(infofile);
%         info=whos(matObj,'SpikeTraceData');
%     else
%         info=whos('-file',infofile,'SpikeTraceData');
%     end
%     
%     NumberTrace=max(info.size);
%     ListTraceToLoad=1:NumberTrace;
%     
%     if exist('matfile')==2
%         matObj = matfile(infofile);
%         SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
%         
%     else
%         Tmp=load(infofile,'SpikeTraceData');
%         SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);   
%     end
%     infotraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
    

        if posresp&&posexist
            BeginTrace=length(SpikeTraceData)+1;
            if exist('matfile')==2
                matObj = matfile(poswinfile);
                info=whos(matObj,'SpikeTraceData');
            else
                info=whos('-file',poswinfile,'SpikeTraceData');
            end
            
            NumberTrace=max(info.size);
            ListTraceToLoad=1:NumberTrace; 
            
            if exist('matfile')==2
                matObj = matfile(poswinfile);
                SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
            else
                Tmp=load(poswinfile,'SpikeTraceData');
                SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);
            end
            possigntraces=BeginTrace:(BeginTrace-2+length(ListTraceToLoad)); % 0/1 vectors of significance
            poswintrace=BeginTrace+length(ListTraceToLoad)-1; %last loaded Trace contains the common analysis windows
            
            
        end

        if negresp&&negexist
            BeginTrace=length(SpikeTraceData)+1;
            if exist('matfile')==2
                matObj = matfile(negwinfile);
                info=whos(matObj,'SpikeTraceData');
            else
                info=whos('-file',negwinfile,'SpikeTraceData');
            end
            
            NumberTrace=max(info.size);
            ListTraceToLoad=1:NumberTrace; 
            
            if exist('matfile')==2
                matObj = matfile(negwinfile);
                SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad); 
            else
                Tmp=load(negwinfile,'SpikeTraceData');
                SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);
            end
            negsigntraces=BeginTrace:(BeginTrace-2+length(ListTraceToLoad));
            negwintrace=BeginTrace+length(ListTraceToLoad)-1;
        end
   
    
    % analyze the loaded data
    
    % possigntraces
   
    if posresp&&posexist
        if respdur
            posrespdurations=zeros(1,length(possigntraces));
        end
        if responset
            posresponsets=zeros(1,length(possigntraces));
        end
        
       
        n=1; % counter for analyzed traces
        for k=possigntraces  % loop over all significance psths
            
            startsign=floor(length(SpikeTraceData(k).Trace)/2)+1; %stim time
            
            
            %get significant bins start and stop, based on possigntraces
            %(here, obtained "integration" window is continuous from startresp to stopresp, even if there are for ex 2 disjoint significant portions detected)
            
            if respdur
                posrespdurations(n)=sum(SpikeTraceData(k).Trace(startsign:end));
            end
            
            if responset
                startonsetind=find(SpikeTraceData(k).XVector==startonset)
                veconset=find(SpikeTraceData(k).Trace(startonsetind:end)==1);
                
                if ~isempty(veconset)
                    posresponsets(n)=min(veconset)+startonset-1;
                end
                
            end
            
            n=n+1
            
        end
        
        if respdur
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:length(posrespdurations);
            SpikeTraceData(BeginTrace).Trace=posrespdurations;
            SpikeTraceData(BeginTrace).DataSize=length(posrespdurations);
            SpikeTraceData(BeginTrace).Label.ListText='Pos. Resp. Duration';
            SpikeTraceData(BeginTrace).Label.YLabel='ms';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        end
        
        if responset
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:length(posresponsets);
            SpikeTraceData(BeginTrace).Trace=posresponsets;
            SpikeTraceData(BeginTrace).DataSize=length(posresponsets);
            SpikeTraceData(BeginTrace).Label.ListText='Pos. Resp. Onset (poststim)';
            SpikeTraceData(BeginTrace).Label.YLabel='ms';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        end
        
        %save results (ie last 1 or 2 SpikeTraceData)
        
        OldData=SpikeTraceData;
        if respdur&&responset
            SpikeTraceData=SpikeTraceData(end-1:end);
        else
            SpikeTraceData=SpikeTraceData(end);
        end
        savefile=[handles.Path2 '\' cells(i).name '_PosRespTiming.mat'];
        save(savefile,'SpikeTraceData');
        SpikeTraceData=OldData;
        
    end
    
    if negresp&&negexist
    if respdur
            negrespdurations=zeros(1,length(negsigntraces));
        end
        if responset
            negresponsets=zeros(1,length(negsigntraces));
        end
        
       
        n=1; % counter for analyzed traces
        for k=negsigntraces  % loop over all significance psths
           
            startsign=floor(length(SpikeTraceData(k).Trace)/2)+1; %stim time
            
            
            %get significant bins start and stop, based on possigntraces
            %(here, obtained "integration" window is continuous from startresp to stopresp, even if there are for ex 2 disjoint significant portions detected)
            
            if respdur
                negrespdurations(n)=sum(SpikeTraceData(k).Trace(startsign:end));
            end
            
            if responset
                startonsetind=find(SpikeTraceData(k).XVector==startonset)
                veconset=find(SpikeTraceData(k).Trace(startonsetind:end)==1);
                
                if ~isempty(veconset)
                    negresponsets(n)=min(veconset)+startonset-1;
                end
                
            end
            
            n=n+1
            
        end
        
        if respdur
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:length(negrespdurations);
            SpikeTraceData(BeginTrace).Trace=negrespdurations;
            SpikeTraceData(BeginTrace).DataSize=length(negrespdurations);
            SpikeTraceData(BeginTrace).Label.ListText='Neg. Resp. Duration';
            SpikeTraceData(BeginTrace).Label.YLabel='ms';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        end
        
        if responset
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:length(negresponsets);
            SpikeTraceData(BeginTrace).Trace=negresponsets;
            SpikeTraceData(BeginTrace).DataSize=length(negresponsets);
            SpikeTraceData(BeginTrace).Label.ListText='Neg. Resp. Onset (poststim)';
            SpikeTraceData(BeginTrace).Label.YLabel='ms';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        end
        
        %save results (ie last 1 or 2 SpikeTraceData)
        
        OldData=SpikeTraceData;
        if respdur&&responset
            SpikeTraceData=SpikeTraceData(end-1:end);
        else
            SpikeTraceData=SpikeTraceData(end);
        end
        savefile=[handles.Path2 '\' cells(i).name '_NegRespTiming.mat'];
        save(savefile,'SpikeTraceData');
        SpikeTraceData=OldData;
    end
    
   
end



% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;



% --- Executes on button press in PosResponse.
function PosResponse_Callback(hObject, eventdata, handles)
% hObject    handle to PosResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PosResponse


% --- Executes on button press in CommonWindow.
function CommonWindow_Callback(hObject, eventdata, handles)
% hObject    handle to CommonWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CommonWindow


% --- Executes on button press in NegResponse.
function NegResponse_Callback(hObject, eventdata, handles)
% hObject    handle to NegResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegResponse


% --- Executes on button press in SetPath.
function SetPath_Callback(hObject, eventdata, handles)
% hObject    handle to SetPath (see GCBO)
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
    set(handles.PathForLoading,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end


% --- Executes on button press in SetPathPSTHs.
function SetPathPSTHs_Callback(hObject, eventdata, handles)
% hObject    handle to SetPathPSTHs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Oldpath=cd;

cd(handles.Path2);

% Open directory interface
NewPath=uigetdir(handles.Path2);

cd(Oldpath);

% If "Cancel" is selected then return
if isequal(NewPath,0)
    return
else
    handles.Path2=NewPath;
    set(handles.PathForLoadingPSTHs,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end



function StartOnset_Callback(hObject, eventdata, handles)
% hObject    handle to StartOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartOnset as text
%        str2double(get(hObject,'String')) returns contents of StartOnset as a double


% --- Executes during object creation, after setting all properties.
function StartOnset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RespDuration.
function RespDuration_Callback(hObject, eventdata, handles)
% hObject    handle to RespDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RespDuration


% --- Executes on button press in RespOnset.
function RespOnset_Callback(hObject, eventdata, handles)
% hObject    handle to RespOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RespOnset
