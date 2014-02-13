function varargout = Sort_By_Position(varargin)
% SORT_BY_POSITION MATLAB code for Sort_By_Position.fig
%      SORT_BY_POSITION, by itself, creates a new SORT_BY_POSITION or raises the existing
%      singleton*.
%
%      H = SORT_BY_POSITION returns the handle to a new SORT_BY_POSITION or the handle to
%      the existing singleton*.
%
%      SORT_BY_POSITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SORT_BY_POSITION.M with the given input arguments.
%
%      SORT_BY_POSITION('Property','Value',...) creates a new SORT_BY_POSITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sort_By_Position_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sort_By_Position_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Sort_By_Position

% Last Modified by GUIDE v2.5 29-Oct-2012 18:29:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sort_By_Position_OpeningFcn, ...
                   'gui_OutputFcn',  @Sort_By_Position_OutputFcn, ...
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


% --- Executes just before Sort_By_Position is made visible.
function Sort_By_Position_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sort_By_Position (see VARARGIN)

% Choose default command line output for Sort_By_Position
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sort_By_Position wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeTraceData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.Xposition,'Value',Settings.XpositionValue);
    set(handles.Yposition,'Value',Settings.YpositionValue);

end

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
        TextTrace2{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.TraceSelector2,'String',TextTrace2);
end

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.TraceSelector2String=get(handles.TraceSelector2,'String');
Settings.TraceSelector2Value=get(handles.TraceSelector2,'Value');
Settings.XpositionValue=get(handles.Xposition,'Value');
Settings.YpositionValue=get(handles.Yposition,'Value');


% --- Outputs from this function are returned to the command line.
function varargout = Sort_By_Position_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'hFigImage')
    if (ishandle(handles.hFigImage))
        delete(handles.hFigImage);
    end
end
uiresume;

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

ForXV=get(handles.TraceSelector,'Value');
ForTrace=get(handles.TraceSelector2,'Value');

xpos=get(handles.Xposition,'Value');
ypos=get(handles.Yposition,'Value');

BeginTrace=length(SpikeTraceData)+1;
n=0;
i=1;

sz=0;
for z=1:length(ForTrace)
    sz=max(sz,SpikeTraceData(z).DataSize);
end

sz

for z=1:sz %loop over all positions, make one new Trace per position
   SpikeTraceData(BeginTrace+n).Trace=zeros(1,length(ForTrace));
   SpikeTraceData(BeginTrace+n).XVector=zeros(1,length(ForTrace));
   m=1;
   for k=ForTrace
    ind=find(SpikeTraceData(k).XVector==z) %find the index of the element in position z   (in vector of Responses)
    if ind>0
   SpikeTraceData(BeginTrace+n).Trace(1,m)=SpikeTraceData(k).Trace(1,ind); %put the corresponding response value into the vector pooling all responses to that position
   
   ind=find(SpikeTraceData(ForXV(m)).XVector==z); %find the index of the element in position z   (in vector of Intensities matched to the vector of Responses)
   SpikeTraceData(BeginTrace+n).XVector(1,m)=SpikeTraceData(ForXV(m)).Trace(1,ind); % put corresponding intensity value into the vector pooling all intensities for that position
   
   %NB: ForTrace and ForXV have to match so that this makes sense, ie
   %successive vecs in ForTrace must be paired (ie come from same episodes analysis) with successive vecs in
   %ForXV
  
   m=m+1; 
    end
   end 
   
   %sort according to intensities (in ascending order)
   temp=[SpikeTraceData(BeginTrace+n).Trace; SpikeTraceData(BeginTrace+n).XVector];
   tempsorted=sort(temp,2);
   SpikeTraceData(BeginTrace+n).Trace=tempsorted(1,:);
   SpikeTraceData(BeginTrace+n).XVector=tempsorted(2,:);
   
   
   SpikeTraceData(BeginTrace+n).DataSize=length(SpikeTraceData(BeginTrace+n).Trace);
   SpikeTraceData(BeginTrace+n).Label.XLabel=SpikeTraceData(ForXV(1)).Label.YLabel;
   SpikeTraceData(BeginTrace+n).Label.YLabel=SpikeTraceData(ForTrace(1)).Label.YLabel;
   SpikeTraceData(BeginTrace+n).Filename='';
   SpikeTraceData(BeginTrace+n).Path='';
   
   
   if xpos
   name=['Resp. vs. Intensity, position X:' int2str(z)];
   elseif ypos
   name=['Resp. vs. Intensity, position Y:' int2str(z)];   
   end
   SpikeTraceData(BeginTrace+n).Label.ListText=name;
   
   n=n+1;
end
    

ValidateValues_Callback(hObject, eventdata, handles)


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


% --- Executes on selection change in TraceSelector2.
function TraceSelector2_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelector2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelector2


% --- Executes during object creation, after setting all properties.
function TraceSelector2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelector2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseXVforXV.
function UseXVforXV_Callback(hObject, eventdata, handles)
% hObject    handle to UseXVforXV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseXVforXV


% --- Executes on button press in UseTraceforXV.
function UseTraceforXV_Callback(hObject, eventdata, handles)
% hObject    handle to UseTraceforXV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseTraceforXV


% --- Executes on button press in UseTraceforTrace.
function UseTraceforTrace_Callback(hObject, eventdata, handles)
% hObject    handle to UseTraceforTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseTraceforTrace


% --- Executes on button press in UseXVforTrace.
function UseXVforTrace_Callback(hObject, eventdata, handles)
% hObject    handle to UseXVforTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseXVforTrace



% --- Executes on button press in Xposition.
function Xposition_Callback(hObject, eventdata, handles)
% hObject    handle to Xposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Xposition


% --- Executes on button press in Yposition.
function Yposition_Callback(hObject, eventdata, handles)
% hObject    handle to Yposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Yposition
