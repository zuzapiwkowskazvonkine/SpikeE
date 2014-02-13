function varargout = Combine_Data_from_Files(varargin)
% COMBINE_DATA_FROM_FILES M-file for Combine_Data_from_Files.fig
%      COMBINE_DATA_FROM_FILES, by itself, creates a new COMBINE_DATA_FROM_FILES or raises the existing
%      singleton*.
%
%      H = COMBINE_DATA_FROM_FILES returns the handle to a new COMBINE_DATA_FROM_FILES or the handle to
%      the existing singleton*.
%
%      COMBINE_DATA_FROM_FILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMBINE_DATA_FROM_FILES.M with the given input arguments.
%
%      COMBINE_DATA_FROM_FILES('Property','Value',...) creates a new COMBINE_DATA_FROM_FILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Combine_Data_from_Files_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Combine_Data_from_Files_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Combine_Data_from_Files

% Last Modified by GUIDE v2.5 05-Mar-2013 15:07:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Combine_Data_from_Files_OpeningFcn, ...
                   'gui_OutputFcn',  @Combine_Data_from_Files_OutputFcn, ...
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


% --- Executes just before Combine_Data_from_Files is made visible.
function Combine_Data_from_Files_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Combine_Data_from_Files (see VARARGIN)

% Choose default command line output for Combine_Data_from_Files
handles.output = hObject;



% UIWAIT makes Combine_Data_from_Files wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

path1='C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\072612\cell1';
path2=[path1 '\psths'];

set(handles.PathForLoading,'String',path1);
handles.Path=path1;

set(handles.PathForSaving,'String',path2);
handles.PathSave=path2;

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.PathForLoading,'String',Settings.PathForLoadingString);
    set(handles.PathForSaving,'String',Settings.PathForSavingString);
    handles.Path=Settings.Path;
    handles.PathSave=Settings.PathSave;

end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Combine_Data_from_Files_OutputFcn(hObject, eventdata, handles) 
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
Settings.PathForLoadingString=get(handles.PathForLoading,'String');
Settings.PathForSavingString=get(handles.PathForSaving,'String');
Settings.Path=handles.Path;
Settings.PathSave=handles.PathSave;


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeTraceData

%%%%%%%%%%%%%
filenameend=get(handles.FilenameEnd,'String');
filenameextension=get(handles.FilenameExtension,'String');

allfiles=dir(handles.Path); 
nbfiles=length(allfiles);
totnbtraces=0;
firsttrace=length(SpikeTraceData)+1;

for i=3:nbfiles %loop over files (first 2 are '.' and '..')
    
    toload=strfind(allfiles(i).name,[filenameend filenameextension]);
    
    if ~isempty(toload)
     
        namefile=[handles.Path '\' allfiles(i).name];
        
        BeginTrace=length(SpikeTraceData)+1;
        if exist('matfile')==2
            matObj = matfile(namefile);
            info=whos(matObj,'SpikeTraceData');
        else
            info=whos('-file',namefile,'SpikeTraceData');
        end
        
        NumberTrace=max(info.size);
        ListTraceToLoad=1:NumberTrace;
        
        if exist('matfile')==2
            matObj = matfile(namefile);
            SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=matObj.SpikeTraceData(1,ListTraceToLoad);
            
        else
            Tmp=load(namefile,'SpikeTraceData');
            SpikeTraceData(BeginTrace:(BeginTrace-1+length(ListTraceToLoad)))=Tmp.SpikeTraceData(1,ListTraceToLoad);
        end
        
        totnbtraces=totnbtraces+NumberTrace;
    
    end
    
end

newvec=zeros(1,totnbtraces);

for k=firsttrace:firsttrace+totnbtraces-1
   
    newvec(k-firsttrace+1)=SpikeTraceData(k).Trace(1);
    
end


        BeginTrace=length(SpikeTraceData)+1;
        SpikeTraceData(BeginTrace).XVector=1:totnbtraces;
        SpikeTraceData(BeginTrace).Trace=newvec;
        SpikeTraceData(BeginTrace).DataSize=totnbtraces;
        SpikeTraceData(BeginTrace).Label.ListText=['all ' filenameend ' from ' handles.Path];
        SpikeTraceData(BeginTrace).Label.YLabel=SpikeTraceData(k).Label.YLabel;
        SpikeTraceData(BeginTrace).Label.XLabel='';
        SpikeTraceData(BeginTrace).Filename=SpikeTraceData(k).Filename;
        SpikeTraceData(BeginTrace).Path=SpikeTraceData(k).Path;
                
        OldData=SpikeTraceData;
        SpikeTraceData=SpikeTraceData(BeginTrace);
        savefile=[handles.PathSave '\' 'all_' filenameend '.mat'];
        save(savefile,'SpikeTraceData');
        SpikeTraceData=OldData;
        
   

% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume;



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



function FilenameEnd_Callback(hObject, eventdata, handles)
% hObject    handle to FilenameEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilenameEnd as text
%        str2double(get(hObject,'String')) returns contents of FilenameEnd as a double


% --- Executes during object creation, after setting all properties.
function FilenameEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilenameEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FilenameExtension_Callback(hObject, eventdata, handles)
% hObject    handle to FilenameExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilenameExtension as text
%        str2double(get(hObject,'String')) returns contents of FilenameExtension as a double


% --- Executes during object creation, after setting all properties.
function FilenameExtension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilenameExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SetPath_Saving.
function SetPath_Saving_Callback(hObject, eventdata, handles)
% hObject    handle to SetPath_Saving (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Oldpath=cd;

cd(handles.PathSave);

% Open directory interface
NewPath=uigetdir(handles.PathSave);

cd(Oldpath);

% If "Cancel" is selected then return
if isequal(NewPath,0)
    return
else
    handles.PathSave=NewPath;
    set(handles.PathForSaving,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end

