function varargout = GetPoints_MeasureDistance(varargin)
% GETPOINTS_MEASUREDISTANCE MATLAB code for GetPoints_MeasureDistance.fig
%      GETPOINTS_MEASUREDISTANCE, by itself, creates a new GETPOINTS_MEASUREDISTANCE or raises the existing
%      singleton*.
%
%      H = GETPOINTS_MEASUREDISTANCE returns the handle to a new GETPOINTS_MEASUREDISTANCE or the handle to
%      the existing singleton*.
%
%      GETPOINTS_MEASUREDISTANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETPOINTS_MEASUREDISTANCE.M with the given input arguments.
%
%      GETPOINTS_MEASUREDISTANCE('Property','Value',...) creates a new GETPOINTS_MEASUREDISTANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GetPoints_MeasureDistance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GetPoints_MeasureDistance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Jerome Lecoq in 2012

% Edit the above text to modify the response to help GetPoints_MeasureDistance

% Last Modified by GUIDE v2.5 26-Feb-2013 14:15:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GetPoints_MeasureDistance_OpeningFcn, ...
                   'gui_OutputFcn',  @GetPoints_MeasureDistance_OutputFcn, ...
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


% --- Executes just before GetPoints_MeasureDistance is made visible.
function GetPoints_MeasureDistance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GetPoints_MeasureDistance (see VARARGIN)
global SpikeImageData;

% Choose default command line output for GetPoints_MeasureDistance
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GetPoints_MeasureDistance wait for user response (see UIRESUME)
% uiwait(handles.figure1);
NumberImages=length(SpikeImageData);

if ~isempty(SpikeImageData)
    for i=1:NumberImages
        TextImage{i}=[num2str(i),' - ',SpikeImageData(i).Label.ListText];
    end
    set(handles.ImageSelector,'String',TextImage);
end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.ImageSelector,'Value',intersect(1:NumberImages,Settings.ImageSelectorValue));
    set(handles.NbPoints,'String',Settings.NbPointsString);
else
    set(handles.ImageSelector,'Value',[]);
end


% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.ImageSelectorValue=get(handles.ImageSelector,'Value');
Settings.NbPointsString=get(handles.NbPoints,'String')


% --- Outputs from this function are returned to the command line.
function varargout = GetPoints_MeasureDistance_OutputFcn(hObject, eventdata, handles) 
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
uiresume;


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeImageData;
global SpikeTraceData;



try
    InterfaceObj=findobj(handles.output,'Enable','on');
    set(InterfaceObj,'Enable','off');
   
    ImageSel=get(handles.ImageSelector,'Value');
   
    nb_pts_per_im = str2num(get(handles.NbPoints,'String'));
      
    NumberImages=length(ImageSel);
    
    Xpts=zeros(nb_pts_per_im*NumberImages,1);
    Ypts=zeros(nb_pts_per_im*NumberImages,1);
   
    DiffX=zeros((nb_pts_per_im-1)*NumberImages,1);
    DiffY=zeros((nb_pts_per_im-1)*NumberImages,1);
    

    for n=1:NumberImages
        
        f=figure;
        imagesc(SpikeImageData(ImageSel(n)).Image);
        
        [Xpts_im,Ypts_im] = ginput(nb_pts_per_im);
        
        for i=1:nb_pts_per_im
            
            
            Xpts((n-1)*nb_pts_per_im+i)=Xpts_im(i);
            Ypts((n-1)*nb_pts_per_im+i)=Ypts_im(i);
            
            if i>1
                DiffX((n-1)*(nb_pts_per_im-1)+i-1)=Xpts_im(i)-Xpts_im(i-1);
                DiffY((n-1)*(nb_pts_per_im-1)+i-1)=Ypts_im(i)-Ypts_im(i-1);
            end
            
        end
    end
    
    BeginTrace=length(SpikeTraceData)+1;
    n=0;
    
    SpikeTraceData(BeginTrace+n).XVector=1:length(DiffX);
    SpikeTraceData(BeginTrace+n).Trace=DiffX;
    SpikeTraceData(BeginTrace+n).DataSize=length(DiffX);
    
    name=['Diff X'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='pixels';
    SpikeTraceData(BeginTrace+n).Label.XLabel='dist. #';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
    n=n+1;
    
    SpikeTraceData(BeginTrace+n).XVector=1:length(DiffY);
    SpikeTraceData(BeginTrace+n).Trace=DiffY;
    SpikeTraceData(BeginTrace+n).DataSize=length(DiffY);
    
    name=['Diff Y'];
    SpikeTraceData(BeginTrace+n).Label.ListText=name;
    SpikeTraceData(BeginTrace+n).Label.YLabel='pixels';
    SpikeTraceData(BeginTrace+n).Label.XLabel='dist. #';
    SpikeTraceData(BeginTrace+n).Filename='';
    SpikeTraceData(BeginTrace+n).Path='';
    n=n+1;
    
    
    
    
    ValidateValues_Callback(hObject, eventdata, handles);
    set(InterfaceObj,'Enable','on');
    
catch errorObj
    set(InterfaceObj,'Enable','on');
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');

end

% --- Executes on selection change in ImageSelector.
function ImageSelector_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ImageSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImageSelector


% --- Executes during object creation, after setting all properties.
function ImageSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ValidateValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function NbPoints_Callback(hObject, eventdata, handles)
% hObject    handle to NbPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NbPoints as text
%        str2double(get(hObject,'String')) returns contents of NbPoints as a double


% --- Executes during object creation, after setting all properties.
function NbPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NbPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
