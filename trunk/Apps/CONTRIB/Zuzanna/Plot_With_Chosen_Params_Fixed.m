function varargout = Plot_With_Chosen_Params_Fixed(varargin)
% PLOT_WITH_CHOSEN_PARAMS_FIXED M-file for Plot_With_Chosen_Params_Fixed.fig
%      PLOT_WITH_CHOSEN_PARAMS_FIXED, by itself, creates a new PLOT_WITH_CHOSEN_PARAMS_FIXED or raises the existing
%      singleton*.
%
%      H = PLOT_WITH_CHOSEN_PARAMS_FIXED returns the handle to a new PLOT_WITH_CHOSEN_PARAMS_FIXED or the handle to
%      the existing singleton*.
%
%      PLOT_WITH_CHOSEN_PARAMS_FIXED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_WITH_CHOSEN_PARAMS_FIXED.M with the given input arguments.
%
%      PLOT_WITH_CHOSEN_PARAMS_FIXED('Property','Value',...) creates a new PLOT_WITH_CHOSEN_PARAMS_FIXED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Plot_With_Chosen_Params_Fixed_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Plot_With_Chosen_Params_Fixed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Plot_With_Chosen_Params_Fixed

% Last Modified by GUIDE v2.5 17-Feb-2013 16:16:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Plot_With_Chosen_Params_Fixed_OpeningFcn, ...
                   'gui_OutputFcn',  @Plot_With_Chosen_Params_Fixed_OutputFcn, ...
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


% --- Executes just before Plot_With_Chosen_Params_Fixed is made visible.
function Plot_With_Chosen_Params_Fixed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Plot_With_Chosen_Params_Fixed (see VARARGIN)

% Choose default command line output for Plot_With_Chosen_Params_Fixed
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Plot_With_Chosen_Params_Fixed wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelectorx,'String',TextTrace);
    set(handles.TraceSelectory,'String',TextTrace);
    set(handles.TraceSelectorParam1,'String',TextTrace);
    set(handles.TraceSelectorParam2,'String',TextTrace);
end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceSelectorx,'String',Settings.TraceSelectorxString);
    set(handles.TraceSelectorx,'Value',Settings.TraceSelectorxValue);
    set(handles.TraceSelectory,'String',Settings.TraceSelectoryString);
    set(handles.TraceSelectory,'Value',Settings.TraceSelectoryValue);
    set(handles.TraceSelectorParam1,'String',Settings.TraceSelectorParam1String);
    set(handles.TraceSelectorParam1,'Value',Settings.TraceSelectorParam1Value);
    set(handles.TraceSelectorParam2,'String',Settings.TraceSelectorParam2String);
    set(handles.TraceSelectorParam2,'Value',Settings.TraceSelectorParam2Value);
    set(handles.SaveTrace,'Value',Settings.SaveTraceValue);
    set(handles.Param1Start,'String',Settings.Param1StartString);
    set(handles.Param1Stop,'String',Settings.Param1StopString);
    set(handles.Param2Start,'String',Settings.Param2StartString);
    set(handles.Param2Stop,'String',Settings.Param2StopString);
    set(handles.MultParam1,'Value',Settings.MultParam1Value);
    set(handles.MultParam2,'Value',Settings.MultParam2Value);
end


% --- Outputs from this function are returned to the command line.
function varargout = Plot_With_Chosen_Params_Fixed_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceSelectorxString=get(handles.TraceSelectorx,'String');
Settings.TraceSelectorxValue=get(handles.TraceSelectorx,'Value');
Settings.TraceSelectoryString=get(handles.TraceSelectory,'String');
Settings.TraceSelectoryValue=get(handles.TraceSelectory,'Value');
Settings.TraceSelectorParam1String=get(handles.TraceSelectorParam1,'String');
Settings.TraceSelectorParam1Value=get(handles.TraceSelectorParam1,'Value');
Settings.TraceSelectorParam2String=get(handles.TraceSelectorParam2,'String');
Settings.TraceSelectorParam2Value=get(handles.TraceSelectorParam2,'Value');
Settings.SaveTraceValue=get(handles.SaveTrace,'Value');
Settings.Param1StartString=get(handles.Param1Start,'String');
Settings.Param1StopString=get(handles.Param1Stop,'String');
Settings.Param2StartString=get(handles.Param2Start,'String');
Settings.Param2StopString=get(handles.Param2Stop,'String');
Settings.MultParam1Value=get(handles.MultParam1,'Value');
Settings.MultParam2Value=get(handles.MultParam2,'Value');

% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData;

Tracex=get(handles.TraceSelectorx,'Value');
Tracey=get(handles.TraceSelectory,'Value');
TraceParam1=get(handles.TraceSelectorParam1,'Value');
TraceParam2=get(handles.TraceSelectorParam2,'Value');
savetrace=get(handles.SaveTrace,'Value');
 
param1start=str2double(get(handles.Param1Start,'String'));
param1stop=str2double(get(handles.Param1Stop,'String'));
param2start=str2double(get(handles.Param2Start,'String'));
param2stop=str2double(get(handles.Param2Stop,'String'));

multparam1=get(handles.MultParam1,'Value');
multparam2=get(handles.MultParam2,'Value');

tot=length(SpikeTraceData(Tracex).Trace);
inds=[];

for i=1:tot
    
    param1=SpikeTraceData(TraceParam1).Trace(i);
    param2=SpikeTraceData(TraceParam2).Trace(i);
    
    if param1>=param1start && param1<=param1stop && param2>=param2start && param2<=param2stop    
       inds(end+1)=i;    
    end
   
end
inds

mult=1;
titleadd='';
if multparam1
mult=(param1start+param1stop)/2;
titleadd=['; ' SpikeTraceData(TraceParam1).Label.ListText '=' num2str(mult)];
else
if multparam2
mult=(param2start+param2stop)/2;
titleadd=['; ' SpikeTraceData(TraceParam2).Label.ListText '=' num2str(mult)];
end
end

plotx=SpikeTraceData(Tracex).Trace(inds);
ploty=SpikeTraceData(Tracey).Trace(inds)*mult; %in this way, if X in pixels =30 and the resp. is 3 (stimulus locations with resp.), this corresponds to 30*3=90 pixels of response.

figure
plot(plotx,ploty,'.k');
title([SpikeTraceData(Tracey).Label.ListText ' vs. ' SpikeTraceData(Tracex).Label.ListText titleadd]);
% HERE add titles, axes labels etc.


if savetrace
    BeginTrace=length(SpikeTraceData)+1;
    SpikeTraceData(BeginTrace).XVector=plotx;
    SpikeTraceData(BeginTrace).Trace=ploty;
    SpikeTraceData(BeginTrace).DataSize=length(plotx);
    
    newname=[SpikeTraceData(Tracey).Label.ListText ' vs. ' SpikeTraceData(Tracex).Label.ListText titleadd];
    SpikeTraceData(BeginTrace).Label.ListText=newname;
    SpikeTraceData(BeginTrace).Label.YLabel=SpikeTraceData(Tracey).Label.YLabel;
    SpikeTraceData(BeginTrace).Label.XLabel=SpikeTraceData(Tracex).Label.XLabel;
    SpikeTraceData(BeginTrace).Filename=SpikeTraceData(Tracex).Filename;
    SpikeTraceData(BeginTrace).Path=SpikeTraceData(Tracex).Path;
    
end








% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


% --- Executes on selection change in TraceSelectorx.
function TraceSelectorx_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorx


% --- Executes during object creation, after setting all properties.
function TraceSelectorx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectory.
function TraceSelectory_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectory


% --- Executes during object creation, after setting all properties.
function TraceSelectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectorParam1.
function TraceSelectorParam1_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorParam1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorParam1


% --- Executes during object creation, after setting all properties.
function TraceSelectorParam1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceSelectorParam2.
function TraceSelectorParam2_Callback(hObject, eventdata, handles)
% hObject    handle to TraceSelectorParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceSelectorParam2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceSelectorParam2


% --- Executes during object creation, after setting all properties.
function TraceSelectorParam2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceSelectorParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Param1Start_Callback(hObject, eventdata, handles)
% hObject    handle to Param1Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Param1Start as text
%        str2double(get(hObject,'String')) returns contents of Param1Start as a double


% --- Executes during object creation, after setting all properties.
function Param1Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Param1Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Param1Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Param1Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Param1Stop as text
%        str2double(get(hObject,'String')) returns contents of Param1Stop as a double


% --- Executes during object creation, after setting all properties.
function Param1Stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Param1Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Param2Start_Callback(hObject, eventdata, handles)
% hObject    handle to Param2Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Param2Start as text
%        str2double(get(hObject,'String')) returns contents of Param2Start as a double


% --- Executes during object creation, after setting all properties.
function Param2Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Param2Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Param2Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Param2Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Param2Stop as text
%        str2double(get(hObject,'String')) returns contents of Param2Stop as a double


% --- Executes during object creation, after setting all properties.
function Param2Stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Param2Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveTrace.
function SaveTrace_Callback(hObject, eventdata, handles)
% hObject    handle to SaveTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveTrace


% --- Executes on button press in MultParam1.
function MultParam1_Callback(hObject, eventdata, handles)
% hObject    handle to MultParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MultParam1


% --- Executes on button press in MultParam2.
function MultParam2_Callback(hObject, eventdata, handles)
% hObject    handle to MultParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MultParam2
