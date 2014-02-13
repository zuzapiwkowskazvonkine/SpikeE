function varargout = SpontPSTHs_Significance(varargin)
% SPONTPSTHS_SIGNIFICANCE M-file for SpontPSTHs_Significance.fig
%      SPONTPSTHS_SIGNIFICANCE, by itself, creates a new SPONTPSTHS_SIGNIFICANCE or raises the existing
%      singleton*.
%
%      H = SPONTPSTHS_SIGNIFICANCE returns the handle to a new SPONTPSTHS_SIGNIFICANCE or the handle to
%      the existing singleton*.
%
%      SPONTPSTHS_SIGNIFICANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPONTPSTHS_SIGNIFICANCE.M with the given input arguments.
%
%      SPONTPSTHS_SIGNIFICANCE('Property','Value',...) creates a new SPONTPSTHS_SIGNIFICANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpontPSTHs_Significance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpontPSTHs_Significance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpontPSTHs_Significance

% Last Modified by GUIDE v2.5 13-Mar-2013 10:14:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SpontPSTHs_Significance_OpeningFcn, ...
    'gui_OutputFcn',  @SpontPSTHs_Significance_OutputFcn, ...
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


% --- Executes just before SpontPSTHs_Significance is made visible.
function SpontPSTHs_Significance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpontPSTHs_Significance (see VARARGIN)

% Choose default command line output for SpontPSTHs_Significance
handles.output = hObject;



% UIWAIT makes SpontPSTHs_Significance wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_DCN\PSTHs');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai35_DCN\PSTHs';

set(handles.PathForLoadingSpont,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Spont_Ai35_DCN\PSTHs');
handles.Path2='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Spont_Ai35_DCN\PSTHs';

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.NegSurprise,'Value',Settings.NegSurpriseValue);
    set(handles.PosSurprise,'Value',Settings.PosSurpriseValue);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    handles.Path=Settings.Path;
    set(handles.PathForLoadingSpont,'String',Settings.PathForLoadingSpontString);
    handles.Path2=Settings.Path2;
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SpontPSTHs_Significance_OutputFcn(hObject, eventdata, handles)
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
Settings.NegSurpriseValue=get(handles.NegSurprise,'Value');
Settings.PosSurpriseValue=get(handles.PosSurprise,'Value');
Settings.PathForLoadingString=get(handles.PathForLoading,'String');
Settings.Path=handles.Path;
Settings.PathForLoadingSpontString=get(handles.PathForLoadingSpont,'String');
Settings.Path2=handles.Path2;

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData
global SpikeTraceDataHidden

%%%%%%%%%%%%%

negresp=get(handles.NegSurprise,'Value');
posresp=get(handles.PosSurprise,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

% get list of folders in Spont Path
allfiles=dir(handles.Path2);
nbfiles=length(allfiles);

global cells %put in cells the base names for the different files present in Spont PSTHs folder
cells=struct([]);
i=1;
posexist=0;
negexist=0;

% label elements for finding corresponding Traces:
label_epstart='Ep Start';
label_epend='Ep End';
label_filenb='File Nb';
label_signresp_pos='significant positive';
label_signresp_neg='significant negative';


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
    saveinds=[];
    
    infofile=[handles.Path2 '\' cells(i).name '_info.mat'];
    if posresp
        poswinfile=[handles.Path2 '\' cells(i).name '_PosSpikenbResp.mat'];
        if exist(poswinfile,'file')
            posexist=1;
        else
            posexist=0;
        end
    end
    if negresp
        negwinfile=[handles.Path2 '\' cells(i).name '_NegSpikenbResp.mat'];
        if exist(negwinfile,'file')
            negexist=1;
        else
            negexist=0;
        end
    end
    
    % load info for Spont PSTHs
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
    infotracessp=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
    
    for k=infotracessp
        
        if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_epstart))
            ind_epstartsp=k
        else if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_epend))
                ind_ependsp=k
            else if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_filenb))
                    ind_filenbsp=k
                end
            end
        end
        
    end
    
    % load info evoked PSTHs
    
    infofile=[handles.Path '\' cells(i).name '_info.mat'];
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
    
    for k=infotraces
        
        if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_epstart))
            ind_epstart=k
        else if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_epend))
                ind_epend=k
            else if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_filenb))
                    ind_filenb=k
                end
            end
        end
        
    end
    
    
    if posresp&&posexist
        
        % load file with PosSpikenbResp
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
        posresptraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
        
        
        for k=posresptraces
            if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_signresp_pos))
                ind_posresp=k
            end
            
        end
         
        % make new vector containing spont significance info (from
        % ind_posresp) in the order of the evoked PSTHs vectors
        
        posresp_new=zeros(1,length(SpikeTraceData(ind_epstart).Trace));
        
        for n=1:length(SpikeTraceData(ind_epstart).Trace)
            epstart=SpikeTraceData(ind_epstart).Trace(n);
            epend=SpikeTraceData(ind_epend).Trace(n);
            
            spontind1=find(SpikeTraceData(ind_epstartsp).Trace==epstart);
            spontind2=find(SpikeTraceData(ind_ependsp).Trace==epend);
            
            spontind=intersect(spontind1,spontind2);
            
            if length(spontind)>1  %ie more than 1 set of epstart-epend fitting with the psth is found
                filenb=SpikeTraceData(ind_filenb).Trace(n);
                spontind3=find(SpikeTraceData(ind_filenbsp).Trace==filenb);
                spontind=intersect(spontind,spontind3);
            end
            
            posresp_new(n)=SpikeTraceData(ind_posresp).Trace(spontind);
            
            
        end
        
        
        BeginTrace=length(SpikeTraceData)+1;
        
        SpikeTraceData(BeginTrace).XVector=1:length(posresp_new);
        SpikeTraceData(BeginTrace).DataSize=length(posresp_new);
        SpikeTraceData(BeginTrace).Trace=posresp_new;
        SpikeTraceData(BeginTrace).Label.ListText='Significant Pos. Surprise Found in Spont. Corresponding to PSTH ';
        SpikeTraceData(BeginTrace).Label.YLabel='Significant Spont. surprise';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind_posresp).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind_posresp).Path;
        
        posrespnewtrace=BeginTrace;
        saveinds(end+1)=posrespnewtrace;
        
    end
    
    if negresp&&negexist
        
        
        % load file with NegSpikenbResp
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
        negresptraces=BeginTrace:(BeginTrace-1+length(ListTraceToLoad));
        
        
        for k=negresptraces
            if ~isempty(strfind(SpikeTraceData(k).Label.ListText,label_signresp_neg))
                ind_negresp=k
            end
            
        end
       
        
        
        % make new vector containing spont significance info (from
        % ind_posresp) in the order of the evoked PSTHs vectors
        
        negresp_new=zeros(1,length(SpikeTraceData(ind_epstart).Trace));
        
        for n=1:length(SpikeTraceData(ind_epstart).Trace)
            epstart=SpikeTraceData(ind_epstart).Trace(n);
            epend=SpikeTraceData(ind_epend).Trace(n);
            
            spontind1=find(SpikeTraceData(ind_epstartsp).Trace==epstart);
            spontind2=find(SpikeTraceData(ind_ependsp).Trace==epend);
            
            spontind=intersect(spontind1,spontind2);
            
            if length(spontind)>1  %ie more than 1 set of epstart-epend fitting with the psth is found
                filenb=SpikeTraceData(ind_filenb).Trace(n);
                spontind3=find(SpikeTraceData(ind_filenbsp).Trace==filenb);
                spontind=intersect(spontind,spontind3);
            end
            
            negresp_new(n)=SpikeTraceData(ind_negresp).Trace(spontind);
            
           
        end
        
        
        BeginTrace=length(SpikeTraceData)+1;
        
        SpikeTraceData(BeginTrace).XVector=1:length(negresp_new);
        SpikeTraceData(BeginTrace).DataSize=length(negresp_new);
        SpikeTraceData(BeginTrace).Trace=negresp_new;
        SpikeTraceData(BeginTrace).Label.ListText='Significant Neg. Surprise Found in Spont. Corresponding to PSTH ';
        SpikeTraceData(BeginTrace).Label.YLabel='Significant Spont. surprise';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind_negresp).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind_negresp).Path;
        
        negrespnewtrace=BeginTrace;
        saveinds(end+1)=negrespnewtrace;
    end
    
    if negresp&&negexist&&posresp&&posexist
        
        spontresp_new=zeros(1,length(posresp_new));
        vec1=find(posresp_new==1);
        vec2=find(negresp_new==1);
        vec=unique([vec1 vec2]);
        spontresp_new(vec)=1;
        
        BeginTrace=length(SpikeTraceData)+1;
        
        SpikeTraceData(BeginTrace).XVector=1:length(spontresp_new);
        SpikeTraceData(BeginTrace).DataSize=length(spontresp_new);
        SpikeTraceData(BeginTrace).Trace=spontresp_new;
        SpikeTraceData(BeginTrace).Label.ListText='Significant Surprise Found in Spont. Corresponding to PSTH ';
        SpikeTraceData(BeginTrace).Label.YLabel='Significant Spont. surprise';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind_negresp).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind_negresp).Path;
        
        spontrespnewtrace=BeginTrace;
        saveinds(end+1)=spontrespnewtrace;
    end
    
    if length(saveinds)==0  % create a Trace with zeros, indicating there are no Significant surprises in Spont activity for this cell.
        
       tot=length(SpikeTraceData(ind_epstart).Trace);
        
       BeginTrace=length(SpikeTraceData)+1;
        
        SpikeTraceData(BeginTrace).XVector=1:tot;
        SpikeTraceData(BeginTrace).DataSize=tot;
        SpikeTraceData(BeginTrace).Trace=zeros(1,tot);
        SpikeTraceData(BeginTrace).Label.ListText='Significant Surprise Found in Spont. Corresponding to PSTH ';
        SpikeTraceData(BeginTrace).Label.YLabel='Significant Spont. surprise';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind_epstart).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind_epstart).Path;
        
        spontnewtrace=BeginTrace;
        saveinds(end+1)=spontnewtrace; 
    end
    
    savefile=[handles.Path '\' cells(i).name '_infospont.mat'];
    OldData=SpikeTraceData;
    SpikeTraceData=SpikeTraceData(saveinds);
    save(savefile,'SpikeTraceData');
    SpikeTraceData=OldData;
    

    
end




% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;


% --- Executes on button press in NegSurprise.
function NegSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to NegSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegSurprise


% 1 if bin is above threshold, 0 otherwise

function times=getbinsabovethresh(thresh,trace)

times=zeros(1,length(trace));

for i=1:length(trace)
    if trace(i)>= thresh
        times(i)=1;
    end
end


function times=getbinsbelowthresh(thresh,trace)

times=zeros(1,length(trace));

for i=1:length(trace)
    if trace(i)<= thresh
        times(i)=1;
    end
end

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


% --- Executes on button press in PosSurprise.
function PosSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to PosSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PosSurprise


% --- Executes on button press in SetPathSpont.
function SetPathSpont_Callback(hObject, eventdata, handles)
% hObject    handle to SetPathSpont (see GCBO)
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
    set(handles.PathForLoadingSpont,'String',NewPath);
    guidata(hObject,handles);
    %     CreateFileName(hObject, handles);
end
