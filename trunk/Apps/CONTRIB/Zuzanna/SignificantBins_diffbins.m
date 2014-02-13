function varargout = SignificantBins_diffbins(varargin)
% SIGNIFICANTBINS_DIFFBINS M-file for SignificantBins_diffbins.fig
%      SIGNIFICANTBINS_DIFFBINS, by itself, creates a new SIGNIFICANTBINS_DIFFBINS or raises the existing
%      singleton*.
%
%      H = SIGNIFICANTBINS_DIFFBINS returns the handle to a new SIGNIFICANTBINS_DIFFBINS or the handle to
%      the existing singleton*.
%
%      SIGNIFICANTBINS_DIFFBINS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNIFICANTBINS_DIFFBINS.M with the given input arguments.
%
%      SIGNIFICANTBINS_DIFFBINS('Property','Value',...) creates a new SIGNIFICANTBINS_DIFFBINS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SignificantBins_diffbins_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SignificantBins_diffbins_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SignificantBins_diffbins

% Last Modified by GUIDE v2.5 23-Jan-2013 13:37:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignificantBins_diffbins_OpeningFcn, ...
                   'gui_OutputFcn',  @SignificantBins_diffbins_OutputFcn, ...
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


% --- Executes just before SignificantBins_diffbins is made visible.
function SignificantBins_diffbins_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SignificantBins_diffbins (see VARARGIN)

% Choose default command line output for SignificantBins_diffbins
handles.output = hObject;



% UIWAIT makes SignificantBins_diffbins wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje';


if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.NegSurprise,'Value',Settings.NegSurpriseValue);
    set(handles.PosSurprise,'Value',Settings.PosSurpriseValue);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    handles.Path=Settings.Path;
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SignificantBins_diffbins_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData
global SpikeTraceDataHidden

%%%%%%%%%%%%%

negsurprise=get(handles.NegSurprise,'Value');
possurprise=get(handles.PosSurprise,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

% get list of folders (one per binsize and start point)
allfolders=dir(handles.Path);
nbdirs=length(allfolders);

for i=3:nbdirs %loop over folders (first 2 are '.' and '..')
    
    %parse folder name to get binsize and start bin (ex. 'surprise_bin_19ms_13')
    nametoparse=allfolders(i).name;
    
    if (strcmp(nametoparse,'PSTHs') | strcmp(nametoparse,'Analysis_Windows') | strcmp(nametoparse,'Other'))
    else
        
        a=strfind(nametoparse,'bin_');
        nametoparse2=nametoparse(a+4:end);
        nbs=sscanf(nametoparse2,'%d %*3c %d');
        binsize=nbs(1);
        startbin=nbs(2);
        
        allfiles=dir([handles.Path '\' allfolders(i).name]);
        nbfiles=length(allfiles);
        

        %clear SpikeTraceData before analyzing each folder
        InitTraces();
        filecount=0;
        
        for j=3:nbfiles %loop over files in this folder to get threshold values
            
            nameend=allfiles(j).name(end-7:end-4);
            if strcmp(nameend,'info')
                
                % download threshold(s) trace
                LocalFile=[handles.Path '\' allfolders(i).name '\' allfiles(j).name];
                info=whos('-file',LocalFile,'SpikeTraceData');
                NumberTraces=max(info.size);
                temp=load(LocalFile,'SpikeTraceData');
                SpikeTraceData=temp.SpikeTraceData(NumberTraces); %the last Trace contains the thresholds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                break %same values for all 'info' files in same folder, break out of loop
            end
        end
        
        for j=3:nbfiles %loop over files in this folder to load surprise PSTHs
            nameend=allfiles(j).name(end-7:end-4);
            if strcmp(nameend,'info') %nothing this time
            else
                %download to SpikeTraceData
                BeginTrace=length(SpikeTraceData)+1;
                
                LocalFile=[handles.Path '\' allfolders(i).name '\' allfiles(j).name];
                
                if exist('matfile')==2
                    matObj = matfile(LocalFile);
                    info=whos(matObj,'SpikeTraceData');
                else
                    info=whos('-file',LocalFile,'SpikeTraceData');
                end
                
                NumberTrace=max(info.size);
                ListTraceToLoad=1:NumberTrace;
                
                if exist('matfile')==2
                    matObj = matfile(LocalFile);
                    SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
                    
                else
                    Tmp=load(LocalFile,'SpikeTraceData');
                    SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);
                    
                end
                filecount=filecount+1;
                
                
                % for each file, compute significance PSTH(s) and save
                TotTraces=length(SpikeTraceData);
                
                if possurprise
                    tracestosave=zeros(1,TotTraces-1);
                    for k=2:TotTraces
                        thresh=SpikeTraceData(1).Trace(1);
                        signbins=getbinsabovethresh(thresh,SpikeTraceData(k).Trace);
                        
                        BeginTrace=length(SpikeTraceData)+1;
                        SpikeTraceData(BeginTrace).XVector=SpikeTraceData(k).XVector;
                        SpikeTraceData(BeginTrace).Trace=signbins;
                        SpikeTraceData(BeginTrace).DataSize=length(signbins);
                        name=['Pos. Significant ' SpikeTraceData(k).Label.ListText];
                        SpikeTraceData(BeginTrace).Label.ListText=name;
                        SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
                        SpikeTraceData(BeginTrace).Label.XLabel='';
                        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
                        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
                        tracestosave(k-1)=BeginTrace;
                    end
                    
                    % save
                    OldData=SpikeTraceData;
                    SpikeTraceData=SpikeTraceData(tracestosave);
                    [fpath,fname,fext]=fileparts(allfiles(j).name);
                    LocalFile=[handles.Path '\' allfolders(i).name '\' fname '_pSignif' fext];
                    save(LocalFile,'SpikeTraceData');
                    SpikeTraceData=OldData;
                    
                end
                
                if negsurprise
                    tracestosave=zeros(1,TotTraces-1);
                    for k=2:TotTraces
                        thresh=SpikeTraceData(1).Trace(2);
                        signbins=getbinsbelowthresh(thresh,SpikeTraceData(k).Trace);
                        
                        BeginTrace=length(SpikeTraceData)+1;
                        SpikeTraceData(BeginTrace).XVector=SpikeTraceData(k).XVector;
                        SpikeTraceData(BeginTrace).Trace=signbins;
                        SpikeTraceData(BeginTrace).DataSize=length(signbins);
                        name=['Neg. Significant ' SpikeTraceData(k).Label.ListText];
                        SpikeTraceData(BeginTrace).Label.ListText=name;
                        SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
                        SpikeTraceData(BeginTrace).Label.XLabel='';
                        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
                        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
                        tracestosave(k-1)=BeginTrace;
                    end
                    
                    %save
                    OldData=SpikeTraceData;
                    SpikeTraceData=SpikeTraceData(tracestosave);
                    [fpath,fname,fext]=fileparts(allfiles(j).name);
                    LocalFile=[handles.Path '\' allfolders(i).name '\' fname '_nSignif' fext];
                    save(LocalFile,'SpikeTraceData');
                    SpikeTraceData=OldData;
                end
                
                % remove loaded surprise PSTHs and computed significance PSTHs, keep only threshold values for this
                % folder
                
                SpikeTraceData=SpikeTraceData(1);
            end
        end
          %     loaded_traces=length(SpikeTraceData)
    loaded_files=filecount;
    end
  
    
end

% allfiles holds the list of files for the last analyzed folder.
global cells %put in cells the names for the different surprise files only
cells=struct([]);
i=1;
for n=3:nbfiles
    nameend=allfiles(n).name(end-7:end-4);
    if strcmp(nameend,'info')
    else
        cells(i).name=allfiles(n).name;
        i=i+1;
    end
end

% for each cell, put together the significant bins of all binsizes

for n=1:length(cells)
    [fpath,fname,fext]=fileparts(cells(n).name);
    
    postraces=[];
    negtraces=[];
    InitTraces();
    
    for i=3:nbdirs %loop over folders
        
        nametoparse=allfolders(i).name;
        
        if (strcmp(nametoparse,'PSTHs') | strcmp(nametoparse,'Analysis_Windows') | strcmp(nametoparse,'Other'))
        else
            
            
            if possurprise
                BeginTrace=length(SpikeTraceData)+1;
                filename=[fname '_pSignif' fext];
                % download significance PSTHs traces
                LocalFile=[handles.Path '\' allfolders(i).name '\' filename];
                info=whos('-file',LocalFile,'SpikeTraceData');
                NumberTraces=max(info.size);
                temp=load(LocalFile,'SpikeTraceData');
                SpikeTraceData(BeginTrace:BeginTrace+NumberTraces-1)=temp.SpikeTraceData(1:NumberTraces);
                postraces(end+1:end+NumberTraces)=BeginTrace:BeginTrace+NumberTraces-1;
            end
            
            if negsurprise
                BeginTrace=length(SpikeTraceData)+1;
                filename=[fname '_nSignif' fext];
                % download significance PSTHs traces
                LocalFile=[handles.Path '\' allfolders(i).name '\' filename];
                info=whos('-file',LocalFile,'SpikeTraceData');
                NumberTraces=max(info.size);
                temp=load(LocalFile,'SpikeTraceData');
                SpikeTraceData(BeginTrace:BeginTrace+NumberTraces-1)=temp.SpikeTraceData(1:NumberTraces);
                negtraces(end+1:end+NumberTraces)=BeginTrace:BeginTrace+NumberTraces-1;
                
            end
        end
    end
    
    % convert into vectors of resolution 1ms (e.g. if 10ms bin 0 is 1, put 1 for xvalues 0:9 )
    if possurprise
        nbconds=nbdirs-5;
        tracesperbinsize=length(postraces)/nbconds; % ie nb of different psths (for the analyzed cell) in each folder       
        
        starttraces=length(SpikeTraceData)+1;  %first converted trace to analyze below
        
        for j=1:nbconds %loop over folders
            for k=(j-1)*tracesperbinsize+1:tracesperbinsize*j % loop over all PSTHs from this folder
                ind=postraces(k);
                binsize=SpikeTraceData(ind).XVector(2)-SpikeTraceData(ind).XVector(1);
                newvec=zeros(1,binsize*length(SpikeTraceData(ind).Trace)); 
                
                for i=1:length(SpikeTraceData(ind).Trace)
                    newvec((i-1)*binsize+1:binsize*i)=SpikeTraceData(ind).Trace(i);
                end
                BeginTrace=length(SpikeTraceData)+1;
                
                SpikeTraceData(BeginTrace).Trace=newvec;
                SpikeTraceData(BeginTrace).XVector=SpikeTraceData(ind).XVector(1):SpikeTraceData(ind).XVector(1)+length(newvec)-1;
                SpikeTraceData(BeginTrace).DataSize=length(newvec);
                name=['Exp. ' SpikeTraceData(ind).Label.ListText];
                SpikeTraceData(BeginTrace).Label.ListText=name;
                SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
                SpikeTraceData(BeginTrace).Label.XLabel='';
                SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind).Filename;
                SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind).Path;
                
            end
        end
        
%         stoptraces=length(SpikeTraceData);  % last converted trace to analyze below
        
        starttot=length(SpikeTraceData)+1;

        for k=starttraces:starttraces+tracesperbinsize-1  % loop over "expanded" significance PSTHs (calculated above) for first folder
            
            unionvectimes=[];
            oldstarttime=1;
            oldendtime=1;
            
            for j=1:nbconds %loop over the different folders
                
                starttime=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(1);
                endtime=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(end);
                

                minstart=min(starttime,oldstarttime);
                maxend=max(endtime,oldendtime);
                
                oldstarttime=minstart;
                oldendtime=maxend;
                
                for t=1:endtime-starttime+1;
                    if SpikeTraceData(k+tracesperbinsize*(j-1)).Trace(t)==1
                        unionvectimes(end+1)=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(t); %collect all times (across all folders) for which the Significance value is 1
                    end
                    
                end
            end
            
            vec=unique(unionvectimes); %keep only a single instance of each "Significant Timepoint"
            
            BeginTrace=length(SpikeTraceData)+1;
            
            SpikeTraceData(BeginTrace).XVector=minstart:maxend;
            SpikeTraceData(BeginTrace).DataSize=maxend-minstart+1;
            SpikeTraceData(BeginTrace).Trace=zeros(1,maxend-minstart+1);
            nameind=strfind(SpikeTraceData(k+tracesperbinsize*(j-1)).Label.ListText,'psth');
            name=['Tot. Pos. Sign. Surprise ' SpikeTraceData(k+tracesperbinsize*(j-1)).Label.ListText(nameind:end) ];  
            SpikeTraceData(BeginTrace).Label.ListText=name;
            SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
            for t=1:maxend-minstart+1;
                for z=1:length(vec)
                    if SpikeTraceData(BeginTrace).XVector(t)==vec(z)  %if a given Time is in the list of Significant Times (vec)
                        SpikeTraceData(BeginTrace).Trace(t)=1;
                    end
                end
            end
            
        end
        
        endtot=length(SpikeTraceData);
        
        %define common response analysis window for all PSTHs, ie largest
        %window containing all the significant bins from all PSTHs (starting at 0 or later, in the case of Evoked PSTHs; unconstrained, in the case of Spont PSTHs)
        
        startanalysis=length(SpikeTraceData(starttot).XVector); 
        stopanalysis=0;
        
        if SpikeTraceData(starttot).XVector(1)<=0
            addind=find(SpikeTraceData(starttot).XVector==0)-1; %number of bins before 0
        else
            addind=0;
        end
            
        for k=starttot:endtot
            
            vec=SpikeTraceData(k).Trace(addind+1:end); %start analysis at stimulus time (ie 0); or at first bin for Spont PSTHs (addind=0)
            signbins=find(vec==1);
            
            if ~isempty(signbins)
            startlocal=min(signbins);
            stoplocal=max(signbins);
            
            startanalysis=min(startanalysis,startlocal);
            stopanalysis=max(stopanalysis,stoplocal);
            end
        end
        
        if stopanalysis==0 % ie when no significant response in any PSTH
            msgbox('No significant positive responses');
        else
            startanalysis=startanalysis+addind
            stopanalysis=stopanalysis+addind
            
            
            starttot
            
            SpikeTraceData(starttot).XVector(startanalysis)
            SpikeTraceData(starttot).XVector(stopanalysis)
            
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:2;
            SpikeTraceData(BeginTrace).Trace(1)=startanalysis;
            SpikeTraceData(BeginTrace).Trace(2)=stopanalysis;
            SpikeTraceData(BeginTrace).DataSize=2;
            SpikeTraceData(BeginTrace).Label.ListText='Pos. Start and Stop analysis indices';
            SpikeTraceData(BeginTrace).Label.YLabel='PSTH indices';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
            
            tracestosave=[starttot:endtot BeginTrace];
            OldData=SpikeTraceData;
            SpikeTraceData=SpikeTraceData(tracestosave);
            filename=[fname '_Window_SignSurprise_Pos' fext];
            
            namefolder='Analysis_Windows';
            mkdir(handles.Path,namefolder);
            savepath=[handles.Path '\' namefolder '\'];
            LocalFile=[savepath '\' filename];
            
            save(LocalFile,'SpikeTraceData');
            SpikeTraceData=OldData;
        end
        
    end
    
    if negsurprise
      nbconds=nbdirs-5;
        tracesperbinsize=length(negtraces)/nbconds;
        
        starttraces=length(SpikeTraceData)+1;  %first converted trace to analyze below
        
        for j=1:nbconds
            for k=(j-1)*tracesperbinsize+1:tracesperbinsize*j
                ind=negtraces(k);
                binsize=SpikeTraceData(ind).XVector(2)-SpikeTraceData(ind).XVector(1);
                newvec=zeros(1,binsize*length(SpikeTraceData(ind).Trace));
                
                for i=1:length(SpikeTraceData(ind).Trace)
                    newvec((i-1)*binsize+1:binsize*i)=SpikeTraceData(ind).Trace(i);
                end
                BeginTrace=length(SpikeTraceData)+1;
                
                SpikeTraceData(BeginTrace).Trace=newvec;
                SpikeTraceData(BeginTrace).XVector=SpikeTraceData(ind).XVector(1):SpikeTraceData(ind).XVector(1)+length(newvec)-1;
                SpikeTraceData(BeginTrace).DataSize=length(newvec);
                name=['Exp. ' SpikeTraceData(ind).Label.ListText];
                SpikeTraceData(BeginTrace).Label.ListText=name;
                SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
                SpikeTraceData(BeginTrace).Label.XLabel='';
                SpikeTraceData(BeginTrace).Filename=SpikeTraceData(ind).Filename;
                SpikeTraceData(BeginTrace).Path=SpikeTraceData(ind).Path;

            end
        end 
        
%         stoptraces=length(SpikeTraceData);  % last converted trace to analyze below
        
        starttot=length(SpikeTraceData)+1;

        for k=starttraces:starttraces+tracesperbinsize-1  % loop over PSTHs
            
            unionvectimes=[];
            oldstarttime=1;
            oldendtime=1;
            
            for j=1:nbconds
                
                starttime=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(1);
                endtime=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(end);
                
                minstart=min(starttime,oldstarttime);
                maxend=max(endtime,oldendtime);

                oldstarttime=minstart;
                oldendtime=maxend;
                
                for t=1:endtime-starttime+1;
                    if SpikeTraceData(k+tracesperbinsize*(j-1)).Trace(t)==1
                        unionvectimes(end+1)=SpikeTraceData(k+tracesperbinsize*(j-1)).XVector(t);
                    end
                    
                end
            end
            
            vec=unique(unionvectimes);
            
            BeginTrace=length(SpikeTraceData)+1;
            
            SpikeTraceData(BeginTrace).XVector=minstart:maxend;
            SpikeTraceData(BeginTrace).DataSize=maxend-minstart+1;
            SpikeTraceData(BeginTrace).Trace=zeros(1,maxend-minstart+1);
            nameind=strfind(SpikeTraceData(k+tracesperbinsize*(j-1)).Label.ListText,'psth');
            name=['Tot. Neg. Sign. Surprise ' SpikeTraceData(k+tracesperbinsize*(j-1)).Label.ListText(nameind:end) ];  
            SpikeTraceData(BeginTrace).Label.ListText=name;
            SpikeTraceData(BeginTrace).Label.YLabel='Significant surprise';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
            for t=1:maxend-minstart+1;
                for z=1:length(vec)
                    if SpikeTraceData(BeginTrace).XVector(t)==vec(z)
                        SpikeTraceData(BeginTrace).Trace(t)=1;
                    end
                end
            end
            
        end
         endtot=length(SpikeTraceData);
         
         
        %define common response analysis window for all PSTHs, ie largest
        %window containing all the significant bins from all PSTHs (starting at 0 or later for evoked PSTHs; unconstrained for spont PSTHs)
        startanalysis=length(SpikeTraceData(starttot).XVector); 
        stopanalysis=0;
        
         if SpikeTraceData(starttot).XVector(1)<=0
            addind=find(SpikeTraceData(starttot).XVector==0)-1; %number of bins before 0
        else
            addind=0;
        end
        
        for k=starttot:endtot
            
            vec=SpikeTraceData(k).Trace(addind+1:end); %start analysis at stimulus time (ie 0), or at bin 1 for spont PSTHs.
            signbins=find(vec==1);
            
            if ~isempty(signbins)
            startlocal=min(signbins);
            stoplocal=max(signbins);
            
            startanalysis=min(startanalysis,startlocal);
            stopanalysis=max(stopanalysis,stoplocal);
            end
        end
        
        if stopanalysis==0 % ie when no significant response in any PSTH
            msgbox('No significant negative responses');
        else
            
            startanalysis=startanalysis+addind;
            stopanalysis=stopanalysis+addind;
            
            SpikeTraceData(starttot).XVector(startanalysis)
            SpikeTraceData(starttot).XVector(stopanalysis)
            
            BeginTrace=length(SpikeTraceData)+1;
            SpikeTraceData(BeginTrace).XVector=1:2;
            SpikeTraceData(BeginTrace).Trace(1)=startanalysis;
            SpikeTraceData(BeginTrace).Trace(2)=stopanalysis;
            SpikeTraceData(BeginTrace).DataSize=2;
            SpikeTraceData(BeginTrace).Label.ListText='Neg. Start and Stop analysis indices';
            SpikeTraceData(BeginTrace).Label.YLabel='PSTH indices';
            SpikeTraceData(BeginTrace).Label.XLabel='';
            SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
            SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
            
            tracestosave=[starttot:endtot BeginTrace];
            OldData=SpikeTraceData;
            SpikeTraceData=SpikeTraceData(tracestosave);
            filename=[fname '_Window_SignSurprise_Neg' fext];
            
            namefolder='Analysis_Windows';
            mkdir(handles.Path,namefolder);
            savepath=[handles.Path '\' namefolder '\'];
            LocalFile=[savepath '\' filename];
            
            save(LocalFile,'SpikeTraceData');
            SpikeTraceData=OldData;
        end
    end
    

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
