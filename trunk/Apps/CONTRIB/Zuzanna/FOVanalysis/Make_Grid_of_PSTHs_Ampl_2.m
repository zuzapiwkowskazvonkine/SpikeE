function varargout = Make_Grid_of_PSTHs_Ampl_2(varargin)
% MAKE_GRID_OF_PSTHS_AMPL_2 M-file for Make_Grid_of_PSTHs_Ampl_2.fig
%      MAKE_GRID_OF_PSTHS_AMPL_2, by itself, creates a new MAKE_GRID_OF_PSTHS_AMPL_2 or raises the existing
%      singleton*.
%
%      H = MAKE_GRID_OF_PSTHS_AMPL_2 returns the handle to a new MAKE_GRID_OF_PSTHS_AMPL_2 or the handle to
%      the existing singleton*.
%
%      MAKE_GRID_OF_PSTHS_AMPL_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE_GRID_OF_PSTHS_AMPL_2.M with the given input arguments.
%
%      MAKE_GRID_OF_PSTHS_AMPL_2('Property','Value',...) creates a new MAKE_GRID_OF_PSTHS_AMPL_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Make_Grid_of_PSTHs_Ampl_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Make_Grid_of_PSTHs_Ampl_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Make_Grid_of_PSTHs_Ampl_2

% Last Modified by GUIDE v2.5 07-Oct-2014 14:47:15

% Begin initialization code - DO NOT EDIT

% testing Github

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Make_Grid_of_PSTHs_Ampl_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Make_Grid_of_PSTHs_Ampl_2_OutputFcn, ...
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


% --- Executes just before Make_Grid_of_PSTHs_Ampl_2 is made visible.
function Make_Grid_of_PSTHs_Ampl_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Make_Grid_of_PSTHs_Ampl_2 (see VARARGIN)

% Choose default command line output for Make_Grid_of_PSTHs_Ampl_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Make_Grid_of_PSTHs_Ampl_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeImageData;
global DLPstim;
global SpikeTraceData;

set(handles.SavingPath,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_DCN_SU_subset\Other\PSTHsPlot');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_DCN_SU_subset\Other\PSTHsPlot';

    
   if ~isempty(SpikeTraceData)
       for i=1:length(SpikeTraceData)
           TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
       end
       set(handles.TraceRespAmp,'String',TextTrace);
       set(handles.TraceXsize,'String',TextTrace);
       set(handles.TraceYsize,'String',TextTrace);
       set(handles.TraceInts,'String',TextTrace);
       set(handles.TraceIntsTable,'String',TextTrace);
       set(handles.TraceNbTraces,'String',TextTrace);
       set(handles.PSTHTrace1,'String',TextTrace);
       set(handles.TraceSignResp,'String',TextTrace);
       set(handles.TraceFOV,'String',TextTrace);
       set(handles.FOVXlocTrace,'String',TextTrace);
       set(handles.FOVYlocTrace,'String',TextTrace);
   end
   

if (length(varargin)>1)
    Settings=varargin{2};
    
    set(handles.TraceRespAmp,'String',Settings.TraceRespAmpString);
    set(handles.TraceXsize,'String',Settings.TraceXsizeString);
    set(handles.TraceYsize,'String',Settings.TraceYsizeString);
    set(handles.TraceInts,'String',Settings.TraceIntsString);
    set(handles.TraceIntsTable,'String',Settings.TraceIntsTableString);
    set(handles.TraceNbTraces,'String',Settings.TraceNbTracesString);
    set(handles.TraceSignResp,'String',Settings.TraceSignRespString);
    set(handles.TraceFOV,'String',Settings.TraceFOVString);
    
    set(handles.TraceRespAmp,'Value',Settings.TraceRespAmpValue);
    set(handles.TraceXsize,'Value',Settings.TraceXsizeValue);
    set(handles.TraceYsize,'Value',Settings.TraceYsizeValue);
    set(handles.TraceInts,'Value',Settings.TraceIntsValue);
    set(handles.TraceIntsTable,'Value',Settings.TraceIntsTableValue);
    set(handles.TraceNbTraces,'Value',Settings.TraceNbTracesValue);
    set(handles.TraceSignResp,'Value',Settings.TraceSignRespValue);
    set(handles.TraceFOV,'Value',Settings.TraceFOVValue);
    
    set(handles.PSTHTrace1,'String',Settings.PSTHTrace1String);
    set(handles.PSTHTrace1,'Value',Settings.PSTHTrace1Value);
    set(handles.Factor10,'Value',Settings.Factor10Value);
    
    set(handles.FOVXlocTrace,'String',Settings.FOVXlocTraceString);
    set(handles.FOVXlocTrace,'Value',Settings.FOVXlocTraceValue);
    set(handles.FOVYlocTrace,'String',Settings.FOVYlocTraceString);
    set(handles.FOVYlocTrace,'Value',Settings.FOVYlocTraceValue);
    set(handles.SFX,'String',Settings.SFXString);
    set(handles.SFY,'String',Settings.SFYString);
    
    set(handles.Ysizetarget,'String',Settings.YsizetargetString);
    set(handles.Xsizetarget,'String',Settings.XsizetargetString);
    

end
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Make_Grid_of_PSTHs_Ampl_2_OutputFcn(hObject, eventdata, handles) 
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
Settings.TraceXsizeString=get(handles.TraceXsize,'String');
Settings.TraceXsizeValue=get(handles.TraceXsize,'Value');
Settings.TraceYsizeString=get(handles.TraceYsize,'String');
Settings.TraceYsizeValue=get(handles.TraceYsize,'Value');
Settings.TraceIntsString=get(handles.TraceInts,'String');
Settings.TraceIntsValue=get(handles.TraceInts,'Value');
Settings.TraceIntsTableString=get(handles.TraceIntsTable,'String');
Settings.TraceIntsTableValue=get(handles.TraceIntsTable,'Value');
Settings.TraceNbTracesString=get(handles.TraceNbTraces,'String');
Settings.TraceNbTracesValue=get(handles.TraceNbTraces,'Value');
Settings.PSTHTrace1String=get(handles.PSTHTrace1,'String');
Settings.PSTHTrace1Value=get(handles.PSTHTrace1,'Value');
Settings.Factor10Value=get(handles.Factor10,'Value');
Settings.TraceSignRespString=get(handles.TraceSignResp,'String');
Settings.TraceSignRespValue=get(handles.TraceSignResp,'Value');
Settings.TraceFOVString=get(handles.TraceFOV,'String');
Settings.TraceFOVValue=get(handles.TraceFOV,'Value');

Settings.FOVXlocTraceString=get(handles.FOVXlocTrace,'String');
Settings.FOVXlocTraceValue=get(handles.FOVXlocTrace,'Value');
Settings.FOVYlocTraceString=get(handles.FOVYlocTrace,'String');
Settings.FOVYlocTraceValue=get(handles.FOVYlocTrace,'Value');
Settings.SFXString=get(handles.SFX,'String');
Settings.SFYString=get(handles.SFY,'String');



Settings.YsizetargetString= get(handles.Ysizetarget,'String');
Settings.XsizetargetString= get(handles.Xsizetarget,'String');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData;

respstrace=get(handles.TraceRespAmp,'Value');
xsizetrace=get(handles.TraceXsize,'Value');
ysizetrace=get(handles.TraceYsize,'Value');
intstrace=get(handles.TraceInts,'Value');
intstabletrace=get(handles.TraceIntsTable,'Value');
nbtracestrace=get(handles.TraceNbTraces,'Value');
psth1trace=get(handles.PSTHTrace1,'Value');
signresptrace=get(handles.TraceSignResp,'Value');
fovtrace=get(handles.TraceFOV,'Value');

ysizetarget = str2num(get(handles.Ysizetarget,'String'));
xsizetarget = str2num(get(handles.Xsizetarget,'String'));

x10=get(handles.Factor10,'Value');

fovxloctrace=get(handles.FOVXlocTrace,'Value');
fovyloctrace=get(handles.FOVYlocTrace,'Value');
sfx=str2double(get(handles.SFX,'String'));
sfy=str2double(get(handles.SFY,'String'));

[sortint,sortint_ind]=sort(SpikeTraceData(intstrace).Trace);
oldint=0;


% get max and min response amplitudes for color coding:
minresp=min(SpikeTraceData(respstrace).Trace);
maxresp=max(SpikeTraceData(respstrace).Trace);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make figure of colormap based on minresp and maxresp (20 steps)
m=colormap('jet');
colorfig=figure;
step=(1/63)*(maxresp-minresp);
vec=minresp:step:maxresp;
for k=1:64
    rel=(vec(k)-minresp)/(maxresp-minresp);
    colorindex=max(1,floor(rel*64));
    plot([1 2],[vec(k) vec(k)],'color',m(colorindex,:),'LineWidth',5);
    hold on;
end
hold off;


% a first loop to determine the index of the last File of target
% xsizetarget && ysizetarget
% (needed for plotting purposes later)

% also use this loop to get all the FOV numbers that are actually
% stimulated for this xsize, ysize pair.
fovs=[];


for z=1:length(SpikeTraceData(nbtracestrace).Trace) % loop over Files (ie groups of PSTHs from one stimulus sequence)    
    k=sortint_ind(z); % when looping over Files, use the sorted indices so that neigboring Files have same intensities   
    if SpikeTraceData(xsizetrace).Trace(k)==xsizetarget &&  SpikeTraceData(ysizetrace).Trace(k)==ysizetarget
%         lastfile=z;
        fovs(end+1)=SpikeTraceData(fovtrace).Trace(k);
    end
end
fovs=unique(fovs)

global fov_figh
fov_figh={}; %figs handles
%create one figure per fov
for i=1:length(fovs)
    fov_figh{i}=figure;
end

nblines=300/ysizetarget
nbcols=300/xsizetarget

% FOR SIMPLICITY, HERE IT IS ASSUMED ALL TRACES WERE COLLECTED AT ONLY ONE
% STIMULUS INTENSITY. NEED TO MODIFY LOOP IF OTHERWISE.

% then actual loop for plotting:
for z=1:length(SpikeTraceData(nbtracestrace).Trace) % loop over Files (ie groups of PSTHs from one stimulus sequence)
    
    k=sortint_ind(z); % when looping over Files, use the sorted indices so that neigboring Files have same intensities
    
    if SpikeTraceData(xsizetrace).Trace(k)==xsizetarget && SpikeTraceData(ysizetrace).Trace(k)==ysizetarget

        fov=SpikeTraceData(fovtrace).Trace(k);
        ind_fov=find(fovs==fov)
                
        xsize=SpikeTraceData(xsizetrace).Trace(k);
        ysize=SpikeTraceData(ysizetrace).Trace(k);
        casesize=min(xsize,ysize);
        xdim=xsize/casesize;
        ydim=ysize/casesize;
        
        
        int=SpikeTraceData(intstrace).Trace(k);
        if x10
            int=10*int;
        end
        ind=find(SpikeTraceData(intstabletrace).XVector==int);
        intW=SpikeTraceData(intstabletrace).Trace(ind);
        
        titlename=['Int:' num2str(int) '/ ' num2str(intW) ' uW, Xsize:' num2str(xsizetarget) ', Ysize:' num2str(ysizetarget)];
    
                
        %get (x,y) indices of PSTHs eliciting significant response:
        
        % get indices of the PSTHs from this file (relative to 1, ie to first PSTH in Traces):
        tottraces=sum(SpikeTraceData(nbtracestrace).Trace(1:k-1));
        firstpsth=tottraces+1;
        lastpsth=tottraces+SpikeTraceData(nbtracestrace).Trace(k);
        inds=psth1trace+firstpsth-1:1:psth1trace+lastpsth-1;
        xs=[];
        ys=[];
        resps=[];
        
        % of those, get (X,Y) of PSTHs with significant responses (-> xs, ys):
        % also, get response amplitudes for PSTHs with significant responses:
        
        for n=1:length(inds)
            if SpikeTraceData(signresptrace).Trace(inds(n)-psth1trace+1)==1
                %parse Label.ListText to get X and Y
                nametoparse=SpikeTraceData(inds(n)).Label.ListText;
                a=strfind(nametoparse,'X:');
                ipos=a+2;
                b=strfind(nametoparse,'Y:');
                jpos=b+2;
                
                numcharsi=jpos-ipos-3;
                
                xs(end+1)=str2double(nametoparse(ipos:ipos+numcharsi-1));
                ys(end+1)=str2double(nametoparse(jpos:length(nametoparse)));
                
                % get responses
                resp=SpikeTraceData(respstrace).Trace(inds(n)-psth1trace+1);
                relresp=(resp-minresp)/(maxresp-minresp);
                colorresp=max(1,floor(relresp*64)); %colormaps have 64 hues typically
                resps(end+1)=colorresp;
                
            end
        end
        
        figure(fov_figh{ind_fov});
        title(['FOV ' int2str(fov)])
        
        for s=1:length(inds)
            i=inds(s);
            subplot(nblines,nbcols,max(nblines,nbcols)-s+1);
            
            if SpikeTraceData(signresptrace).Trace(i-psth1trace+1)==1
                resp=SpikeTraceData(respstrace).Trace(i-psth1trace+1);
                relresp=(resp-minresp)/(maxresp-minresp);
                colorresp=max(1,floor(relresp*64));
                m=colormap('jet');
                vcolor=m(colorresp,:);
                plot(SpikeTraceData(i).Trace,'color',vcolor,'LineWidth',2);
                hold on
                plot([ceil(length(SpikeTraceData(i).Trace)/2) ceil(length(SpikeTraceData(i).Trace)/2)],[min(SpikeTraceData(i).Trace) max(SpikeTraceData(i).Trace)],'k');
                drawnow;
            else
                plot(SpikeTraceData(i).Trace,'k');
                hold on
                plot([ceil(length(SpikeTraceData(i).Trace)/2) ceil(length(SpikeTraceData(i).Trace)/2)],[min(SpikeTraceData(i).Trace) max(SpikeTraceData(i).Trace)],'r');
                drawnow;
            end
            hold on
        end
                
    end
    hold off              
end


% save fig p
for i=1:length(fovs)
    fname=[handles.Path '\' 'FOV'  num2str(fovs(i)) '_Int' num2str(int) '_' num2str(intW) 'uW_Xsize' num2str(xsizetarget) '_Ysize' num2str(ysizetarget) '_' SpikeTraceData(inds(1)).Filename '_PSTHs.fig'];
    figure(fov_figh{i});
    title(['FOV ' num2str(fovs(i)) ' Int ' num2str(int) '/' num2str(intW) ' uW, Xsize:' num2str(xsizetarget) ', Ysize:' num2str(ysizetarget)]);
    saveas(fov_figh{i},fname);
end
% save fig colorfig too
fcname=[handles.Path '\' 'Int' num2str(int) '_' num2str(intW) 'uW_Xsize' num2str(xsizetarget) '_Ysize' num2str(ysizetarget) '_' SpikeTraceData(inds(1)).Filename '_colormapPSTHs.fig'];
saveas(colorfig,fcname);


ValidateValues_Callback(hObject, eventdata, handles);




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


% --- Executes on button press in GetPath.
function GetPath_Callback(hObject, eventdata, handles)
% hObject    handle to GetPath (see GCBO)
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
    set(handles.SavingPath,'String',NewPath);
    guidata(hObject,handles);
%     CreateFileName(hObject, handles);
end


% --- Executes on selection change in FOVXlocTrace.
function FOVXlocTrace_Callback(hObject, eventdata, handles)
% hObject    handle to FOVXlocTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FOVXlocTrace contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FOVXlocTrace


% --- Executes during object creation, after setting all properties.
function FOVXlocTrace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FOVXlocTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FOVYlocTrace.
function FOVYlocTrace_Callback(hObject, eventdata, handles)
% hObject    handle to FOVYlocTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FOVYlocTrace contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FOVYlocTrace


% --- Executes during object creation, after setting all properties.
function FOVYlocTrace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FOVYlocTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SFX_Callback(hObject, eventdata, handles)
% hObject    handle to SFX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SFX as text
%        str2double(get(hObject,'String')) returns contents of SFX as a double


% --- Executes during object creation, after setting all properties.
function SFX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SFX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SFY_Callback(hObject, eventdata, handles)
% hObject    handle to SFY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SFY as text
%        str2double(get(hObject,'String')) returns contents of SFY as a double


% --- Executes during object creation, after setting all properties.
function SFY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SFY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in TraceStimDurs.
function TraceStimDurs_Callback(hObject, eventdata, handles)
% hObject    handle to TraceStimDurs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TraceStimDurs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TraceStimDurs


% --- Executes during object creation, after setting all properties.
function TraceStimDurs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TraceStimDurs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ysizetarget_Callback(hObject, eventdata, handles)
% hObject    handle to Ysizetarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ysizetarget as text
%        str2double(get(hObject,'String')) returns contents of Ysizetarget as a double


% --- Executes during object creation, after setting all properties.
function Ysizetarget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ysizetarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xsizetarget_Callback(hObject, eventdata, handles)
% hObject    handle to Xsizetarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xsizetarget as text
%        str2double(get(hObject,'String')) returns contents of Xsizetarget as a double


% --- Executes during object creation, after setting all properties.
function Xsizetarget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xsizetarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when SettingsPanel is resized.
function SettingsPanel_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to SettingsPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
