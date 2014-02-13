function varargout = Load_Trace_Mat_Multiple_Files(varargin)
% LOAD_TRACE_MAT_MULTIPLE_FILES MATLAB code for Load_Trace_Mat_Multiple_Files.fig
%      LOAD_TRACE_MAT_MULTIPLE_FILES, by itself, creates a new LOAD_TRACE_MAT_MULTIPLE_FILES or raises the existing
%      singleton*.
%
%      H = LOAD_TRACE_MAT_MULTIPLE_FILES returns the handle to a new LOAD_TRACE_MAT_MULTIPLE_FILES or the handle to
%      the existing singleton*.
%
%      LOAD_TRACE_MAT_MULTIPLE_FILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_TRACE_MAT_MULTIPLE_FILES.M with the given input arguments.
%
%      LOAD_TRACE_MAT_MULTIPLE_FILES('Property','Value',...) creates a new LOAD_TRACE_MAT_MULTIPLE_FILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Load_Trace_Mat_Multiple_Files_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Load_Trace_Mat_Multiple_Files_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2012

% Edit the above text to modify the response to help Load_Trace_Mat_Multiple_Files

% Last Modified by GUIDE v2.5 12-Mar-2013 15:38:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Load_Trace_Mat_Multiple_Files_OpeningFcn, ...
                   'gui_OutputFcn',  @Load_Trace_Mat_Multiple_Files_OutputFcn, ...
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


% --- Executes just before Load_Trace_Mat_Multiple_Files is made visible.
function Load_Trace_Mat_Multiple_Files_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Load_Trace_Mat_Multiple_Files (see VARARGIN)

% Choose default command line output for Load_Trace_Mat_Multiple_Files
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Load_Trace_Mat_Multiple_Files wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% We get the input settings to restore state if needed
if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.FolderNameList,'String',Settings.FilenameListString);
    %     set(handles.FilenameShow,'String',Settings.FilenameShowString);
    %     set(handles.TraceSelectionList,'String',Settings.TraceSelectionListString);
    %     set(handles.TraceSelectionList,'Value',Settings.TraceSelectionListValue);
    set(handles.LoadBehSelect,'Value',Settings.LoadBehSelectValue);
    set(handles.LoadBehSelect,'String',Settings.LoadBehSelectString);
    %     set(handles.SelectAllTrace,'Value',Settings.SelectAllTraceValue);
    set(handles.ExtractPxls,'Value',Settings.ExtractPxlsValue);
    set(handles.ExtractInt,'Value',Settings.ExtractIntValue);
    set(handles.ExtractEps,'Value',Settings.ExtractEpsValue);
    set(handles.KeepNbTraces,'Value',Settings.KeepNbTracesValue);
    set(handles.ExtractFOV,'Value',Settings.ExtractFOVValue);
    set(handles.ExtractStimDur,'Value',Settings.ExtractStimDurValue);
    set(handles.ExtractFilenb,'Value',Settings.ExtractFilenbValue);
end
    
% SelectAllTrace_Callback(hObject, eventdata, handles);

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.FilenameListString=get(handles.FolderNameList,'String');
% Settings.TraceSelectionListString=get(handles.TraceSelectionList,'String');
% Settings.TraceSelectionListValue=get(handles.TraceSelectionList,'Value');
Settings.LoadBehSelectValue=get(handles.LoadBehSelect,'Value');
Settings.LoadBehSelectString=get(handles.LoadBehSelect,'String');
% Settings.SelectAllTraceValue=get(handles.SelectAllTrace,'Value');
Settings.ExtractPxlsValue=get(handles.ExtractPxls,'Value');
Settings.ExtractIntValue=get(handles.ExtractInt,'Value');
Settings.ExtractEpsValue=get(handles.ExtractEps,'Value');
Settings.KeepNbTracesValue=get(handles.KeepNbTraces,'Value');
Settings.ExtractFOVValue=get(handles.ExtractFOV,'Value');
Settings.ExtractStimDurValue=get(handles.ExtractStimDur,'Value');
Settings.ExtractFilenbValue=get(handles.ExtractFilenb,'Value');

% --- Outputs from this function are returned to the command line.
function varargout = Load_Trace_Mat_Multiple_Files_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% delete(hObject);

% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;
global savefile;
global savefile_epstart;
global savefile_eplast;

try
    InterfaceObj=findobj(handles.output,'Enable','on');
    set(InterfaceObj,'Enable','off');
    
    extractpxls=get(handles.ExtractPxls,'Value');
    extractint=get(handles.ExtractInt,'Value');
    extracteps=get(handles.ExtractEps,'Value');
    keepnbtraces=get(handles.KeepNbTraces,'Value');
    extractfov=get(handles.ExtractFOV,'Value');
    extractstimdur=get(handles.ExtractStimDur,'Value');
    extractfilenb=get(handles.ExtractFilenb,'Value');
    
    if (get(handles.LoadBehSelect,'Value')==1)
        InitTraces();
        BeginTrace=1;
    else
        BeginTrace=length(SpikeTraceData)+1;
    end
    
%     h=waitbar(0,'loading data...');
    InLoading=get(handles.FolderNameList,'String');
    
    % vectors for storing the additional info extracted from file names:
    if extractpxls
        PixelsXdim=zeros(1,length(InLoading)); % size of single stim in the X dimension (eg for 'X30' file it is 30)
        PixelsYdim=zeros(1,length(InLoading)); % size of single stim in the Y dimension (eg for 'X30' file it is 300)
    end
    if extractint
        Ints=zeros(1,length(InLoading)); % steps 1..4 or 0.1, 0.2 ... -> later convert to intensities using right Intensities table (one table per experiment/day usually)
    end
    if extracteps
        EpStart=zeros(1,length(InLoading));
        EpEnd=zeros(1,length(InLoading));
    end
    if extractfov
        FOV=zeros(1,length(InLoading)); % _f2 at the end of file name means FOV 2
    end
    if extractstimdur
        StimDur=zeros(1,length(InLoading));
    end
    if extractfilenb
        Filenb=zeros(1,length(InLoading));
    end
    
    NbTraces=zeros(1,length(InLoading));
    tot_traces=0;
    
    n=0; %counter for new created Traces
    for i=1:1:length(InLoading)
        
        LocalFile=InLoading{i};
        BeginTrace=BeginTrace+n;
        
        if exist('matfile')==2
            matObj = matfile(LocalFile);
            info=whos(matObj,'SpikeTraceData');
        else
            info=whos('-file',LocalFile,'SpikeTraceData');
        end
        
        NumberTrace=max(info.size);
        
        NbTraces(i)=NumberTrace;
        
        ListTraceToLoad=1:NumberTrace;
        
        if exist('matfile')==2
            matObj = matfile(LocalFile);
            SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
            n=NumberTrace;
        else
            Tmp=load(LocalFile,'SpikeTraceData');
            SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);
            n=NumberTrace;
        end
        
%         delete(h);
        
        [savepath,savefile,ext]=fileparts(LocalFile)
        
        % 07-31-2012--1_ep29-150_stitch_all
        
        if extractfilenb
            Filenb(i)=sscanf(savefile,'%*12c %d %*s');
        end
        
        sfn=sscanf(savefile, '%12c %d %*s');
        savefilenew=savefile(1:length(sfn));
        
        if extracteps
            eps=sscanf(savefile, '%*12c %*d %*3c %d %*c %d %*s');
            
            savefile_epstart=eps(1);
            savefile_eplast=eps(2);
            
            EpStart(i)=eps(1);
            EpEnd(i)=eps(2);
        end
        
        if (extractpxls||extractint||extractstimdur)
            %%% extract also other info from file names:
            %%% %%%%%%%%%%%%%%%%%%%%%%%%%% ex. file names:
            %C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\061912\cell2\psths\06-19-2012--16_ep25-47_psths_300px_0p5.mat
            %C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\061912\cell2\psths\06-19-2012--12_ep391-633_psths_X30px_0p4.mat
            
            endname=char(sscanf(savefile,'%*12c %*d %*3c %*d %*c %*d %*7c %s')') % X30px_0p4 or 300px_0p5 or sq60px_0p5
            
            
            %remove "_CK" from end of endname if present:
            if strcmp(endname(end-2:end),'_CK')
                endname=endname(1:end-3);
            end
            
            %remove FOV nb if present:
            if strcmp(endname(end-1),'f')
                if extractfov
                    FOV(i)=str2num(endname(end));
                end
                endname=endname(1:end-3);
            end
            
            if strcmp(endname(1),'X')
                if extractpxls
                    PixelsXdim(i)=sscanf(endname,'%*1c %d %*s');
                    PixelsYdim(i)=300;
                end
                if (extractint||extractstimdur)
                    int_temp=sscanf(endname,'%*1c %*d %*3c %s');
                end
            elseif strcmp(endname(1),'Y')
                if extractpxls
                    PixelsXdim(i)=300;
                    PixelsYdim(i)=sscanf(endname,'%*1c %d %*s');
                end
                if (extractint||extractstimdur)
                    int_temp=sscanf(endname,'%*1c %*d %*3c %s');
                end
            elseif strcmp(endname(1),'s')
                if extractpxls
                    PixelsXdim(i)=sscanf(endname,'%*2c %d %*s');
                    PixelsYdim(i)=sscanf(endname,'%*2c %d %*s');
                end
                if (extractint||extractstimdur)
                    int_temp=sscanf(endname,'%*2c %*d %*3c %s');
                end
            else
                if extractpxls
                    PixelsXdim(i)=300;
                    PixelsYdim(i)=300;
                end
                if (extractint||extractstimdur)
                    int_temp=sscanf(endname,'%*d %*3c %s');
                end
            end
            
            if extractint
                int_string=char(int_temp)';
                int3c=sscanf(int_string,'%*c %c %*s');
                if strcmp(int3c,'p')
                    int_string(2)='.';   % convert '0p3' into '0.3'
                end
                
                %new possibility for int_string: '0.1_0p04s' or '5_0p2s'
                unds=strfind(int_string,'_');
                sec=strfind(int_string,'s');
                if (isempty(unds)&&isempty(sec))
                    Ints(i)=str2double(int_string);
                elseif (~isempty(sec)&&~isempty(unds))
                    int_string=int_string(1:unds(1)-1);
                    Ints(i)=str2double(int_string);
                end;
            end
            
            if extractstimdur   % possibility for int_string: '0.1_0p04s' or '5_0p2s' or '0p1s'
                int_string=char(int_temp)';
                unds=strfind(int_string,'_');
                sec=strfind(int_string,'s');
                
                if (~isempty(sec)&&~isempty(unds)) % ex. '0.1_0p04s' or '5_0p2s'
                    int_string=int_string(unds(1)+1:sec(1)-1);
                    int3c=sscanf(int_string,'%*c %c %*s');
                    if strcmp(int3c,'p')
                        int_string(2)='.';   % convert '0p3' into '0.3'
                    end
                elseif (~isempty(sec)&&isempty(unds)) % ex. '0p1s'
                       int_string=int_string(1:sec(1)-1);
                    int3c=sscanf(int_string,'%*c %c %*s');
                    if strcmp(int3c,'p')
                        int_string(2)='.';   % convert '0p3' into '0.3'
                    end 
                end
                
                StimDur(i)=str2double(int_string);
                
            end
            
            
            
        end
        
        savefile=[savepath '\' savefilenew]
        
   tot_traces=tot_traces+NumberTrace;
        
    end
    
    
    if extracteps
        EpStartAll=zeros(1,tot_traces);
        EpEndAll=zeros(1,tot_traces);
    end
    if extractpxls
        PixelsXdimAll=zeros(1,tot_traces);
        PixelsYdimAll=zeros(1,tot_traces);
    end
    if extractint
        IntsAll=zeros(1,tot_traces);
    end
    if extractfov
        FOVAll=zeros(1,tot_traces);
    end
    if extractstimdur
        StimDurAll=zeros(1,tot_traces);
    end
    if extractfilenb
        FilenbAll=zeros(1,tot_traces);
    end
    
    j=1;
    jk=1;
    for k=1:length(InLoading) %file count
        for j=jk:jk+NbTraces(k)-1
            if extracteps
            EpStartAll(j)=EpStart(k);
            EpEndAll(j)=EpEnd(k);
            end
            if extractpxls
            PixelsXdimAll(j)=PixelsXdim(k);
            PixelsYdimAll(j)=PixelsYdim(k);
            end
            if extractint
            IntsAll(j)=Ints(k);
            end
            if extractfov
            FOVAll(j)=FOV(k);
            end
            if extractstimdur
            StimDurAll(j)=StimDur(k);
            end
            if extractfilenb
            FilenbAll(j)=Filenb(k);
            end
        end
        jk=j+1;
    end
    
    % now store in SpikeDataTrace:
    
    if extracteps
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=EpStartAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Ep Start for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='ep start';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=EpEndAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Ep End for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='ep end';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
    end
    
    if extractpxls
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=PixelsXdimAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Pixels Xdim for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='pixels xdim';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=PixelsYdimAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Pixels Ydim for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='pixels ydim';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
    end
    
    if extractint
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=IntsAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Ints for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='ints';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
    end
    
    if keepnbtraces
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:length(InLoading);
        SpikeTraceData(BeginTrace).Trace=NbTraces;
        SpikeTraceData(BeginTrace).DataSize=length(InLoading);
        
        SpikeTraceData(BeginTrace).Label.ListText='Nb Traces for Loaded Files';
        SpikeTraceData(BeginTrace).Label.YLabel='nb traces';
        SpikeTraceData(BeginTrace).Label.XLabel='file nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
    end
    
    if extractfov
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=FOVAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='FOV for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='FOV #';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
    end
    
    if extractstimdur
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=StimDurAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='Stim. Duration for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='s';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
    end
    
    if extractfilenb
        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:1:tot_traces;
        SpikeTraceData(BeginTrace).Trace=FilenbAll;
        SpikeTraceData(BeginTrace).DataSize=tot_traces;
        
        SpikeTraceData(BeginTrace).Label.ListText='File Nb for Loaded Traces';
        SpikeTraceData(BeginTrace).Label.YLabel='file nb';
        SpikeTraceData(BeginTrace).Label.XLabel='trace nb';
        SpikeTraceData(BeginTrace).Filename=savefilenew;
        SpikeTraceData(BeginTrace).Path=savepath;
        
    end
    
    ValidateValues_Callback(hObject, eventdata, handles);
    set(InterfaceObj,'Enable','on');
    
catch errorObj
    set(InterfaceObj,'Enable','on');
    
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
%     if exist('h','var')
%         if ishandle(h)
% %             delete(h);
%         end
%     end
end


% --- Executes on button press in SelectFile.
function SelectFile_Callback(hObject, eventdata, handles)
% hObject    handle to SelectFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;


% Open file path
user_cancelled=0;
InLoading=uipickfiles('Type', { '*.mat',   'MAT-files'});
CancelError=whos('InLoading');
if (length(InLoading)==0 || strcmp(CancelError.class,'double'))
    user_cancelled=1;
end

% Open file if exist
% If "Cancel" is selected then return
if user_cancelled==1
    return
    
    % Otherwise construct the fullfilename and Check and load the file
else
    % To keep the path accessible to future request
    
    for i=1:1:length(InLoading)
        [pathname, filename, ext]=fileparts(InLoading{i});
    end
    
    cd(pathname);
    
    set(handles.FolderNameList,'String', InLoading);  
%     InLoading{1}
  

end


% % Open file if exist
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     
%     % Otherwise construct the fullfilename and Check and load the file
% else
%     % To keep the path accessible to futur request
%     cd(pathname);
%     try
%         InterfaceObj=findobj(handles.output,'Enable','on');
%         set(InterfaceObj,'Enable','off');
%         h=waitbar(0,'Checking data...');
%         
%         LocalFile=fullfile(pathname,filename);
%         
%         if exist('matfile')==2
%             matObj = matfile(LocalFile);
%             info=whos(matObj,'SpikeTraceData');
%         else
%             info=whos('-file',LocalFile,'SpikeTraceData');
%         end
%         
%         if ~isempty(info)
%             NumberTrace=max(info.size);
%             for i=1:NumberTrace
%                 TextTrace{i}=[,'Trace ' num2str(i)];
%             end
%             set(handles.FilenameShow,'String',LocalFile);
%             set(handles.TraceSelectionList,'String',TextTrace);
%         else
%             msgbox('No Traces in this file');
%         end
%         
%         delete(h);
%         set(InterfaceObj,'Enable','on');
%         
%     catch errorObj
%         set(InterfaceObj,'Enable','on');
%         % If there is a problem, we display the error message
%         errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
%         if exist('h','var')
%             if ishandle(h)
%                 delete(h);
%             end
%         end
%     end
% end


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


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% % --- Executes on button press in SelectAllTrace.
% function SelectAllTrace_Callback(hObject, eventdata, handles)
% % hObject    handle to SelectAllTrace (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of SelectAllTrace
% if (get(handles.SelectAllTrace,'Value')==1)
%     set(handles.TraceSelectionList,'Enable','off');
% else
%     set(handles.TraceSelectionList,'Enable','on');
% end


% --- Executes on selection change in FolderNameList.
function FolderNameList_Callback(hObject, eventdata, handles)
% hObject    handle to FolderNameList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FolderNameList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FolderNameList


% --- Executes during object creation, after setting all properties.
function FolderNameList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FolderNameList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ExtractPxls.
function ExtractPxls_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractPxls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractPxls


% --- Executes on button press in ExtractInt.
function ExtractInt_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractInt


% --- Executes on button press in ExtractEps.
function ExtractEps_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractEps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractEps


% --- Executes on button press in KeepNbTraces.
function KeepNbTraces_Callback(hObject, eventdata, handles)
% hObject    handle to KeepNbTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of KeepNbTraces


% --- Executes on button press in ExtractFOV.
function ExtractFOV_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractFOV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractFOV


% --- Executes on button press in ExtractStimDur.
function ExtractStimDur_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractStimDur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractStimDur


% --- Executes on button press in ExtractFilenb.
function ExtractFilenb_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractFilenb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ExtractFilenb
