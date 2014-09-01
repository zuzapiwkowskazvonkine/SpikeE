function varargout = Response_SpikeNbs_RespsAboveThreshs(varargin)
% RESPONSE_SPIKENBS_RESPSABOVETHRESHS M-file for Response_SpikeNbs_RespsAboveThreshs.fig
%      RESPONSE_SPIKENBS_RESPSABOVETHRESHS, by itself, creates a new RESPONSE_SPIKENBS_RESPSABOVETHRESHS or raises the existing
%      singleton*.
%
%      H = RESPONSE_SPIKENBS_RESPSABOVETHRESHS returns the handle to a new RESPONSE_SPIKENBS_RESPSABOVETHRESHS or the handle to
%      the existing singleton*.
%
%      RESPONSE_SPIKENBS_RESPSABOVETHRESHS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_SPIKENBS_RESPSABOVETHRESHS.M with the given input arguments.
%
%      RESPONSE_SPIKENBS_RESPSABOVETHRESHS('Property','Value',...) creates a new RESPONSE_SPIKENBS_RESPSABOVETHRESHS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Response_SpikeNbs_RespsAboveThreshs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Response_SpikeNbs_RespsAboveThreshs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Response_SpikeNbs_RespsAboveThreshs

% Last Modified by GUIDE v2.5 26-Mar-2013 11:34:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Response_SpikeNbs_RespsAboveThreshs_OpeningFcn, ...
                   'gui_OutputFcn',  @Response_SpikeNbs_RespsAboveThreshs_OutputFcn, ...
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


% --- Executes just before Response_SpikeNbs_RespsAboveThreshs is made visible.
function Response_SpikeNbs_RespsAboveThreshs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Response_SpikeNbs_RespsAboveThreshs (see VARARGIN)

% Choose default command line output for Response_SpikeNbs_RespsAboveThreshs
handles.output = hObject;



% UIWAIT makes Response_SpikeNbs_RespsAboveThreshs wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje\Analysis_Windows');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje\Analysis_Windows';

set(handles.PathForLoadingPSTHs,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje\PSTHs');
handles.Path2='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje\PSTHs';


if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);
    set(handles.PosResponse,'Value',Settings.PosResponseValue);
    set(handles.NegResponse,'Value',Settings.NegResponseValue);
    set(handles.CommonWindow,'Value',Settings.CommonWindowValue);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    set(handles.PathForLoadingPSTHs,'String',Settings.PathForLoadingPSTHsString);
    handles.Path=Settings.Path;
    handles.Path2=Settings.Path2;
    set(handles.BurstNb,'String',Settings.BurstNbString);
    set(handles.NbBaseline,'String',Settings.NbBaselineString);
    set(handles.Analyze2ndHalf,'Value',Settings.Analyze2ndHalfValue);
    set(handles.Thresh1,'String',Settings.Thresh1String);
    set(handles.Thresh2,'String',Settings.Thresh2String);
    set(handles.Thresh3,'String',Settings.Thresh3String);
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Response_SpikeNbs_RespsAboveThreshs_OutputFcn(hObject, eventdata, handles) 
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
Settings.CommonWindowValue=get(handles.CommonWindow,'Value');
Settings.NegResponseValue=get(handles.NegResponse,'Value');
Settings.PathForLoadingString=get(handles.PathForLoading,'String');
Settings.PathForLoadingPSTHsString=get(handles.PathForLoadingPSTHs,'String');
Settings.Path=handles.Path;
Settings.Path2=handles.Path2;
Settings.BurstNbString=get(handles.BurstNb,'String');
Settings.NbBaselineString=get(handles.NbBaseline,'String');
Settings.Analyze2ndHalfValue=get(handles.Analyze2ndHalf,'Value');
Settings.Thresh1String=get(handles.Thresh1,'String');
Settings.Thresh2String=get(handles.Thresh2,'String');
Settings.Thresh3String=get(handles.Thresh3,'String');

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
commonwindow=get(handles.CommonWindow,'Value');
burstnb=str2num(get(handles.BurstNb,'String'));
nbbase=str2num(get(handles.NbBaseline,'String'));
sechalf=get(handles.Analyze2ndHalf,'Value');

allfiles=dir(handles.Path2); % PSTH files
nbfiles=length(allfiles);

thresh1=str2num(get(handles.Thresh1,'String'));
thresh2=str2num(get(handles.Thresh2,'String'));
thresh3=str2num(get(handles.Thresh3,'String'));


global cells %put in cells the base names for the different files present in PSTHs folder
cells=struct([]);
i=1;
posexist=0;
negexist=0;

for n=3:nbfiles
    nameend=allfiles(n).name(end-8:end-4);
    if strcmp(nameend,'psths')
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
    
    % load PSTHs
    BeginTrace=length(SpikeTraceData)+1;
    if exist('matfile')==2
        matObj = matfile(psthfile);
        info=whos(matObj,'SpikeTraceData');
    else
        info=whos('-file',psthfile,'SpikeTraceData');
    end
    
    NumberTrace=max(info.size);
    ListTraceToLoad=1:NumberTrace;
    
    if exist('matfile')==2
        matObj = matfile(psthfile);
        SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
        
    else
        Tmp=load(psthfile,'SpikeTraceData');
        SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);   
    end
    psthtraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
    
    % load info
     BeginTrace=length(SpikeTraceData)+1;
    if exist('matfile')==2
        matObj = matfile(infofile);
        info=whos(matObj,'SpikeTraceData');
    else
        info=whos('-file',infofile,'SpikeTraceData');
    end
    
    NumberTrace=max(info.size);
    ListTraceToLoad=1:NumberTrace;
    
    if exist('matfile')==2
        matObj = matfile(infofile);
        SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
        
    else
        Tmp=load(infofile,'SpikeTraceData');
        SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);   
    end
    infotraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
    

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
    
    %psthtraces, infotraces, possigntraces, negsigntraces, poswintrace,
    %negwintrace
    
    if (nbbase==1)&&(length(SpikeTraceData(infotraces(end)).Trace)==1)
        base=SpikeTraceData(infotraces(end)).Trace(1); % baseline rate in Hz
    end
   
   
    if posresp&&posexist
        posresponses=zeros(1,length(psthtraces));
        signposresponses=zeros(1,length(psthtraces));
        thresh1responses=zeros(1,length(psthtraces));
        thresh2responses=zeros(1,length(psthtraces));
        thresh3responses=zeros(1,length(psthtraces));
        
        if commonwindow 
            startresp=SpikeTraceData(poswintrace).Trace(1);
            stopresp=SpikeTraceData(poswintrace).Trace(2);
        end
        
        for k=psthtraces  % loop over all psths
            tot=0;
            psthorder=k-psthtraces(1)+1;
            
            if (nbbase==2)||(length(SpikeTraceData(infotraces(end)).Trace)>1)
                base=SpikeTraceData(infotraces(end)).Trace(psthorder); % baseline rate in Hz for this PSTH
            end
            
            if sechalf
                startsign=floor(length(SpikeTraceData(k).Trace)/2)+1; %analyze only 2nd half of PSTH (in evoked: post-stim)
            else
                startsign=1;
            end
            
            if commonwindow==0
                %get start and stop for each PSTH, based on possigntraces
                %(here, obtained "integration" window is continuous from startresp to stopresp, even if there are for ex 2 disjoint significant portions detected)
                vec=find(SpikeTraceData(possigntraces(psthorder)).Trace(startsign:end)==1)
                if ~isempty(vec)
                    startresp=min(vec)+startsign-1;
                    stopresp=max(vec)+startsign-1;
                else
                    startresp=0;
                    stopresp=0;
                end
            end
            
            trialnb=SpikeTraceData(infotraces(end-nbbase)).Trace(psthorder);             % MAKE SURE TRIAL NB IS nbbase BEFORE LAST IN  INFOTRACES
            base1ms=base*0.001*burstnb*trialnb; % baseline nb of spikes in 1ms bin
            
            if startresp>0
                for z=startresp:stopresp
                    if SpikeTraceData(k).Trace(z)>base1ms
                        tot=tot+SpikeTraceData(k).Trace(z)-base1ms;
                    end
                end
            else
                tot=0;
            end
            
            if trialnb>0
            posresponses(psthorder)=tot/(burstnb*trialnb); %avg. resp. in spike number above baseline per trial and per single stimulus
            else
            posresponses(psthorder)=0;
            end
         
          
            % 3 vecs saying if the response amplitude is above each of the 3
            % thresholds (Thresh1,2,3)
            if posresponses(psthorder)>thresh1
                thresh1responses(psthorder)=1;
            end
            if posresponses(psthorder)>thresh2
                thresh2responses(psthorder)=1;
            end
            if posresponses(psthorder)>thresh3
                thresh3responses(psthorder)=1;
            end
            
            % also have a vec saying whether there is a significant
            % response or not, based on possigntraces
            
            if sum(SpikeTraceData(possigntraces(psthorder)).Trace(startsign:end))==0   %only sum over the post-stimulus part of the PSTH
                signposresponses(psthorder)=0;
            else
                signposresponses(psthorder)=1;
            end
            
        end
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(posresponses);
        SpikeTraceData(BeginTrace).Trace=posresponses;
        SpikeTraceData(BeginTrace).DataSize=length(posresponses);
        SpikeTraceData(BeginTrace).Label.ListText='Resp. Spikes above baseline, per trial and stim.';
        SpikeTraceData(BeginTrace).Label.YLabel='Spike Nb';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(signposresponses);
        SpikeTraceData(BeginTrace).Trace=signposresponses;
        SpikeTraceData(BeginTrace).DataSize=length(signposresponses);
        SpikeTraceData(BeginTrace).Label.ListText='Yes/No significant positive resp.';
        SpikeTraceData(BeginTrace).Label.YLabel='1/0';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;   
        
        %
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(thresh1responses);
        SpikeTraceData(BeginTrace).Trace=thresh1responses;
        SpikeTraceData(BeginTrace).DataSize=length(thresh1responses);
        SpikeTraceData(BeginTrace).Label.ListText=['Yes/No positive resp. >' num2str(thresh1)];
        SpikeTraceData(BeginTrace).Label.YLabel='1/0';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;   
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(thresh2responses);
        SpikeTraceData(BeginTrace).Trace=thresh2responses;
        SpikeTraceData(BeginTrace).DataSize=length(thresh2responses);
        SpikeTraceData(BeginTrace).Label.ListText=['Yes/No positive resp. >' num2str(thresh2)];
        SpikeTraceData(BeginTrace).Label.YLabel='1/0';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;   
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(thresh3responses);
        SpikeTraceData(BeginTrace).Trace=thresh3responses;
        SpikeTraceData(BeginTrace).DataSize=length(thresh3responses);
        SpikeTraceData(BeginTrace).Label.ListText=['Yes/No positive resp. >' num2str(thresh3)];
        SpikeTraceData(BeginTrace).Label.YLabel='1/0';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;   
        
        %save results (ie last 5 SpikeTraceData)
        
        OldData=SpikeTraceData;
        SpikeTraceData=SpikeTraceData(end-4:end);
        savefile=[handles.Path2 '\' cells(i).name '_PosSpikenbResp.mat'];
        save(savefile,'SpikeTraceData');
        SpikeTraceData=OldData;
        
    end
    
    if negresp&&negexist
    
        negresponses=zeros(1,length(psthtraces));
        signnegresponses=zeros(1,length(psthtraces));
        
        if commonwindow
            startresp=SpikeTraceData(negwintrace).Trace(1);
            stopresp=SpikeTraceData(negwintrace).Trace(2);
        end
        
        for k=psthtraces  % loop over all psths
            tot=0;
            psthorder=k-psthtraces(1)+1;
            
            if sechalf
                startsign=floor(length(SpikeTraceData(k).Trace)/2)+1; %analyze only 2nd half of PSTH (in evoked: post-stim)
            else
                startsign=1;
            end
            
            if (nbbase==2)||(length(SpikeTraceData(infotraces(end)).Trace)>1)
                base=SpikeTraceData(infotraces(end)).Trace(psthorder); % baseline rate in Hz for this PSTH
            end
            
            if commonwindow==0
                %get start and stop for each PSTH, based on negsigntraces
                %(here, obtained "integration" window is continuous from startresp to stopresp, even if there are for ex 2 disjoint significant portions detected)
                vec=find(SpikeTraceData(negsigntraces(psthorder)).Trace(startsign:end)==1);
                if ~isempty(vec)
                    startresp=min(vec)+startsign-1;
                    stopresp=max(vec)+startsign-1;
                else
                    startresp=0;
                    stopresp=0;
                end
            end
            
            trialnb=SpikeTraceData(infotraces(end-nbbase)).Trace(psthorder);             % % MAKE SURE TRIAL NB IS nbbase BEFORE LAST IN  INFOTRACES
            base1ms=base*0.001*burstnb*trialnb; % baseline nb of spikes in 1ms bin
            
            if startresp>0
                for z=startresp:stopresp
                    if SpikeTraceData(k).Trace(z)<base1ms
                        tot=tot+(base1ms-SpikeTraceData(k).Trace(z)); %count the number of "missing" spikes (relative to baseline)
                    end
                end
            else
                tot=0;
            end
            negresponses(psthorder)=tot/(burstnb*trialnb); %avg. resp. in spike number above baseline per trial and per single stimulus
            
            % also have a vec saying whether there is a significant
            % response or not, based on negsigntraces
            
            if sum(SpikeTraceData(negsigntraces(psthorder)).Trace(startsign:end))==0   %only sum over the post-stimulus part of the PSTH
                signnegresponses(psthorder)=0;
            else
                signnegresponses(psthorder)=1;
            end
            
        end
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(negresponses);
        SpikeTraceData(BeginTrace).Trace=negresponses;
        SpikeTraceData(BeginTrace).DataSize=length(negresponses);
        SpikeTraceData(BeginTrace).Label.ListText='Resp. Spikes below baseline, per trial and stim.';
        SpikeTraceData(BeginTrace).Label.YLabel='Spike Nb';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:length(signnegresponses);
        SpikeTraceData(BeginTrace).Trace=signnegresponses;
        SpikeTraceData(BeginTrace).DataSize=length(signnegresponses);
        SpikeTraceData(BeginTrace).Label.ListText='Yes/No significant negative resp.';
        SpikeTraceData(BeginTrace).Label.YLabel='1/0';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;    
        
        %save results (ie last 2 SpikeTraceData)
        
        OldData=SpikeTraceData;
        SpikeTraceData=SpikeTraceData(end-1:end);
        savefile=[handles.Path2 '\' cells(i).name '_NegSpikenbResp.mat'];
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



function BurstNb_Callback(hObject, eventdata, handles)
% hObject    handle to BurstNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BurstNb as text
%        str2double(get(hObject,'String')) returns contents of BurstNb as a double


% --- Executes during object creation, after setting all properties.
function BurstNb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BurstNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NbBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to NbBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbBaseline as text
%        str2double(get(hObject,'String')) returns contents of NbBaseline as a double


% --- Executes during object creation, after setting all properties.
function NbBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Analyze2ndHalf.
function Analyze2ndHalf_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze2ndHalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Analyze2ndHalf



function Thresh1_Callback(hObject, eventdata, handles)
% hObject    handle to Thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Thresh1 as text
%        str2double(get(hObject,'String')) returns contents of Thresh1 as a double


% --- Executes during object creation, after setting all properties.
function Thresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Thresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Thresh2_Callback(hObject, eventdata, handles)
% hObject    handle to Thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Thresh2 as text
%        str2double(get(hObject,'String')) returns contents of Thresh2 as a double


% --- Executes during object creation, after setting all properties.
function Thresh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Thresh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Thresh3_Callback(hObject, eventdata, handles)
% hObject    handle to Thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Thresh3 as text
%        str2double(get(hObject,'String')) returns contents of Thresh3 as a double


% --- Executes during object creation, after setting all properties.
function Thresh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Thresh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
