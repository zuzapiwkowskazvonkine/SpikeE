function varargout = Distributions_diffbins(varargin)
% DISTRIBUTIONS_DIFFBINS M-file for Distributions_diffbins.fig
%      DISTRIBUTIONS_DIFFBINS, by itself, creates a new DISTRIBUTIONS_DIFFBINS or raises the existing
%      singleton*.
%
%      H = DISTRIBUTIONS_DIFFBINS returns the handle to a new DISTRIBUTIONS_DIFFBINS or the handle to
%      the existing singleton*.
%
%      DISTRIBUTIONS_DIFFBINS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISTRIBUTIONS_DIFFBINS.M with the given input arguments.
%
%      DISTRIBUTIONS_DIFFBINS('Property','Value',...) creates a new DISTRIBUTIONS_DIFFBINS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Distributions_diffbins_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Distributions_diffbins_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Distributions_diffbins

% Last Modified by GUIDE v2.5 21-Jan-2013 13:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Distributions_diffbins_OpeningFcn, ...
                   'gui_OutputFcn',  @Distributions_diffbins_OutputFcn, ...
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


% --- Executes just before Distributions_diffbins is made visible.
function Distributions_diffbins_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Distributions_diffbins (see VARARGIN)

% Choose default command line output for Distributions_diffbins
handles.output = hObject;

% UIWAIT makes Distributions_diffbins wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;


set(handles.PathForLoading,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_Purkinje';

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelectorOld,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelectorOld,'Value',Settings.TraceSelectorValue);
    set(handles.StartBin1,'String',Settings.StartBin1String);
    set(handles.StopBin1,'String',Settings.StopBin1String);
    set(handles.StartBin2,'String',Settings.StartBin2String);
    set(handles.StopBin2,'String',Settings.StopBin2String);
    set(handles.GetThresh,'Value',Settings.GetThreshValue);
    set(handles.FalsePosRatio,'String',Settings.FalsePosRatioString);
    set(handles.MaxSurprise,'Value',Settings.MaxSurpriseValue);
    set(handles.NegSurprise,'Value',Settings.NegSurpriseValue);
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    handles.Path=Settings.Path;
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Distributions_diffbins_OutputFcn(hObject, eventdata, handles) 
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
Settings.StartBin1String=get(handles.StartBin1,'String');
Settings.StopBin1String=get(handles.StopBin1,'String');
Settings.StartBin2String=get(handles.StartBin2,'String');
Settings.StopBin2String=get(handles.StopBin2,'String');
Settings.FalsePosRatioString=get(handles.FalsePosRatio,'String');
Settings.GetThreshValue=get(handles.GetThresh,'Value');
Settings.MaxSurpriseValue=get(handles.MaxSurprise,'Value');
Settings.NegSurpriseValue=get(handles.NegSurprise,'Value');
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

startbin1=str2double(get(handles.StartBin1,'String'));
stopbin1=str2double(get(handles.StopBin1,'String'));
startbin2=str2double(get(handles.StartBin2,'String'));
stopbin2=str2double(get(handles.StopBin2,'String'));
falseposratio=str2double(get(handles.FalsePosRatio,'String'));
getthresh=get(handles.GetThresh,'Value');
maxsurprise=get(handles.MaxSurprise,'Value');
negsurprise=get(handles.NegSurprise,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter



% get list of folders (one per binsize and start point)
allfolders=dir(handles.Path);
nbdirs=length(allfolders);

for i=3:nbdirs %loop over folders (first 2 are '.' and '..')
    
    temp1=[];
    temp2=[];
    temp1n=[];
    temp2n=[];
    
    %parse folder name to get binsize and start bin (ex. 'surprise_bin_19ms_13')
    nametoparse=allfolders(i).name
    
    if (strcmp(nametoparse,'PSTHs') | strcmp(nametoparse,'Analysis_Windows') | strcmp(nametoparse,'Other'))
    else
        
        a=strfind(nametoparse,'bin_');
        nametoparse2=nametoparse(a+4:end)
        nbs=sscanf(nametoparse2,'%d %*3c %d');
        binsize=nbs(1);
        startbin=nbs(2);
        
        allfiles=dir([handles.Path '\' allfolders(i).name]);
        nbfiles=length(allfiles);
        
        %clear SpikeTraceData before analyzing each folder
        InitTraces();
        filecount=0;
        
        for j=3:nbfiles %loop over files in this folder
            
            nameend=allfiles(j).name(end-7:end-4)
            if strcmp(nameend,'info')
                %do not download
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
            end
        end
        loaded_traces=length(SpikeTraceData)
        loaded_files=filecount
        
        %adjust analysis start and stop bins, so that all analyzed bins are completely included in the chosen startbin-stopbin (in ms) interval:
        %spontaneous activity:
        vec=[];
        vec=find(SpikeTraceData(1).XVector>=startbin1 & SpikeTraceData(1).XVector<=stopbin1-binsize);
        startbin1i=min(vec)
        stopbin1i=max(vec)
        
        %post-stimulus activity:
        
        vec=find(SpikeTraceData(1).XVector>=startbin2 & SpikeTraceData(1).XVector<=stopbin2-binsize);
        startbin2i=min(vec);
        stopbin2i=max(vec);
        
        %compute nb of bins in each chunk:
        sizechunk1=stopbin1i-startbin1i+1;
        sizechunk2=stopbin2i-startbin2i+1;
        
        % Carfeul: now startbin1 etc are directly actual bin INDICES, not times
        % in ms.
        
        % make distributions and extract threshold
        
        for k=1:length(SpikeTraceData)
            
            if maxsurprise
                
                temp1(end+1)=max(SpikeTraceData(k).Trace(startbin1i:stopbin1i));
                temp2(end+1)=max(SpikeTraceData(k).Trace(startbin2i:stopbin2i));
                temp1n(end+1)=min(SpikeTraceData(k).Trace(startbin1i:stopbin1i));
                temp2n(end+1)=min(SpikeTraceData(k).Trace(startbin2i:stopbin2i));
            else
                temp1(end+1:end+sizechunk1)=SpikeTraceData(k).Trace(startbin1i:stopbin1i);
                temp2(end+1:end+sizechunk2)=SpikeTraceData(k).Trace(startbin2i:stopbin2i);
                temp1n=temp1;
                temp2n=temp2;
            end
            
        end
        
        % for positive values:
        temp1pos=temp1(temp1>=0);
        temp2pos=temp2(temp2>=0);
        
        [temp1cdf,x1]=ecdf(temp1pos);
        [temp2cdf,x2]=ecdf(temp2pos);
        
        % for negative values
        if negsurprise
            temp1neg=temp1n(temp1n<0);
            temp2neg=temp2n(temp2n<0);
            
            [temp1cdfn,x1n]=ecdf(-temp1neg);
            [temp2cdfn,x2n]=ecdf(-temp2neg);
        end
        
        
        if getthresh
            vec=find(temp1cdf>1-falseposratio);
            thresh=x1(vec(1))
            if negsurprise
                vecn=find(temp1cdfn>1-falseposratio);
                threshneg=-x1n(vecn(1))
            end
        end
        
        
        if startbin==1
            figure;
            title([num2str(binsize) 'ms bins,' num2str(startbin)]);
            binnb=floor(max(max(temp1),max(temp2)));
            [hy1,hx]=hist(temp1,[0:binnb]);
            size(hy1)
            size(hx)
            % bar(hx1,hy1);
            hold on;
            hy2=hist(temp2,[0:binnb]);
            size(hy2)
            
            bar(hx',[hy1' hy2']);
            
            ythresh=max(hist(temp1,[0:ceil(max(temp1))]));
            
            if getthresh
                hold on
                stem(thresh,ythresh,'k');
            end
            
            % cumulative distrib. plot
            %     figure
            %     title([num2str(binsize) 'ms bins,' num2str(startbin)]);
            %     plot(x1,temp1cdf);
            %     hold on
            %     plot(x2,temp2cdf,'r');
            %
            %     if getthresh
            %         hold on
            %         stem(thresh,1,'k');
            %     end
            
            if negsurprise
                figure;
                title([num2str(binsize) 'ms bins,' num2str(startbin)]);
                binnb=ceil(min(min(temp1neg,min(temp2neg))));
                [hny1,hnx]=hist(temp1neg,[binnb:0]);
                %     bar(hnx1,hny1);
                hold on;
                hny2=hist(temp2neg,[binnb:0]);
                bar(hnx',[hny1' hny2']);
                
                ythreshn=max(hist(temp1neg,[floor(min(temp1neg)):0]));
                
                if getthresh
                    hold on
                    stem(threshneg,ythreshn,'k');
                end
                
                % cumulative distrib. plot
                %         figure
                %         title([num2str(binsize) 'ms bins,' num2str(startbin)]);
                %         plot(x1n,temp1cdfn);
                %         hold on
                %         plot(x2n,temp2cdfn,'r');
                %
                %         if getthresh
                %             hold on
                %             stem(-threshneg,1,'k');
                %         end
            end
        end
        
        BeginTrace=length(SpikeTraceData)+1;
        if negsurprise
            SpikeTraceData(BeginTrace).XVector=1:2;
            SpikeTraceData(BeginTrace).Trace(1)=thresh;
            SpikeTraceData(BeginTrace).Trace(2)=threshneg;
            SpikeTraceData(BeginTrace).DataSize=2;
        else
            SpikeTraceData(BeginTrace).XVector=1;
            SpikeTraceData(BeginTrace).Trace(1)=thresh;
            SpikeTraceData(BeginTrace).DataSize=1;
        end
        
        if maxsurprise
            name=['surprise thresholds, false positive PSTHs: ' num2str(falseposratio)];
        else
            name=['surprise thresholds, false positive bins: ' num2str(falseposratio)];
        end
        SpikeTraceData(BeginTrace).Label.ListText=name;
        SpikeTraceData(BeginTrace).Label.YLabel='Surprise threshold';
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(1).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(1).Path;
        
        OldData=SpikeTraceData;
        %     SpikeTraceDataSave=struct('Path',{},'Filename',{},'Trace',{},...
        %     'DataSize',{},'XVector',{},'Label',struct('ListText',{},'XLabel',{},'YLabel',{}));
        SpikeTraceDataSave=SpikeTraceData(BeginTrace);
        
        % now open all 'info' files and add SpikeTraceData object containing
        % the threshold/thresholds
        
        for j=3:nbfiles %loop over files in this folder again
            nameend=allfiles(j).name(end-7:end-4);
            if strcmp(nameend,'info')
                LocalFile=[handles.Path '\' allfolders(i).name '\' allfiles(j).name];
                info=whos('-file',LocalFile,'SpikeTraceData');
                NumberTraces=max(info.size);
                temp=load(LocalFile,'SpikeTraceData');
                SpikeTraceData=temp.SpikeTraceData(1:NumberTraces);
                SpikeTraceData(NumberTraces+1)=SpikeTraceDataSave;
                save(LocalFile,'SpikeTraceData');
            end
        end
        
        SpikeTraceData=OldData;
    end
end










% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;


function StartBin1_Callback(hObject, eventdata, handles)
% hObject    handle to StartBin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBin1 as text
%        str2double(get(hObject,'String')) returns contents of StartBin1 as a double


% --- Executes during object creation, after setting all properties.
function StartBin1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopBin1_Callback(hObject, eventdata, handles)
% hObject    handle to StopBin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBin1 as text
%        str2double(get(hObject,'String')) returns contents of StopBin1 as a double


% --- Executes during object creation, after setting all properties.
function StopBin1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function StartBin2_Callback(hObject, eventdata, handles)
% hObject    handle to StartBin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBin2 as text
%        str2double(get(hObject,'String')) returns contents of StartBin2 as a double


% --- Executes during object creation, after setting all properties.
function StartBin2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopBin2_Callback(hObject, eventdata, handles)
% hObject    handle to StopBin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBin2 as text
%        str2double(get(hObject,'String')) returns contents of StopBin2 as a double


% --- Executes during object creation, after setting all properties.
function StopBin2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetThresh.
function GetThresh_Callback(hObject, eventdata, handles)
% hObject    handle to GetThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GetThresh



function FalsePosRatio_Callback(hObject, eventdata, handles)
% hObject    handle to FalsePosRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FalsePosRatio as text
%        str2double(get(hObject,'String')) returns contents of FalsePosRatio as a double


% --- Executes during object creation, after setting all properties.
function FalsePosRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FalsePosRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MaxSurprise.
function MaxSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to MaxSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MaxSurprise


% --- Executes on button press in NegSurprise.
function NegSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to NegSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegSurprise


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
