function varargout = Get_Intensities_Table(varargin)
% GET_INTENSITIES_TABLE MATLAB code for Get_Intensities_Table.fig
%      GET_INTENSITIES_TABLE, by itself, creates a new GET_INTENSITIES_TABLE or raises the existing
%      singleton*.
%
%      H = GET_INTENSITIES_TABLE returns the handle to a new GET_INTENSITIES_TABLE or the handle to
%      the existing singleton*.
%
%      GET_INTENSITIES_TABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GET_INTENSITIES_TABLE.M with the given input arguments.
%
%      GET_INTENSITIES_TABLE('Property','Value',...) creates a new GET_INTENSITIES_TABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Get_Intensities_Table_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Get_Intensities_Table_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Get_Intensities_Table

% Last Modified by GUIDE v2.5 25-Oct-2012 14:15:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Get_Intensities_Table_OpeningFcn, ...
                   'gui_OutputFcn',  @Get_Intensities_Table_OutputFcn, ...
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


% --- Executes just before Get_Intensities_Table is made visible.
function Get_Intensities_Table_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Get_Intensities_Table (see VARARGIN)

% Choose default command line output for Get_Intensities_Table
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Get_Intensities_Table wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeMovieData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.Step10Int,'String',Settings.Step10IntString);
    set(handles.Step9Int,'String',Settings.Step9IntString);
    set(handles.Step8Int,'String',Settings.Step8IntString);
    set(handles.Step7Int,'String',Settings.Step7IntString);
    set(handles.Step6Int,'String',Settings.Step6IntString);
    set(handles.Step5Int,'String',Settings.Step5IntString);
    set(handles.Step4Int,'String',Settings.Step4IntString);
    set(handles.Step3Int,'String',Settings.Step3IntString);
    set(handles.Step2Int,'String',Settings.Step3IntString);
    set(handles.Step1Int,'String',Settings.Step1IntString);

end

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.Setp10IntString=get(handles.Step10Int,'String');
Settings.Setp9IntString=get(handles.Step9Int,'String');
Settings.Setp8IntString=get(handles.Step8Int,'String');
Settings.Setp7IntString=get(handles.Step7Int,'String');
Settings.Setp6IntString=get(handles.Step6Int,'String');
Settings.Setp5IntString=get(handles.Step5Int,'String');
Settings.Setp4IntString=get(handles.Step4Int,'String');
Settings.Setp3IntString=get(handles.Step3Int,'String');
Settings.Setp2IntString=get(handles.Step2Int,'String');
Settings.Setp1IntString=get(handles.Step1Int,'String');


% --- Outputs from this function are returned to the command line.
function varargout = Get_Intensities_Table_OutputFcn(hObject, eventdata, handles) 
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

try
   
    if isempty(SpikeTraceData)
        InitTraces();
        BeginTrace=1;
    else
        BeginTrace=length(SpikeTraceData)+1;
    end
    n=0;
    
    intensity=zeros(1,10);
    intensity(10)=str2double(get(handles.Step10Int,'String'));
    intensity(9)=str2double(get(handles.Step9Int,'String'));
    intensity(8)=str2double(get(handles.Step8Int,'String'));
    intensity(7)=str2double(get(handles.Step7Int,'String'));
    intensity(6)=str2double(get(handles.Step6Int,'String'));
    intensity(5)=str2double(get(handles.Step5Int,'String'));
    intensity(4)=str2double(get(handles.Step4Int,'String'));
    intensity(3)=str2double(get(handles.Step3Int,'String'));
    intensity(2)=str2double(get(handles.Step2Int,'String'));
    intensity(1)=str2double(get(handles.Step1Int,'String'));
    
    nonzero=find(intensity>0);
    
    SpikeTraceData(BeginTrace+n).XVector=nonzero;
    SpikeTraceData(BeginTrace+n).Trace=intensity(nonzero);
    SpikeTraceData(BeginTrace+n).DataSize=length(nonzero);
    
    name=['Intensities table'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='intensity (microW)';
    SpikeTraceData(BeginTrace+n).Label.XLabel='command step';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
    
    
    
catch errorObj
    set(InterfaceObj,'Enable','on');
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

ValidateValues_Callback(hObject, eventdata, handles);



function Step10Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step10Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step10Int as text
%        str2double(get(hObject,'String')) returns contents of Step10Int as a double


% --- Executes during object creation, after setting all properties.
function Step10Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step10Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NextFrame.
function NextFrame_Callback(hObject, eventdata, handles)
% hObject    handle to NextFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeMovieData;
if ~isempty(SpikeMovieData)
    CurrentMovie=get(handles.MovieSelector,'Value');
    CurrentIteration=str2num(get(handles.Step10Int,'String'));
    
    CurrentIteration=min(SpikeMovieData(CurrentMovie).DataSize(3),CurrentIteration+1);
    set(handles.Step10Int,'String',num2str(CurrentIteration));
end

% --- Executes on button press in PreviousFrame.
function PreviousFrame_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrentIteration=str2num(get(handles.Step10Int,'String'));

CurrentIteration=max(1,CurrentIteration-1);
set(handles.Step10Int,'String',num2str(CurrentIteration));


% function to display the current hist on a figure
function ImageFromFrame(image_nb,frame_nb,handles)
global SpikeMovieData;
global SpikeImageData;

if ~isempty(SpikeMovieData)
   
    
    CurrentMovie=get(handles.MovieSelector,'Value');
    SpikeImageData(image_nb).Image=SpikeMovieData(CurrentMovie).Movie(:,:,frame_nb);
    
    SpikeImageData(image_nb).Label.ListText=['Image from Movie ' int2str(CurrentMovie) ' ,Frame ' int2str(frame_nb)];
    
    SpikeImageData(image_nb).DataSize=size(SpikeImageData(image_nb).Image);
    
    SpikeImageData(image_nb).Path=SpikeMovieData(CurrentMovie).Path;
    SpikeImageData(image_nb).Filename=SpikeMovieData(CurrentMovie).Filename; 
    SpikeImageData(image_nb).Xposition=SpikeMovieData(CurrentMovie).Xposition;
    SpikeImageData(image_nb).Yposition=SpikeMovieData(CurrentMovie).Yposition;
    SpikeImageData(image_nb).Zposition=SpikeMovieData(CurrentMovie).Zposition;
    SpikeImageData(image_nb).Label.XLabel=SpikeMovieData(CurrentMovie).Label.XLabel;
    SpikeImageData(image_nb).Label.YLabel=SpikeMovieData(CurrentMovie).Label.YLabel;
    SpikeImageData(image_nb).Label.ZLabel=SpikeMovieData(CurrentMovie).Label.ZLabel;
    SpikeImageData(image_nb).Label.CLabel=SpikeMovieData(CurrentMovie).Label.CLabel;
    
    
    
end



function Step9Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step9Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step9Int as text
%        str2double(get(hObject,'String')) returns contents of Step9Int as a double


% --- Executes during object creation, after setting all properties.
function Step9Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step9Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step8Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step8Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step8Int as text
%        str2double(get(hObject,'String')) returns contents of Step8Int as a double


% --- Executes during object creation, after setting all properties.
function Step8Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step8Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step7Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step7Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step7Int as text
%        str2double(get(hObject,'String')) returns contents of Step7Int as a double


% --- Executes during object creation, after setting all properties.
function Step7Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step7Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step6Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step6Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step6Int as text
%        str2double(get(hObject,'String')) returns contents of Step6Int as a double


% --- Executes during object creation, after setting all properties.
function Step6Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step6Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step5Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step5Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step5Int as text
%        str2double(get(hObject,'String')) returns contents of Step5Int as a double


% --- Executes during object creation, after setting all properties.
function Step5Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step5Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step4Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step4Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step4Int as text
%        str2double(get(hObject,'String')) returns contents of Step4Int as a double


% --- Executes during object creation, after setting all properties.
function Step4Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step4Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step3Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step3Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step3Int as text
%        str2double(get(hObject,'String')) returns contents of Step3Int as a double


% --- Executes during object creation, after setting all properties.
function Step3Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step3Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step2Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step2Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step2Int as text
%        str2double(get(hObject,'String')) returns contents of Step2Int as a double


% --- Executes during object creation, after setting all properties.
function Step2Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step2Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step1Int_Callback(hObject, eventdata, handles)
% hObject    handle to Step1Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step1Int as text
%        str2double(get(hObject,'String')) returns contents of Step1Int as a double


% --- Executes during object creation, after setting all properties.
function Step1Int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step1Int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
