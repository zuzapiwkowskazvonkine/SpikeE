function varargout = Visualize_Responsive_Pixels_and_SignificanceUpDown(varargin)
% VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN M-file for Visualize_Responsive_Pixels_and_SignificanceUpDown.fig
%      VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN, by itself, creates a new VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN or raises the existing
%      singleton*.
%
%      H = VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN returns the handle to a new VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN or the handle to
%      the existing singleton*.
%
%      VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN.M with the given input arguments.
%
%      VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN('Property','Value',...) creates a new VISUALIZE_RESPONSIVE_PIXELS_AND_SIGNIFICANCEUPDOWN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Visualize_Responsive_Pixels_and_SignificanceUpDown_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Visualize_Responsive_Pixels_and_SignificanceUpDown_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Visualize_Responsive_Pixels_and_SignificanceUpDown

% Last Modified by GUIDE v2.5 25-Sep-2013 17:26:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Visualize_Responsive_Pixels_and_SignificanceUpDown_OpeningFcn, ...
                   'gui_OutputFcn',  @Visualize_Responsive_Pixels_and_SignificanceUpDown_OutputFcn, ...
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


% --- Executes just before Visualize_Responsive_Pixels_and_SignificanceUpDown is made visible.
function Visualize_Responsive_Pixels_and_SignificanceUpDown_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Visualize_Responsive_Pixels_and_SignificanceUpDown (see VARARGIN)

% Choose default command line output for Visualize_Responsive_Pixels_and_SignificanceUpDown
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Visualize_Responsive_Pixels_and_SignificanceUpDown wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceRespAmp,'String',Settings.TraceRespAmpString);
    set(handles.TraceNbResps,'String',Settings.TraceNbRespsString);
    set(handles.TraceXsize,'String',Settings.TraceXsizeString);
    set(handles.TraceYsize,'String',Settings.TraceYsizeString);
    set(handles.TraceInts,'String',Settings.TraceIntsString);
    set(handles.TraceIntsTable,'String',Settings.TraceIntsTableString);
    set(handles.TraceNbTraces,'String',Settings.TraceNbTracesString);
     set(handles.TraceSignResp,'String',Settings.TraceSignRespString);
    
    set(handles.TraceRespAmp,'Value',Settings.TraceRespAmpValue);
    set(handles.TraceNbResps,'Value',Settings.TraceNbRespsValue);
    set(handles.TraceXsize,'Value',Settings.TraceXsizeValue);
    set(handles.TraceYsize,'Value',Settings.TraceYsizeValue);
    set(handles.TraceFOV,'Value',Settings.TraceFOVValue);
    set(handles.TraceInts,'Value',Settings.TraceIntsValue);
    set(handles.TraceIntsTable,'Value',Settings.TraceIntsTableValue);
    set(handles.TraceNbTraces,'Value',Settings.TraceNbTracesValue);
    set(handles.TraceSignResp,'Value',Settings.TraceSignRespValue);
    set(handles.ShowPSTHs,'Value',Settings.ShowPSTHsValue);
    set(handles.ShowSignif,'Value',Settings.ShowSignifValue);
    
    set(handles.PSTHTrace1,'String',Settings.PSTHTrace1String);
    set(handles.PSTHTrace1,'Value',Settings.PSTHTrace1Value);
    set(handles.Factor10,'Value',Settings.Factor10Value);
    set(handles.SaveFilename,'String',Settings.SaveFilenameString);
    
    set(handles.SignifTrace1,'String',Settings.SignifTrace1String);
    set(handles.SignifTrace1,'Value',Settings.SignifTrace1Value);
    set(handles.Signif2Trace1,'String',Settings.Signif2Trace1String);
    set(handles.Signif2Trace1,'Value',Settings.Signif2Trace1Value);
    
    set(handles.YMaxPSTH,'String',Settings.YMaxPSTHString);
    set(handles.XMinPSTH,'String',Settings.XMinPSTHString);
  
end

handles.Path='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\Surprise_Ai27_Pje\PSTHs';

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceRespAmp,'String',TextTrace);
    set(handles.TraceNbResps,'String',TextTrace);
    set(handles.TraceXsize,'String',TextTrace);
    set(handles.TraceYsize,'String',TextTrace);
    set(handles.TraceFOV,'String',TextTrace);
    set(handles.TraceInts,'String',TextTrace);
    set(handles.TraceIntsTable,'String',TextTrace);
    set(handles.TraceNbTraces,'String',TextTrace);
    set(handles.PSTHTrace1,'String',TextTrace);
    set(handles.TraceSignResp,'String',TextTrace);
    set(handles.SignifTrace1,'String',TextTrace);
    set(handles.Signif2Trace1,'String',TextTrace);
end

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Visualize_Responsive_Pixels_and_SignificanceUpDown_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceRespAmpString=get(handles.TraceRespAmp,'String');
Settings.TraceRespAmpValue=get(handles.TraceRespAmp,'Value');
Settings.TraceNbRespsString=get(handles.TraceNbResps,'String');
Settings.TraceNbRespsValue=get(handles.TraceNbResps,'Value');
Settings.TraceXsizeString=get(handles.TraceXsize,'String');
Settings.TraceXsizeValue=get(handles.TraceXsize,'Value');
Settings.TraceYsizeString=get(handles.TraceYsize,'String');
Settings.TraceYsizeValue=get(handles.TraceYsize,'Value');
Settings.TraceFOVValue=get(handles.TraceFOV,'Value');
Settings.TraceIntsString=get(handles.TraceInts,'String');
Settings.TraceIntsValue=get(handles.TraceInts,'Value');
Settings.TraceIntsTableString=get(handles.TraceIntsTable,'String');
Settings.TraceIntsTableValue=get(handles.TraceIntsTable,'Value');
Settings.TraceNbTracesString=get(handles.TraceNbTraces,'String');
Settings.TraceNbTracesValue=get(handles.TraceNbTraces,'Value');
Settings.ShowPSTHsValue=get(handles.ShowPSTHs,'Value');
Settings.ShowSignifValue=get(handles.ShowSignif,'Value');
Settings.PSTHTrace1String=get(handles.PSTHTrace1,'String');
Settings.PSTHTrace1Value=get(handles.PSTHTrace1,'Value');
Settings.Factor10Value=get(handles.Factor10,'Value');
Settings.TraceSignRespString=get(handles.TraceSignResp,'String');
Settings.TraceSignRespValue=get(handles.TraceSignResp,'Value');
Settings.SaveFilenameString=get(handles.SaveFilename,'String');
Settings.SignifTrace1String=get(handles.SignifTrace1,'String');
Settings.SignifTrace1Value=get(handles.SignifTrace1,'Value');
Settings.Signif2Trace1String=get(handles.Signif2Trace1,'String');
Settings.Signif2Trace1Value=get(handles.Signif2Trace1,'Value');
Settings.YMaxPSTHString=get(handles.YMaxPSTH,'String');
Settings.XMinPSTHString=get(handles.XMinPSTH,'String');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

% validate obtained results and store in new Trace

global SpikeTraceData

nbrespstrace=get(handles.TraceNbResps,'Value');
xsizetrace=get(handles.TraceXsize,'Value');
ysizetrace=get(handles.TraceYsize,'Value');
fovtrace=get(handles.TraceFOV,'Value');
intstrace=get(handles.TraceInts,'Value');
intstabletrace=get(handles.TraceIntsTable,'Value');
nbtracestrace=get(handles.TraceNbTraces,'Value');
filename=get(handles.SaveFilename,'String');

BeginTrace=length(SpikeTraceData)+1;

SpikeTraceData(BeginTrace).XVector=1:length(handles.corrected);
SpikeTraceData(BeginTrace).Trace=handles.corrected;
SpikeTraceData(BeginTrace).DataSize=length(handles.corrected);

name=['corrected ' SpikeTraceData(nbrespstrace).Label.ListText];
SpikeTraceData(BeginTrace).Label.ListText=name;
SpikeTraceData(BeginTrace).Label.YLabel=SpikeTraceData(nbrespstrace).Label.YLabel;
SpikeTraceData(BeginTrace).Label.XLabel='file nb';
SpikeTraceData(BeginTrace).Filename=SpikeTraceData(nbrespstrace).Filename;
SpikeTraceData(BeginTrace).Path=SpikeTraceData(nbrespstrace).Path;

% save the 'per file' vectors and the 'corrected' vector of response
% numbers

OldData=SpikeTraceData;
listtosave=sort([BeginTrace nbrespstrace xsizetrace ysizetrace fovtrace intstrace intstabletrace nbtracestrace]);
SpikeTraceData=SpikeTraceData(listtosave);
save(filename,'SpikeTraceData');
SpikeTraceData=OldData;


% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;



% --- Executes on selection change in TraceRespAmp.
function TraceRespAmp_Callback(hObject, eventdata, handles)
% hObject    handle to TraceRespAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceRespAmp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceRespAmp


% --- Executes during object creation, after setting all properties.
function TraceRespAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceRespAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceNbResps.
function TraceNbResps_Callback(hObject, eventdata, handles)
% hObject    handle to TraceNbResps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceNbResps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceNbResps


% --- Executes during object creation, after setting all properties.
function TraceNbResps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceNbResps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceXsize.
function TraceXsize_Callback(hObject, eventdata, handles)
% hObject    handle to TraceXsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceXsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceXsize


% --- Executes during object creation, after setting all properties.
function TraceXsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceXsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceYsize.
function TraceYsize_Callback(hObject, eventdata, handles)
% hObject    handle to TraceYsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceYsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceYsize


% --- Executes during object creation, after setting all properties.
function TraceYsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceYsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceInts.
function TraceInts_Callback(hObject, eventdata, handles)
% hObject    handle to TraceInts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceInts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceInts


% --- Executes during object creation, after setting all properties.
function TraceInts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceInts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceIntsTable.
function TraceIntsTable_Callback(hObject, eventdata, handles)
% hObject    handle to TraceIntsTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceIntsTable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceIntsTable


% --- Executes during object creation, after setting all properties.
function TraceIntsTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceIntsTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Factor10.
function Factor10_Callback(hObject, eventdata, handles)
% hObject    handle to Factor10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Factor10


% --- Executes on button press in ShowFile.
function ShowFile_Callback(hObject, eventdata, handles)
% hObject    handle to ShowFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filenb=str2num(get(handles.ViewedFile,'String'));
plotfiledata(hObject,filenb,handles);

showpsths=get(handles.ShowPSTHs,'Value');
if showpsths
   plotpsths(hObject,filenb,handles); 
end



% --- Executes on button press in ResetFileCount.
function ResetFileCount_Callback(hObject, eventdata, handles)
% hObject    handle to ResetFileCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetfile=str2double(get(handles.FileNb,'String'));
set(handles.ViewedFile,'String',num2str(resetfile));



function FileNb_Callback(hObject, eventdata, handles)
% hObject    handle to FileNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileNb as text
%        str2double(get(hObject,'String')) returns contents of FileNb as a double


% --- Executes during object creation, after setting all properties.
function FileNb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ShowPrevFile.
function ShowPrevFile_Callback(hObject, eventdata, handles)
% hObject    handle to ShowPrevFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filenb=str2num(get(handles.ViewedFile,'String'))-1;
plotfiledata(hObject,filenb,handles);
set(handles.ViewedFile,'String',num2str(filenb));

showpsths=get(handles.ShowPSTHs,'Value');
if showpsths
   plotpsths(hObject,filenb,handles); 
end

% --- Executes on button press in ShowPrevFile.
function ShowNextFile_Callback(hObject, eventdata, handles)
% hObject    handle to ShowPrevFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filenb=str2num(get(handles.ViewedFile,'String'))+1;
plotfiledata(hObject,filenb,handles);
set(handles.ViewedFile,'String',num2str(filenb));

showpsths=get(handles.ShowPSTHs,'Value');
if showpsths
   plotpsths(hObject,filenb,handles); 
end


% --- Executes on button press in NoCorrection.
function NoCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to NoCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData

nbrespstrace=get(handles.TraceNbResps,'Value');
filenb=str2num(get(handles.ViewedFile,'String'));

handles.corrected(filenb)=SpikeTraceData(nbrespstrace).Trace(filenb);

set(handles.text(filenb),'String',['Old resp. nb:' int2str(SpikeTraceData(nbrespstrace).Trace(filenb)) ' New resp. nb:' int2str(handles.corrected(filenb))]);

guidata(hObject, handles);


% --- Executes on button press in Correct.
function Correct_Callback(hObject, eventdata, handles)
% hObject    handle to Correct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData

nbrespstrace=get(handles.TraceNbResps,'Value');
filenb=str2num(get(handles.ViewedFile,'String'));
corr=str2num(get(handles.NbRespsAdd,'String'));

handles.corrected(filenb)=SpikeTraceData(nbrespstrace).Trace(filenb)+corr;

set(handles.text(filenb),'String',['Old resp. nb:' int2str(SpikeTraceData(nbrespstrace).Trace(filenb)) ' New resp. nb:' int2str(handles.corrected(filenb))]);

guidata(hObject, handles);

function NbRespsAdd_Callback(hObject, eventdata, handles)
% hObject    handle to NbRespsAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbRespsAdd as text
%        str2double(get(hObject,'String')) returns contents of NbRespsAdd as a double


% --- Executes during object creation, after setting all properties.
function NbRespsAdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbRespsAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%
%%%%
%%%%%
%%%%
function plotpsths(hObject,filenb,handles)

global SpikeTraceData

psthtrace1=get(handles.PSTHTrace1,'Value');
nbtracestrace=get(handles.TraceNbTraces,'Value');
signresptrace=get(handles.TraceSignResp,'Value');

showsignif=get(handles.ShowSignif,'Value');
signiftrace1=get(handles.SignifTrace1,'Value');
signif2trace1=get(handles.Signif2Trace1,'Value');

ymax=str2num(get(handles.YMaxPSTH,'String'));
xmin=str2num(get(handles.XMinPSTH,'String'));

% get index of first PSTH to display (relative to 1):
tottraces=sum(SpikeTraceData(nbtracestrace).Trace(1:filenb-1));
firstpsth=tottraces+1;
lastpsth=tottraces+SpikeTraceData(nbtracestrace).Trace(filenb);

inds=psthtrace1+firstpsth-1:1:psthtrace1+lastpsth-1;
if showsignif
    indssign=signiftrace1+firstpsth-1:1:signiftrace1+lastpsth-1;
    indssign2=signif2trace1+firstpsth-1:1:signif2trace1+lastpsth-1;
end

figure(handles.fignbpsths);
clf;
for k=1:length(inds)
    subplot(1,length(inds),k);
    
    if SpikeTraceData(signresptrace).Trace(inds(k)-psthtrace1+1)==1
        colorpsth='b';
    else
        colorpsth='k';
    end
    
    
    plot(SpikeTraceData(inds(k)).XVector,SpikeTraceData(inds(k)).Trace,colorpsth);
    xmax=SpikeTraceData(inds(k)).XVector(end);
    hold on
    if showsignif
        plot(SpikeTraceData(indssign(k)).XVector,SpikeTraceData(indssign(k)).Trace,'r');
        plot(SpikeTraceData(indssign2(k)).XVector,SpikeTraceData(indssign2(k)).Trace,'g');
    end
    v=axis;
    % axis([v(1) v(2) 0 ymax]);
    axis([xmin xmax 0 ymax]);
    hold off
    
end


function plotfiledata(hObject,filenb,handles)

global SpikeTraceData

ampstrace=get(handles.TraceRespAmp,'Value');
nbrespstrace=get(handles.TraceNbResps,'Value');
xsizetrace=get(handles.TraceXsize,'Value');
ysizetrace=get(handles.TraceYsize,'Value');
fovtrace=get(handles.TraceFOV,'Value');
intstrace=get(handles.TraceInts,'Value');
intstabletrace=get(handles.TraceIntsTable,'Value');
nbtracestrace=get(handles.TraceNbTraces,'Value');
x10=get(handles.Factor10,'Value');

% get index of first PSTH Amp to use:
tottraces=sum(SpikeTraceData(nbtracestrace).Trace(1:filenb-1));
firstpsth=tottraces+1;

nbtraces=SpikeTraceData(nbtracestrace).Trace(filenb);
xsize=SpikeTraceData(xsizetrace).Trace(filenb);
ysize=SpikeTraceData(ysizetrace).Trace(filenb);
fov=SpikeTraceData(fovtrace).Trace(filenb);
int=SpikeTraceData(intstrace).Trace(filenb);
if x10
    int=10*int;
end

ind=find(SpikeTraceData(intstabletrace).XVector==int);
intW=SpikeTraceData(intstabletrace).Trace(ind);

resps=SpikeTraceData(ampstrace).Trace(firstpsth:firstpsth+nbtraces-1);

figure(handles.fignb);
if xsize==300 || ysize==300
plot(1:nbtraces,resps);
else
    xstep=300/xsize;
    ystep=300/ysize;
    resps2=reshape(resps,ystep,xstep); %ystep lines and xstep columns
    imagesc(resps2);
end;

title(['FOV:' num2str(fov) ', Xsize:' num2str(xsize) ', Ysize:' num2str(ysize) ', Int:' num2str(int) '/ ' num2str(intW) ' uW']);
handles.text(filenb)=text(2,max(resps)-0.1,['Old resp. nb:' int2str(SpikeTraceData(nbrespstrace).Trace(filenb)) ' New resp. nb:' int2str(handles.corrected(filenb))],'Color',[1 0 0]);

set(handles.NbRespsAdd,'String',num2str(SpikeTraceData(nbrespstrace).Trace(filenb)-1));
guidata(hObject, handles);

% --- Executes on button press in OpenNewFig.
function OpenNewFig_Callback(hObject, eventdata, handles)
% hObject    handle to OpenNewFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

showpsths=get(handles.ShowPSTHs,'Value');

global SpikeTraceData

    h=figure;
    handles.fignb=h;
    
    if showpsths
    h=figure;
    handles.fignbpsths=h;
    end
    
    %also initialize here a vector in handles to store temporarily the
    %new "nb of responses" value
    nbrespstrace=get(handles.TraceNbResps,'Value');
    handles.corrected=zeros(1,length(SpikeTraceData(nbrespstrace).Trace));

guidata(hObject, handles);


% --- Executes on selection change in TraceNbTraces.
function TraceNbTraces_Callback(hObject, eventdata, handles)
% hObject    handle to TraceNbTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceNbTraces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceNbTraces


% --- Executes during object creation, after setting all properties.
function TraceNbTraces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceNbTraces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ShowPSTHs.
function ShowPSTHs_Callback(hObject, eventdata, handles)
% hObject    handle to ShowPSTHs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowPSTHs


% --- Executes on selection change in PSTHTrace1.
function PSTHTrace1_Callback(hObject, eventdata, handles)
% hObject    handle to PSTHTrace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PSTHTrace1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PSTHTrace1


% --- Executes during object creation, after setting all properties.
function PSTHTrace1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSTHTrace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSignResp.
function TraceSignResp_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSignResp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSignResp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSignResp


% --- Executes during object creation, after setting all properties.
function TraceSignResp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSignResp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetFilename.
function GetFilename_Callback(hObject, eventdata, handles)
% hObject    handle to GetFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Oldpath=cd;

cd(handles.Path);

% Open file path
[filename, pathname] = uiputfile( ...
    {'*.mat','All Files (*.mat)'},'Select Data File');

cd(Oldpath);

% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
else
    handles.Path=pathname;
    [path, basename, extname]=fileparts(filename);
    totname=[pathname basename '_NbResps' extname];
    set(handles.SaveFilename,'String',totname);
    guidata(hObject,handles);
    
end


% --- Executes on button press in ShowSignif.
function ShowSignif_Callback(hObject, eventdata, handles)
% hObject    handle to ShowSignif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowSignif


% --- Executes on selection change in SignifTrace1.
function SignifTrace1_Callback(hObject, eventdata, handles)
% hObject    handle to SignifTrace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SignifTrace1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SignifTrace1


% --- Executes during object creation, after setting all properties.
function SignifTrace1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignifTrace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YMaxPSTH_Callback(hObject, eventdata, handles)
% hObject    handle to YMaxPSTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YMaxPSTH as text
%        str2double(get(hObject,'String')) returns contents of YMaxPSTH as a double


% --- Executes during object creation, after setting all properties.
function YMaxPSTH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YMaxPSTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function XMinPSTH_Callback(hObject, eventdata, handles)
% hObject    handle to XMinPSTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XMinPSTH as text
%        str2double(get(hObject,'String')) returns contents of XMinPSTH as a double


% --- Executes during object creation, after setting all properties.
function XMinPSTH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XMinPSTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Signif2Trace1.
function Signif2Trace1_Callback(hObject, eventdata, handles)
% hObject    handle to Signif2Trace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Signif2Trace1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Signif2Trace1


% --- Executes during object creation, after setting all properties.
function Signif2Trace1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Signif2Trace1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceFOV.
function TraceFOV_Callback(hObject, eventdata, handles)
% hObject    handle to TraceFOV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceFOV contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceFOV


% --- Executes during object creation, after setting all properties.
function TraceFOV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceFOV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
