function varargout = Plot_Results_Several_Cells(varargin)
% PLOT_RESULTS_SEVERAL_CELLS M-file for Plot_Results_Several_Cells.fig
%      PLOT_RESULTS_SEVERAL_CELLS, by itself, creates a new PLOT_RESULTS_SEVERAL_CELLS or raises the existing
%      singleton*.
%
%      H = PLOT_RESULTS_SEVERAL_CELLS returns the handle to a new PLOT_RESULTS_SEVERAL_CELLS or the handle to
%      the existing singleton*.
%
%      PLOT_RESULTS_SEVERAL_CELLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_RESULTS_SEVERAL_CELLS.M with the given input arguments.
%
%      PLOT_RESULTS_SEVERAL_CELLS('Property','Value',...) creates a new PLOT_RESULTS_SEVERAL_CELLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Plot_Results_Several_Cells_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Plot_Results_Several_Cells_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Plot_Results_Several_Cells

% Last Modified by GUIDE v2.5 18-Feb-2013 13:32:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Plot_Results_Several_Cells_OpeningFcn, ...
                   'gui_OutputFcn',  @Plot_Results_Several_Cells_OutputFcn, ...
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


% --- Executes just before Plot_Results_Several_Cells is made visible.
function Plot_Results_Several_Cells_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Plot_Results_Several_Cells (see VARARGIN)

% Choose default command line output for Plot_Results_Several_Cells
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Plot_Results_Several_Cells wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeTraceData;

TextTrace{1}='No Traces';
if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);

end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceSelector,'String',Settings.TraceSelectorString);
    set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);

end


% --- Outputs from this function are returned to the command line.
function varargout = Plot_Results_Several_Cells_OutputFcn(hObject, eventdata, handles) 
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

TraceRes=get(handles.TraceSelector,'Value');

refname=SpikeTraceData(TraceRes).Label.ListText;

tot=length(SpikeTraceData);

indsres=[];

for i=1:tot    
    if strcmp(SpikeTraceData(i).Label.ListText,refname)
        indsres(end+1)=i;
    end
end

indsres

MarkerTable(1)='O';
MarkerTable(2)='s';
MarkerTable(3)='^';
MarkerTable(4)='x';
MarkerTable(5)='*';
MarkerTable(6)='d';
MarkerTable(7)='+';
MarkerTable(8)='.';

ColorTable(1)='r';
ColorTable(2)='g';
ColorTable(3)='b';
ColorTable(4)='c';
ColorTable(5)='m';
ColorTable(6)='y';
ColorTable(7)='k';

mloop=1;
cloop=1;

datename='';
cellname='';

figure

for k=indsres % loop over Result Traces
    
  olddatename=datename;
  oldcellname=cellname;
    
  % get cell ID for legend from Path field  
  p=fileparts(SpikeTraceData(k).Path); 
  remp=length('C:\Users\Zuzanna\Documents\DataStanford2008-2012\ephys_data\'); %modify as needed
  tempname=p(remp+1:end);
  sep=strfind(tempname,'\');
  datename=tempname(1:sep-1);
  cellname=tempname(sep+1:end);
  
  % get a unique color+marker for this cell (keep same markers for diff cells in same animal)

  if ~strcmp(datename,olddatename)   
      mloop=mloop+1 %change markers if date changes 
      cloop=1; %reset color loop if date changes
  end
  
  % also 'freeze' Color and Marker loops if table size exceeded
  if mloop>length(MarkerTable)
      mloop=length(MarkerTable);
  end
  if cloop>length(ColorTable)
      cloop=length(ColorTable)
  end
  
  plotstyle=[ColorTable(cloop) MarkerTable(mloop)];
  
  % plot data for this cell (with legend)
  hp=plot(SpikeTraceData(k).XVector,SpikeTraceData(k).Trace, plotstyle);
  set(hp,'DisplayName',[datename ' ' cellname]);
  set(get(get(hp,'Annotation'),'LegendInformation'),'IconDisplayStyle','Children');
  hold on
  
  cloop=cloop+1;
  
end

title(refname);
xlabel('Yellow Light Power (microW)') ; %change as needed
ylabel('Extent in FOV producing significant response (pixels on DLP screen)') ; %change as needed
legend('show');
legend('Location','Best');
hold off    


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






