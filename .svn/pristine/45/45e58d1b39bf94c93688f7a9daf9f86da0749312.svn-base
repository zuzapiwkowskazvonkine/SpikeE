function varargout = Place_Fields(varargin)
% PLACE_FIELDS This App aligns one or more traces to points given in the
% binary alignment trace. Any point in the alignment trace with a 1 will be
% an alignment point, and all trace fragments surrounding an alignment
% point will be laid on top of one another. Useful for traces which contain
% multiple repeats of the same experiment, cue, or action.
%
% Output will save as many traces as are input; each will be of length (#
% frames before) + 1 + (# frames after), as set in the GUI.
%
% Created by Lacey Kitch in 2012

% Edit the above text to modify the response to help Place_Fields

% Last Modified by GUIDE v2.5 17-Jul-2012 19:32:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Place_Fields_OpeningFcn, ...
                   'gui_OutputFcn',  @Place_Fields_OutputFcn, ...
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


% This function is created by GUIDE for every GUI. Just put here all
% the code that you want to be executed before the GUI is made visible. 
function Place_Fields_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Place_Fields (see VARARGIN)

% Choose default command line output for Place_Fields
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global SpikeTraceData
global SpikeMovieData

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText];
    end
    set(handles.TraceSelector,'String',TextTrace);
    set(handles.XPosTraceSelector, 'String', TextTrace);
    set(handles.YPosTraceSelector, 'String', TextTrace);
end

if ~isempty(SpikeMovieData)
    for i=1:length(SpikeMovieData)
        TextMovie{i}=[num2str(i),' - ',SpikeMovieData(i).Label.ListText];
    end
    set(handles.MovieSelector,'String',TextMovie);
end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.TraceSelector,'Value',Settings.TraceSelectorValue);
    set(handles.XPosTraceSelector,'Value',Settings.XPosTraceSelectorValue);
    set(handles.YPosTraceSelector,'Value',Settings.YPosTraceSelectorValue);
    set(handles.Sigma, 'String', Settings.SigmaString);
    set(handles.MovieSelector,'Value',Settings.MovieSelectorValue);
    set(handles.Calc1DPlaceFields,'Value',Settings.Calc1DPlaceFieldsValue);
end


% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.TraceSelectorString=get(handles.TraceSelector,'String');
Settings.TraceSelectorValue=get(handles.TraceSelector,'Value');
Settings.XPosTraceSelectorValue=get(handles.XPosTraceSelector,'Value');
Settings.YPosTraceSelectorValue=get(handles.YPosTraceSelector,'Value');
Settings.MovieSelectorValue=get(handles.MovieSelector,'Value');
Settings.SigmaString=get(handles.Sigma, 'String');
Settings.Calc1DPlaceFieldsValue=get(handles.Calc1DPlaceFields, 'Value');


% --- Outputs from this function are returned to the command line.
function varargout = Place_Fields_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


% 'ApplyApps' is the main function of your Apps. It is launched by the
% Main interface when using batch mode. 
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData
global SpikeImageData
global SpikeMovieData
global velocity
global allSpikeMap
global gWin thisSpikeLine xyTime spikeTime thisConvertedInd xTrace trInd

try
    % We turn the interface off for processing.
    InterfaceObj=findobj(handles.output,'Enable','on');
    set(InterfaceObj,'Enable','off');
    
    % get parameters from interface
    tracesToProcess=get(handles.TraceSelector, 'Value');
    xTrace=SpikeTraceData(get(handles.XPosTraceSelector, 'Value')).Trace;
    OneDfields=get(handles.Calc1DPlaceFields, 'Value');
    if ~OneDfields
        yTrace=SpikeTraceData(get(handles.YPosTraceSelector, 'Value')).Trace;
    end
    posUnits=SpikeTraceData(get(handles.XPosTraceSelector, 'Value')).Label.YLabel;
    xyTime=SpikeTraceData(get(handles.XPosTraceSelector, 'Value')).XVector;
    sigma=str2double(get(handles.Sigma, 'String'));
    if OneDfields
        allSpikeMap=zeros(length(tracesToProcess), ceil(max(xTrace)-min(xTrace)));
        velocity=[0, diff(xTrace)];
        v=sort(abs(velocity), 'ascend');
        maxVel=v(round(99/100*length(v)));
        velocityThresh=0.1*maxVel;
        xMin=min(xTrace)+1/12*(max(xTrace)-min(xTrace));
        xMax=max(xTrace)-1/12*(max(xTrace)-min(xTrace));
        gWin=fspecial('gaussian', [1, size(allSpikeMap,2)], sigma);
    else
        gWin=fspecial('gaussian', size(SpikeMovieData(movieSel).Movie(:,:,1)), sigma);
    end
    
    NumberImages=length(SpikeImageData);
    NumberTraces=length(SpikeTraceData);
    for trInd=1:length(tracesToProcess)
        thisTraceInd=tracesToProcess(trInd);
        thisTrace=SpikeTraceData(thisTraceInd).Trace;
        thisXVector=SpikeTraceData(thisTraceInd).XVector';
        if OneDfields
            thisSpikeLine=zeros(1, size(allSpikeMap,2));
        else
            movieSel=get(handles.MovieSelector, 'Value');
            thisSpikeImage=zeros(size(SpikeMovieData(movieSel).Movie(:,:,1)));
        end
        if max(thisTrace)>1
            error('Use binary event traces!')
        end
%         figure(10)
%                     subplot(311)
%             plot(thisXVector, thisTrace)
%             xlim([0 1000])
%         subplot(312)
%         hold off
%         plot(xyTime, xTrace)
%         xlim([0 1000])
%         hold all
        if sum(thisTrace)>3
            for spikeTime=thisXVector(logical(thisTrace))
                if spikeTime<max(xyTime)
                    [~, thisConvertedInd]=min(abs(xyTime-spikeTime));
%                     plot(xyTime(thisConvertedInd), xTrace(thisConvertedInd), '*')
%                     xlim([0 1000])
                    %waitforbuttonpress()
                    velocity(thisConvertedInd)
                    if OneDfields && abs(velocity(thisConvertedInd))>velocityThresh && xTrace(thisConvertedInd)<xMax && xTrace(thisConvertedInd)>xMin && velocity(thisConvertedInd)<0
                        thisSpikeLine(round(xTrace(thisConvertedInd)-min(xTrace)))=1;
                    elseif ~OneDfields
                        thisSpikeImage(round(yTrace(thisConvertedInd)), round(xTrace(thisConvertedInd)))=1;
                    end
                end
            end
%             figure(10);
%             subplot(311)
%             plot(thisXVector, thisTrace)
%             xlim([0 1000])
%             subplot(313)
%             plot(thisSpikeLine)
%             waitforbuttonpress()
        end
        if ~OneDfields
            SpikeImageData(NumberImages+trInd).Image=conv2(thisSpikeImage, gWin, 'same');
            SpikeImageData(NumberImages+trInd).Label.ListText=['spike map ' SpikeTraceData(thisTraceInd).Label.ListText];
            SpikeImageData(NumberImages+trInd).Label.YLabel=posUnits;
            SpikeImageData(NumberImages+trInd).Label.XLabel=posUnits;
        else
            allSpikeMap(trInd,:)=conv(thisSpikeLine, gWin, 'same');
        end
    end
    if OneDfields
        xInds=repmat(1:size(allSpikeMap,2), size(allSpikeMap,1),1);
        centroids=sum(allSpikeMap.*xInds,2)./sum(allSpikeMap,2);
        [~, sortedInds]=sort(centroids);
        SpikeImageData(NumberImages+1).Image=allSpikeMap(sortedInds,:);
        SpikeImageData(NumberImages+1).Label.ListText='spike map 1D';
        SpikeImageData(NumberImages+1).Label.YLabel='cell';
        SpikeImageData(NumberImages+1).Label.XLabel=posUnits;
    end
        
    
    % We turn back on the interface
    set(InterfaceObj,'Enable','on');
    
    ValidateValues_Callback(hObject, eventdata, handles);
    
% In case of errors
catch errorObj
    % We turn back on the interface
    set(InterfaceObj,'Enable','on');
    
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end


% 'ValidateValues' is executed in the end to trigger the end of your Apps and
% check all unneeded windows are closed.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% We give back control to the Main interface.
uiresume;


% This function opens the help that is written in the header of this M file.
function OpenHelp_Callback(hObject, eventdata, handles)
% hObject    handle to OpenHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrentMfilePath = mfilename('fullpath');
[PathToM, name, ext] = fileparts(CurrentMfilePath);
eval(['doc ',name]);



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

% --- Executes on selection change in XPosTraceSelector.
function XPosTraceSelector_Callback(hObject, eventdata, handles)
% hObject    handle to XPosTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns XPosTraceSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from XPosTraceSelector


% --- Executes during object creation, after setting all properties.
function XPosTraceSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XPosTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Sigma_Callback(hObject, eventdata, handles)
% hObject    handle to Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sigma as text
%        str2double(get(hObject,'String')) returns contents of Sigma as a double


% --- Executes during object creation, after setting all properties.
function Sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in YPosTraceSelector.
function YPosTraceSelector_Callback(hObject, eventdata, handles)
% hObject    handle to YPosTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns YPosTraceSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from YPosTraceSelector


% --- Executes during object creation, after setting all properties.
function YPosTraceSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YPosTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MovieSelector.
function MovieSelector_Callback(hObject, eventdata, handles)
% hObject    handle to MovieSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MovieSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MovieSelector


% --- Executes during object creation, after setting all properties.
function MovieSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MovieSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calc1DPlaceFields.
function Calc1DPlaceFields_Callback(hObject, eventdata, handles)
% hObject    handle to Calc1DPlaceFields (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Calc1DPlaceFields
if (get(handles.Calc1DPlaceFields,'Value')==1)
    set(handles.YPosTraceSelector,'Enable','off');
else
    set(handles.YPosTraceSelector,'Enable','on');
end