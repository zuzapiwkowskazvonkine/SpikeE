function varargout = Analyze_PSTH_Poisson_diffbins(varargin)
% ANALYZE_PSTH_POISSON_DIFFBINS M-file for Analyze_PSTH_Poisson_diffbins.fig
%      ANALYZE_PSTH_POISSON_DIFFBINS, by itself, creates a new ANALYZE_PSTH_POISSON_DIFFBINS or raises the existing
%      singleton*.
%
%      H = ANALYZE_PSTH_POISSON_DIFFBINS returns the handle to a new ANALYZE_PSTH_POISSON_DIFFBINS or the handle to
%      the existing singleton*.
%
%      ANALYZE_PSTH_POISSON_DIFFBINS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZE_PSTH_POISSON_DIFFBINS.M with the given input arguments.
%
%      ANALYZE_PSTH_POISSON_DIFFBINS('Property','Value',...) creates a new ANALYZE_PSTH_POISSON_DIFFBINS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analyze_PSTH_Poisson_diffbins_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analyze_PSTH_Poisson_diffbins_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analyze_PSTH_Poisson_diffbins

% Last Modified by GUIDE v2.5 18-Jan-2013 18:23:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analyze_PSTH_Poisson_diffbins_OpeningFcn, ...
                   'gui_OutputFcn',  @Analyze_PSTH_Poisson_diffbins_OutputFcn, ...
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


% --- Executes just before Analyze_PSTH_Poisson_diffbins is made visible.
function Analyze_PSTH_Poisson_diffbins_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analyze_PSTH_Poisson_diffbins (see VARARGIN)

% Choose default command line output for Analyze_PSTH_Poisson_diffbins
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analyze_PSTH_Poisson_diffbins wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

    set(handles.SavePath,'String','C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai27_Pje');
    handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai27_Pje';

if (length(varargin)>1)
    Settings=varargin{2};
    %     set(handles.TraceSelector,'String',Settings.TraceSelectorString);
%     set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
%     set(handles.CrossType1,'String',Settings.CrossType1String);
%     set(handles.CrossType1,'Value',Settings.CrossType1Value);
%     set(handles.Threshold1,'String',Settings.Threshold1String);
%     set(handles.CrossType2,'String',Settings.CrossType2String);
%     set(handles.CrossType2,'Value',Settings.CrossType2Value);
%     set(handles.Threshold2,'String',Settings.Threshold2String);
%     set(handles.StartBin,'String',Settings.StartBinString);
%     set(handles.StopBin,'String',Settings.StopBinString);
    set(handles.FirstBinsize,'String',Settings.FirstBinsizeString);
    set(handles.BinsizeStep,'String',Settings.BinsizeStepString);
    set(handles.LastBinsize,'String',Settings.LastBinsizeString);
    set(handles.StartBinBaseline,'String',Settings.StartBinBaselineString);
    set(handles.StopBinBaseline,'String',Settings.StopBinBaselineString);  
    set(handles.NbRepsBurst,'String',Settings.NbRepsBurstString);
    set(handles.SavePath,'String',Settings.SavePathString);
    set(handles.CellNb,'String',Settings.CellNbString);
    handles.Path=Settings.Path;
end

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace3{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector3,'String',TextTrace3);
    set(handles.TraceSelectorInfo,'String',TextTrace);
    
end

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Analyze_PSTH_Poisson_diffbins_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.TraceSelector3String=get(handles.TraceSelector3,'String');
Settings.TraceSelector3Value=get(handles.TraceSelector3,'Value');
Settings.StartBinBaselineString=get(handles.StartBinBaseline,'String');
Settings.StopBinBaselineString=get(handles.StopBinBaseline,'String');
Settings.FirstBinsizeString=get(handles.FirstBinsize,'String');
Settings.BinsizeStepString=get(handles.BinsizeStep,'String');
Settings.LastBinsizeString=get(handles.LastBinsize,'String');
Settings.NbRepsBurstString=get(handles.NbRepsBurst,'String');
Settings.SavePathString=get(handles.SavePath,'String');
Settings.CellNbString=get(handles.CellNb,'String');
Settings.Path=handles.Path;


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ValidateValues_Callback(hObject, eventdata, handles);

% this function returns durations of events based on vectors of event
% onsets and offsets

% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;

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

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in TraceSelector.
function TraceSelector3_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector

% --- Executes during object creation, after setting all properties.
function TraceSelector3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function StartBin_Callback(hObject, eventdata, handles)
% hObject    handle to StartBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBin as text
%        str2double(get(hObject,'String')) returns contents of StartBin as a double

% --- Executes during object creation, after setting all properties.
function StartBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function StopBin_Callback(hObject, eventdata, handles)
% hObject    handle to StopBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBin as text
%        str2double(get(hObject,'String')) returns contents of StopBin as a double


% --- Executes during object creation, after setting all properties.
function StopBin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function StartBinBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to StartBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartBinBaseline as text
%        str2double(get(hObject,'String')) returns contents of StartBinBaseline as a double


% --- Executes during object creation, after setting all properties.
function StartBinBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopBinBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to StopBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopBinBaseline as text
%        str2double(get(hObject,'String')) returns contents of StopBinBaseline as a double


% --- Executes during object creation, after setting all properties.
function StopBinBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopBinBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GetMeanRate.
function GetMeanRate_Callback(hObject, eventdata, handles)
% hObject    handle to GetMeanRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

TracesToApply=get(handles.TraceSelector,'Value');
TraceNbTrials=get(handles.TraceSelector3,'Value');

startbin=str2double(get(handles.StartBinBaseline,'String'));
stopbin=str2double(get(handles.StopBinBaseline,'String'));
binsize=str2double(get(handles.FirstBinsize,'String'))/1000; % ms converted to sec
nbreps=str2double(get(handles.NbRepsBurst,'String'));


bsavg=zeros(1,length(TracesToApply));
bsavghz=zeros(1,length(TracesToApply));
i=1;

for k=TracesToApply 
    firstbin=SpikeTraceData(k).XVector(1);   
    psth_order=k-TracesToApply(1)+1;  %eg for psths k=13,14,15, order will be 1,2,3
    bsavg(i)=mean(SpikeTraceData(k).Trace(startbin-firstbin+1:stopbin-firstbin)); % this is now in spike numbers per bin (for all trials)  
    if SpikeTraceData(TraceNbTrials).Trace(psth_order)>0
        bsavghz(i)=bsavg(i)/(nbreps*binsize*SpikeTraceData(TraceNbTrials).Trace(psth_order)); % and this is in Hz
    else
        bsavghz(i)=0;
    end
    i=i+1;  
end

bsavghzall=mean(bsavghz)
set(handles.BaselineAvg,'String',num2str(bsavghzall));

BeginTrace=length(SpikeTraceData)+1;
SpikeTraceData(BeginTrace).XVector=1; %%%%
SpikeTraceData(BeginTrace).Trace=bsavghzall;
SpikeTraceData(BeginTrace).DataSize=1;

name=['baseline avg rate, bins ' num2str(startbin) '-' num2str(stopbin)];
SpikeTraceData(BeginTrace).Label.ListText=name;
SpikeTraceData(BeginTrace).Label.YLabel='Hz';
SpikeTraceData(BeginTrace).Label.XLabel='';
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;

handles.BaselineSaveIndex=BeginTrace; % store index of SpikeTraceData here for future saving of info
guidata(hObject,handles);


% --- Executes on button press in GetSurprise.
function GetSurprise_Callback(hObject, eventdata, handles)
% hObject    handle to GetSurprise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData
global SpikeTraceDataHidden

TracesToApply=get(handles.TraceSelector,'Value');
TraceNbTrials=get(handles.TraceSelector3,'Value');

bsmeanrate=str2double(get(handles.BaselineAvg,'String'));
binsize1=str2double(get(handles.FirstBinsize,'String')); 
binsize2=str2double(get(handles.LastBinsize,'String'));%in ms
binsizestep=str2double(get(handles.BinsizeStep,'String'));
nbreps=str2double(get(handles.NbRepsBurst,'String'));
cellnbst=get(handles.CellNb,'String');

BeginTrace=length(SpikeTraceDataHidden)+1;
n=0; %new trace counter

for b=binsize1:binsizestep:binsize2 % loop over binsizes
    
    binsize=b; %in ms, careful!
    
    
    for s=1:binsize  %loop over all possible starting positions for the first bin
     
        savestart=BeginTrace+n;
        
        for k=TracesToApply
         
            % make PSTH(binsize,s)
            if binsize==1
                PSTH=SpikeTraceData(k).Trace;
                times=SpikeTraceData(k).XVector;
            else
                
                PSTH=[];
                times=[];
                nbbins=floor((length(SpikeTraceData(k).Trace)-s+1)/binsize); 
                % nb of full-size bins that can fit into the analyzed Trace, when starting at point s (ie removing s-1 pts from start of Trace)
                
                for z=s:binsize:s+(binsize*(nbbins-1))
                    PSTH(end+1)=sum(SpikeTraceData(k).Trace(z:z+binsize-1));
                    times(end+1)=SpikeTraceData(k).XVector(z);
                end
            
            end
            
            psth_order=k-TracesToApply(1)+1;
            trialnb=SpikeTraceData(TraceNbTrials).Trace(psth_order);
            PoissonExpspikenb=bsmeanrate*trialnb*nbreps*binsize/1000; % binsize converted to sec here
            
            surprise=zeros(1,length(PSTH));
            
            for z=1:length(PSTH)
                m=PSTH(z); 
                tempsurprise=poissoncdf(PoissonExpspikenb,m);  %  m needs to be an integer (spike number, not possible to use an averaged spike number)
                
                if m>PoissonExpspikenb
                    if tempsurprise>1-10^(-15)   %double precision limitation
                        surprise(z)=15;
                    else
                        surprise(z)=-log10(1-tempsurprise); %big positive values will be Significant Increases in Firing
                    end
                else
                    surprise(z)=log10(tempsurprise);   %big negative values will be Significant Firing Suppressions
                end;
            end;
               
            % Surprise PSTH
            SpikeTraceDataHidden(BeginTrace+n).XVector=times; %%%%
            SpikeTraceDataHidden(BeginTrace+n).Trace=surprise;
            SpikeTraceDataHidden(BeginTrace+n).DataSize=length(surprise);
            
            name=['surprise ' num2str(binsize) 'ms,' num2str(s) ', ' SpikeTraceData(k).Label.ListText(11:end)];
            SpikeTraceDataHidden(BeginTrace+n).Label.ListText=name;
            SpikeTraceDataHidden(BeginTrace+n).Label.YLabel='Surprise';
            SpikeTraceDataHidden(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
            SpikeTraceDataHidden(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
            SpikeTraceDataHidden(BeginTrace+n).Path=SpikeTraceData(k).Path;
            n=n+1;
                   
            
        end
     saveend=BeginTrace+n-1;   
     % create folder and save Traces for this set (binsize,s).    
     namefolder =['surprise_bin_' num2str(binsize) 'ms_' num2str(s)];
     mkdir(handles.Path,namefolder);
     savepath=[handles.Path '\' namefolder '\'];
     filedate=sscanf(SpikeTraceDataHidden(BeginTrace+n-1).Filename,'%12c %*s')
     
     OldData=SpikeTraceData;
    
     SpikeTraceData=SpikeTraceData(handles.InfoTraces);
     savefile=[savepath filedate 'cell' cellnbst '_info.mat'];
     save(savefile,'SpikeTraceData');
     
     savefile=[savepath filedate 'cell' cellnbst '.mat'];
     SpikeTraceData=SpikeTraceDataHidden(savestart:saveend);
     save(savefile,'SpikeTraceData');
     
     SpikeTraceData=OldData;
      
    end
end

% also save the analyzed PSTHs (TracesToApply) and the info into a 'PSTHs' folder (for future analyses of response amplitudes, latencies etc.)
namefolder='PSTHs';
mkdir(handles.Path,namefolder);
savepath=[handles.Path '\' namefolder '\'];
OldData=SpikeTraceData;

SpikeTraceData=SpikeTraceData(handles.InfoTraces);
savefile=[savepath filedate 'cell' cellnbst '_info.mat'];
save(savefile,'SpikeTraceData');

SpikeTraceData=OldData(TracesToApply);
savefile=[savepath filedate 'cell' cellnbst '_psths.mat'];
save(savefile,'SpikeTraceData');

SpikeTraceData=OldData;



function out=poissoncdf(lambda,k)
% cumulative distribution function for the Poisson distribution (from Luc/Valerie's Elphy code)

sum=0;
temp=exp(-lambda);
for i=0:k
    sum = sum + temp;
    temp=temp*lambda/(i+1);  % temp is the next term to be added, at step i+1
end;
out=sum;








function FirstBinsize_Callback(hObject, eventdata, handles)
% hObject    handle to FirstBinsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstBinsize as text
%        str2double(get(hObject,'String')) returns contents of FirstBinsize as a double


% --- Executes during object creation, after setting all properties.
function FirstBinsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstBinsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NbRepsBurst_Callback(hObject, eventdata, handles)
% hObject    handle to NbRepsBurst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbRepsBurst as text
%        str2double(get(hObject,'String')) returns contents of NbRepsBurst as a double


% --- Executes during object creation, after setting all properties.
function NbRepsBurst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbRepsBurst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function BinsizeStep_Callback(hObject, eventdata, handles)
% hObject    handle to BinsizeStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BinsizeStep as text
%        str2double(get(hObject,'String')) returns contents of BinsizeStep as a double


% --- Executes during object creation, after setting all properties.
function BinsizeStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BinsizeStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LastBinsize_Callback(hObject, eventdata, handles)
% hObject    handle to LastBinsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LastBinsize as text
%        str2double(get(hObject,'String')) returns contents of LastBinsize as a double


% --- Executes during object creation, after setting all properties.
function LastBinsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LastBinsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in InitHidden.
function InitHidden_Callback(hObject, eventdata, handles)
% hObject    handle to InitHidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceDataHidden

InitHiddenTraces();


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
    set(handles.SavePath,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end




function CellNb_Callback(hObject, eventdata, handles)
% hObject    handle to CellNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CellNb as text
%        str2double(get(hObject,'String')) returns contents of CellNb as a double


% --- Executes during object creation, after setting all properties.
function CellNb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CellNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in TraceSelectorInfo.
function TraceSelectorInfo_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorInfo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorInfo

% --- Executes during object creation, after setting all properties.
function TraceSelectorInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SelectInfo.
function SelectInfo_Callback(hObject, eventdata, handles)
% hObject    handle to SelectInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

TracesToSave1=get(handles.TraceSelectorInfo,'Value');
TracesToSave2=get(handles.TraceSelector3,'Value');
TracesToSave3=handles.BaselineSaveIndex;

TracesToSave=sort([TracesToSave1 TracesToSave2 TracesToSave3]);
handles.InfoTraces=TracesToSave;
guidata(hObject,handles);


