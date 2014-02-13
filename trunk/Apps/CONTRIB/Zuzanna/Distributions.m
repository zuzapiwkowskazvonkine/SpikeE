function varargout = Distributions(varargin)
% DISTRIBUTIONS M-file for Distributions.fig
%      DISTRIBUTIONS, by itself, creates a new DISTRIBUTIONS or raises the existing
%      singleton*.
%
%      H = DISTRIBUTIONS returns the handle to a new DISTRIBUTIONS or the handle to
%      the existing singleton*.
%
%      DISTRIBUTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISTRIBUTIONS.M with the given input arguments.
%
%      DISTRIBUTIONS('Property','Value',...) creates a new DISTRIBUTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Distributions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Distributions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Distributions

% Last Modified by GUIDE v2.5 03-Jan-2013 21:48:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Distributions_OpeningFcn, ...
                   'gui_OutputFcn',  @Distributions_OutputFcn, ...
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


% --- Executes just before Distributions is made visible.
function Distributions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Distributions (see VARARGIN)

% Choose default command line output for Distributions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Distributions wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

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
end

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end


% --- Outputs from this function are returned to the command line.
function varargout = Distributions_OutputFcn(hObject, eventdata, handles) 
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
Settings.StartBin1String=get(handles.StartBin1,'String');
Settings.StopBin1String=get(handles.StopBin1,'String');
Settings.StartBin2String=get(handles.StartBin2,'String');
Settings.StopBin2String=get(handles.StopBin2,'String');
Settings.FalsePosRatioString=get(handles.FalsePosRatio,'String');
Settings.GetThreshValue=get(handles.GetThresh,'Value');
Settings.MaxSurpriseValue=get(handles.MaxSurprise,'Value');
Settings.NegSurpriseValue=get(handles.NegSurprise,'Value');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;


    TracesToApply=get(handles.TraceSelector,'Value');


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
temp1=[];
temp2=[];
temp1n=[];
temp2n=[];
sizechunk1=stopbin1-startbin1+1;
sizechunk2=stopbin2-startbin2+1;

for k=TracesToApply

time0=SpikeTraceData(k).XVector(1);

if maxsurprise

temp1(end+1)=max(SpikeTraceData(k).Trace(startbin1-time0+1:stopbin1-time0+1));
temp2(end+1)=max(SpikeTraceData(k).Trace(startbin2-time0+1:stopbin2-time0+1));
temp1n(end+1)=min(SpikeTraceData(k).Trace(startbin1-time0+1:stopbin1-time0+1));
temp2n(end+1)=min(SpikeTraceData(k).Trace(startbin2-time0+1:stopbin2-time0+1));
else
temp1(end+1:end+sizechunk1)=SpikeTraceData(k).Trace(startbin1-time0+1:stopbin1-time0+1);
temp2(end+1:end+sizechunk2)=SpikeTraceData(k).Trace(startbin2-time0+1:stopbin2-time0+1);
temp1n=temp1;
temp2n=temp2;
end
% avgburst_evoked=AverageBurst(SpikeTraceData(k).Trace,time0,burstperiod,nbreps,burstonset,handles);
% avgburst_spont=AverageBurst(SpikeTraceData(k).Trace,time0,-burstperiod,nbreps,burstonset,handles);
% 
% avgburst=[avgburst_spont; avgburst_evoked];
% global test_avgburst
% test_avgburst=avgburst;
% 
% SpikeTraceData(BeginTrace+n).XVector=-burstperiod:1:burstperiod-1;
% SpikeTraceData(BeginTrace+n).Trace=avgburst;
% SpikeTraceData(BeginTrace+n).DataSize=length(avgburst);
% 
% name=['burst sum ' SpikeTraceData(k).Label.ListText];
% SpikeTraceData(BeginTrace+n).Label.ListText=name;
% SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
% SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
% SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
% SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
% 
% n=n+1;
 
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

figure;
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

figure
plot(x1,temp1cdf);
hold on
plot(x2,temp2cdf,'r');

if getthresh
    hold on
    stem(thresh,1,'k');
end

if negsurprise
    figure;
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
    
    figure
    plot(x1n,temp1cdfn);
    hold on
    plot(x2n,temp2cdfn,'r');
    
    if getthresh
        hold on
        stem(-threshneg,1,'k');
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

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on TraceSelector and none of its controls.
function TraceSelector_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)





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
