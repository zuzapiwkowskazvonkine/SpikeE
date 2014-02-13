function varargout = Get_FOV_XYZ_locations(varargin)
% GET_FOV_XYZ_LOCATIONS MATLAB code for Get_FOV_XYZ_locations.fig
%      GET_FOV_XYZ_LOCATIONS, by itself, creates a new GET_FOV_XYZ_LOCATIONS or raises the existing
%      singleton*.
%
%      H = GET_FOV_XYZ_LOCATIONS returns the handle to a new GET_FOV_XYZ_LOCATIONS or the handle to
%      the existing singleton*.
%
%      GET_FOV_XYZ_LOCATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GET_FOV_XYZ_LOCATIONS.M with the given input arguments.
%
%      GET_FOV_XYZ_LOCATIONS('Property','Value',...) creates a new GET_FOV_XYZ_LOCATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Get_FOV_XYZ_locations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Get_FOV_XYZ_locations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2011

% Edit the above text to modify the response to help Get_FOV_XYZ_locations

% Last Modified by GUIDE v2.5 26-Feb-2013 11:41:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Get_FOV_XYZ_locations_OpeningFcn, ...
                   'gui_OutputFcn',  @Get_FOV_XYZ_locations_OutputFcn, ...
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


% --- Executes just before Get_FOV_XYZ_locations is made visible.
function Get_FOV_XYZ_locations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Get_FOV_XYZ_locations (see VARARGIN)

% Choose default command line output for Get_FOV_XYZ_locations
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Get_FOV_XYZ_locations wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global SpikeMovieData;

if (length(varargin)>1)
    Settings=varargin{2};   
    set(handles.X10,'String',Settings.X10String);
    set(handles.X9,'String',Settings.X9String);
    set(handles.X8,'String',Settings.X8String);
    set(handles.X7,'String',Settings.X7String);
    set(handles.X6,'String',Settings.X6String);
    set(handles.X5,'String',Settings.X5String);
    set(handles.X4,'String',Settings.X4String);
    set(handles.X3,'String',Settings.X3String);
    set(handles.X2,'String',Settings.X2String);
    set(handles.X1,'String',Settings.X1String);
     set(handles.Y10,'String',Settings.Y10String);
    set(handles.Y9,'String',Settings.Y9String);
    set(handles.Y8,'String',Settings.Y8String);
    set(handles.Y7,'String',Settings.Y7String);
    set(handles.Y6,'String',Settings.Y6String);
    set(handles.Y5,'String',Settings.Y5String);
    set(handles.Y4,'String',Settings.Y4String);
    set(handles.Y3,'String',Settings.Y3String);
    set(handles.Y2,'String',Settings.Y2String);
    set(handles.Y1,'String',Settings.Y1String);
    set(handles.Z10,'String',Settings.YZ10String);
    set(handles.Z9,'String',Settings.Z9String);
    set(handles.Z8,'String',Settings.Z8String);
    set(handles.Z7,'String',Settings.Z7String);
    set(handles.Z6,'String',Settings.Z6String);
    set(handles.Z5,'String',Settings.Z5String);
    set(handles.Z4,'String',Settings.Z4String);
    set(handles.Z3,'String',Settings.Z3String);
    set(handles.Z2,'String',Settings.Z2String);
    set(handles.Z1,'String',Settings.Z1String);
    set(handles.TotFOVNb,'String',Settings.TotFOVNbString);

end

% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.X10String=get(handles.X10,'String');
Settings.X9tString=get(handles.X9,'String');
Settings.X8String=get(handles.X8,'String');
Settings.X7String=get(handles.X7,'String');
Settings.X6String=get(handles.X6,'String');
Settings.X5String=get(handles.X5,'String');
Settings.X4String=get(handles.X4,'String');
Settings.X3String=get(handles.X3,'String');
Settings.X2String=get(handles.X2,'String');
Settings.X1String=get(handles.X1,'String');
Settings.Y10String=get(handles.Y10,'String');
Settings.Y9tString=get(handles.Y9,'String');
Settings.Y8String=get(handles.Y8,'String');
Settings.Y7String=get(handles.Y7,'String');
Settings.Y6String=get(handles.Y6,'String');
Settings.Y5String=get(handles.Y5,'String');
Settings.Y4String=get(handles.Y4,'String');
Settings.Y3String=get(handles.Y3,'String');
Settings.Y2String=get(handles.Y2,'String');
Settings.Y1String=get(handles.Y1,'String');
Settings.Z10String=get(handles.Z10,'String');
Settings.Z9tString=get(handles.Z9,'String');
Settings.Z8String=get(handles.Z8,'String');
Settings.Z7String=get(handles.Z7,'String');
Settings.Z6String=get(handles.Z6,'String');
Settings.Z5String=get(handles.Z5,'String');
Settings.Z4String=get(handles.Z4,'String');
Settings.Z3String=get(handles.Z3,'String');
Settings.Z2String=get(handles.Z2,'String');
Settings.Z1String=get(handles.Z1,'String');
Settings.TotFOVNbString=get(handles.TotFOVNb,'String');


% --- Outputs from this function are returned to the command line.
function varargout = Get_FOV_XYZ_locations_OutputFcn(hObject, eventdata, handles) 
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
    
    tot=str2num(get(handles.TotFOVNb,'String'));
    
    xs=zeros(1,10);
    xs(10)=str2double(get(handles.X10,'String'));
    xs(9)=str2double(get(handles.X9,'String'));
    xs(8)=str2double(get(handles.X8,'String'));
    xs(7)=str2double(get(handles.X7,'String'));
    xs(6)=str2double(get(handles.X6,'String'));
    xs(5)=str2double(get(handles.X5,'String'));
    xs(4)=str2double(get(handles.X4,'String'));
    xs(3)=str2double(get(handles.X3,'String'));
    xs(2)=str2double(get(handles.X2,'String'));
    xs(1)=str2double(get(handles.X1,'String'));
    
    ys=zeros(1,10);
    ys(10)=str2double(get(handles.Y10,'String'));
    ys(9)=str2double(get(handles.Y9,'String'));
    ys(8)=str2double(get(handles.Y8,'String'));
    ys(7)=str2double(get(handles.Y7,'String'));
    ys(6)=str2double(get(handles.Y6,'String'));
    ys(5)=str2double(get(handles.Y5,'String'));
    ys(4)=str2double(get(handles.Y4,'String'));
    ys(3)=str2double(get(handles.Y3,'String'));
    ys(2)=str2double(get(handles.Y2,'String'));
    ys(1)=str2double(get(handles.Y1,'String'));
    
    zs=zeros(1,10);
    zs(10)=str2double(get(handles.Z10,'String'));
    zs(9)=str2double(get(handles.Z9,'String'));
    zs(8)=str2double(get(handles.Z8,'String'));
    zs(7)=str2double(get(handles.Z7,'String'));
    zs(6)=str2double(get(handles.Z6,'String'));
    zs(5)=str2double(get(handles.Z5,'String'));
    zs(4)=str2double(get(handles.Z4,'String'));
    zs(3)=str2double(get(handles.Z3,'String'));
    zs(2)=str2double(get(handles.Z2,'String'));
    zs(1)=str2double(get(handles.Z1,'String'));
    
    
    SpikeTraceData(BeginTrace+n).XVector=1:tot;
    SpikeTraceData(BeginTrace+n).Trace=xs(1:tot);
    SpikeTraceData(BeginTrace+n).DataSize=tot;
    
    name=['X FOV'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='um';
    SpikeTraceData(BeginTrace+n).Label.XLabel='FOV #';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=1:tot;
    SpikeTraceData(BeginTrace+n).Trace=ys(1:tot);
    SpikeTraceData(BeginTrace+n).DataSize=tot;
    
    name=['Y FOV'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='um';
    SpikeTraceData(BeginTrace+n).Label.XLabel='FOV #';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=1:tot;
    SpikeTraceData(BeginTrace+n).Trace=zs(1:tot);
    SpikeTraceData(BeginTrace+n).DataSize=tot;
    
    name=['Z FOV'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='um';
    SpikeTraceData(BeginTrace+n).Label.XLabel='FOV #';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
  
    
catch errorObj
    set(InterfaceObj,'Enable','on');
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

ValidateValues_Callback(hObject, eventdata, handles);



function X10_Callback(hObject, eventdata, handles)
% hObject    handle to X10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X10 as text
%        str2double(get(hObject,'String')) returns contents of X10 as a double


% --- Executes during object creation, after setting all properties.
function X10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X10 (see GCBO)
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
    CurrentIteration=str2num(get(handles.X10,'String'));
    
    CurrentIteration=min(SpikeMovieData(CurrentMovie).DataSize(3),CurrentIteration+1);
    set(handles.X10,'String',num2str(CurrentIteration));
end

% --- Executes on button press in PreviousFrame.
function PreviousFrame_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrentIteration=str2num(get(handles.X10,'String'));

CurrentIteration=max(1,CurrentIteration-1);
set(handles.X10,'String',num2str(CurrentIteration));


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



function X9_Callback(hObject, eventdata, handles)
% hObject    handle to X9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X9 as text
%        str2double(get(hObject,'String')) returns contents of X9 as a double


% --- Executes during object creation, after setting all properties.
function X9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X8_Callback(hObject, eventdata, handles)
% hObject    handle to X8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X8 as text
%        str2double(get(hObject,'String')) returns contents of X8 as a double


% --- Executes during object creation, after setting all properties.
function X8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X7_Callback(hObject, eventdata, handles)
% hObject    handle to X7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X7 as text
%        str2double(get(hObject,'String')) returns contents of X7 as a double


% --- Executes during object creation, after setting all properties.
function X7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X6_Callback(hObject, eventdata, handles)
% hObject    handle to X6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X6 as text
%        str2double(get(hObject,'String')) returns contents of X6 as a double


% --- Executes during object creation, after setting all properties.
function X6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X5_Callback(hObject, eventdata, handles)
% hObject    handle to X5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X5 as text
%        str2double(get(hObject,'String')) returns contents of X5 as a double


% --- Executes during object creation, after setting all properties.
function X5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X4_Callback(hObject, eventdata, handles)
% hObject    handle to X4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X4 as text
%        str2double(get(hObject,'String')) returns contents of X4 as a double


% --- Executes during object creation, after setting all properties.
function X4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X3_Callback(hObject, eventdata, handles)
% hObject    handle to X3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X3 as text
%        str2double(get(hObject,'String')) returns contents of X3 as a double


% --- Executes during object creation, after setting all properties.
function X3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X2_Callback(hObject, eventdata, handles)
% hObject    handle to X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X2 as text
%        str2double(get(hObject,'String')) returns contents of X2 as a double


% --- Executes during object creation, after setting all properties.
function X2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X1_Callback(hObject, eventdata, handles)
% hObject    handle to X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X1 as text
%        str2double(get(hObject,'String')) returns contents of X1 as a double


% --- Executes during object creation, after setting all properties.
function X1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y10_Callback(hObject, eventdata, handles)
% hObject    handle to Y10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y10 as text
%        str2double(get(hObject,'String')) returns contents of Y10 as a double


% --- Executes during object creation, after setting all properties.
function Y10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y9_Callback(hObject, eventdata, handles)
% hObject    handle to Y9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y9 as text
%        str2double(get(hObject,'String')) returns contents of Y9 as a double


% --- Executes during object creation, after setting all properties.
function Y9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y8_Callback(hObject, eventdata, handles)
% hObject    handle to Y8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y8 as text
%        str2double(get(hObject,'String')) returns contents of Y8 as a double


% --- Executes during object creation, after setting all properties.
function Y8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y7_Callback(hObject, eventdata, handles)
% hObject    handle to Y7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y7 as text
%        str2double(get(hObject,'String')) returns contents of Y7 as a double


% --- Executes during object creation, after setting all properties.
function Y7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y6_Callback(hObject, eventdata, handles)
% hObject    handle to Y6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y6 as text
%        str2double(get(hObject,'String')) returns contents of Y6 as a double


% --- Executes during object creation, after setting all properties.
function Y6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y5_Callback(hObject, eventdata, handles)
% hObject    handle to Y5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y5 as text
%        str2double(get(hObject,'String')) returns contents of Y5 as a double


% --- Executes during object creation, after setting all properties.
function Y5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y4_Callback(hObject, eventdata, handles)
% hObject    handle to Y4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y4 as text
%        str2double(get(hObject,'String')) returns contents of Y4 as a double


% --- Executes during object creation, after setting all properties.
function Y4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y3_Callback(hObject, eventdata, handles)
% hObject    handle to Y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y3 as text
%        str2double(get(hObject,'String')) returns contents of Y3 as a double


% --- Executes during object creation, after setting all properties.
function Y3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y2_Callback(hObject, eventdata, handles)
% hObject    handle to Y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y2 as text
%        str2double(get(hObject,'String')) returns contents of Y2 as a double


% --- Executes during object creation, after setting all properties.
function Y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y1_Callback(hObject, eventdata, handles)
% hObject    handle to Y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y1 as text
%        str2double(get(hObject,'String')) returns contents of Y1 as a double


% --- Executes during object creation, after setting all properties.
function Y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z10_Callback(hObject, eventdata, handles)
% hObject    handle to Z10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z10 as text
%        str2double(get(hObject,'String')) returns contents of Z10 as a double


% --- Executes during object creation, after setting all properties.
function Z10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z9_Callback(hObject, eventdata, handles)
% hObject    handle to Z9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z9 as text
%        str2double(get(hObject,'String')) returns contents of Z9 as a double


% --- Executes during object creation, after setting all properties.
function Z9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z8_Callback(hObject, eventdata, handles)
% hObject    handle to Z8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z8 as text
%        str2double(get(hObject,'String')) returns contents of Z8 as a double


% --- Executes during object creation, after setting all properties.
function Z8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z7_Callback(hObject, eventdata, handles)
% hObject    handle to Z7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z7 as text
%        str2double(get(hObject,'String')) returns contents of Z7 as a double


% --- Executes during object creation, after setting all properties.
function Z7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z6_Callback(hObject, eventdata, handles)
% hObject    handle to Z6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z6 as text
%        str2double(get(hObject,'String')) returns contents of Z6 as a double


% --- Executes during object creation, after setting all properties.
function Z6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z5_Callback(hObject, eventdata, handles)
% hObject    handle to Z5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z5 as text
%        str2double(get(hObject,'String')) returns contents of Z5 as a double


% --- Executes during object creation, after setting all properties.
function Z5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z4_Callback(hObject, eventdata, handles)
% hObject    handle to Z4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z4 as text
%        str2double(get(hObject,'String')) returns contents of Z4 as a double


% --- Executes during object creation, after setting all properties.
function Z4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_Callback(hObject, eventdata, handles)
% hObject    handle to Z3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3 as text
%        str2double(get(hObject,'String')) returns contents of Z3 as a double


% --- Executes during object creation, after setting all properties.
function Z3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_Callback(hObject, eventdata, handles)
% hObject    handle to Z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2 as text
%        str2double(get(hObject,'String')) returns contents of Z2 as a double


% --- Executes during object creation, after setting all properties.
function Z2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_Callback(hObject, eventdata, handles)
% hObject    handle to Z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1 as text
%        str2double(get(hObject,'String')) returns contents of Z1 as a double


% --- Executes during object creation, after setting all properties.
function Z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TotFOVNb_Callback(hObject, eventdata, handles)
% hObject    handle to TotFOVNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotFOVNb as text
%        str2double(get(hObject,'String')) returns contents of TotFOVNb as a double


% --- Executes during object creation, after setting all properties.
function TotFOVNb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotFOVNb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
