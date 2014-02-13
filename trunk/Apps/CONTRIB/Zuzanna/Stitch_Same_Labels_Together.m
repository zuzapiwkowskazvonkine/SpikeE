function varargout = Stitch_Same_Labels_Together(varargin)
% STITCH_SAME_LABELS_TOGETHER M-file for Stitch_Same_Labels_Together.fig
%      STITCH_SAME_LABELS_TOGETHER, by itself, creates a new STITCH_SAME_LABELS_TOGETHER or raises the existing
%      singleton*.
%
%      H = STITCH_SAME_LABELS_TOGETHER returns the handle to a new STITCH_SAME_LABELS_TOGETHER or the handle to
%      the existing singleton*.
%
%      STITCH_SAME_LABELS_TOGETHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STITCH_SAME_LABELS_TOGETHER.M with the given input arguments.
%
%      STITCH_SAME_LABELS_TOGETHER('Property','Value',...) creates a new STITCH_SAME_LABELS_TOGETHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Stitch_Same_Labels_Together_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Stitch_Same_Labels_Together_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Stitch_Same_Labels_Together

% Last Modified by GUIDE v2.5 16-Feb-2013 12:07:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Stitch_Same_Labels_Together_OpeningFcn, ...
                   'gui_OutputFcn',  @Stitch_Same_Labels_Together_OutputFcn, ...
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


% --- Executes just before Stitch_Same_Labels_Together is made visible.
function Stitch_Same_Labels_Together_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Stitch_Same_Labels_Together (see VARARGIN)

% Choose default command line output for Stitch_Same_Labels_Together
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Stitch_Same_Labels_Together wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceSelector,'String',Settings.TraceSelectorString);
    set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
end

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    TextTrace{1}='All Traces';
    for i=1:length(SpikeTraceData)
        TextTrace{i+1}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
end
% --- Outputs from this function are returned to the command line.
function varargout = Stitch_Same_Labels_Together_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

if (get(handles.TraceSelector,'Value')==1)
    TracesToApply=1:length(SpikeTraceData);
else
    TracesToApply=get(handles.TraceSelector,'Value')-1;
end
 
BeginTrace=length(SpikeTraceData)+1;
n=0; %new trace counter

h=waitbar(0,'Stitching...');
for k=TracesToApply
    
    refname=SpikeTraceData(k).Label.ListText;
    
    [indstostitch,newtracesize] = gettraceindices(SpikeTraceData, refname, handles);

    newtrace = stitchindices(SpikeTraceData,indstostitch,newtracesize, handles);


    SpikeTraceData(BeginTrace+n).XVector=1:length(newtrace);
    SpikeTraceData(BeginTrace+n).Trace=newtrace;
    SpikeTraceData(BeginTrace+n).DataSize=length(newtrace);
    
    newname=['all ' refname];
    SpikeTraceData(BeginTrace+n).Label.ListText=newname;
    SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(k).Label.YLabel;
    SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(k).Label.XLabel;
    SpikeTraceData(BeginTrace+n).Filename=SpikeTraceData(k).Filename;
    SpikeTraceData(BeginTrace+n).Path=SpikeTraceData(k).Path;
 
    n=n+1;

    waitbar(k/length(TracesToApply));
    
end

close(h);


% this function finds the indices, in array of Traces, of the ones having
% the chosen label refname

function [inds,newsize] = gettraceindices(DataArray, refname, handles)

tot=length(DataArray);
inds=[];
newsize=0;

for i=1:tot
   if strcmp(DataArray(i).Label.ListText,refname)
   inds(end+1)=i;
   newsize=newsize+DataArray(i).DataSize;
   end
end

% this function stitches together Traces of indices inds

function trace = stitchindices(DataArray,inds, newsize,handles)

trace=zeros(1,newsize);

newstart=1;
for k=inds
    addedpts=DataArray(k).DataSize;   
    trace(newstart:newstart+addedpts-1)=DataArray(k).Trace;
    newstart=newstart+addedpts;
end




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


