function varargout = Find_Coding_Traces_MI_Shuffle_Test(varargin)
% FIND_CODING_TRACES_MI_SHUFFLE_TEST This App aligns one or more traces to points given in the
% binary alignment trace. Any point in the alignment trace with a 1 will be
% an alignment point, and all trace fragments surrounding an alignment
% point will be laid on top of one another. Useful for traces which contain
% multiple repeats of the same experiment, cue, or action.
%
% Output will save as many traces as are input; each will be of length (#
% frames before) + 1 + (# frames after), as set in the GUI.
%
% Created by Lacey Kitch in 2012

% Edit the above text to modify the response to help Find_Coding_Traces_MI_Shuffle_Test

% Last Modified by GUIDE v2.5 16-Jun-2012 15:42:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Find_Coding_Traces_MI_Shuffle_Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Find_Coding_Traces_MI_Shuffle_Test_OutputFcn, ...
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
function Find_Coding_Traces_MI_Shuffle_Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Find_Coding_Traces_MI_Shuffle_Test (see VARARGIN)

% Choose default command line output for Find_Coding_Traces_MI_Shuffle_Test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global SpikeTraceData

if ~isempty(SpikeTraceData)
    for i=1:length(SpikeTraceData)
        TextTrace{i}=[num2str(i),' - ',SpikeTraceData(i).Label.ListText]; %#ok<AGROW>
    end
    set(handles.XTraceSelector,'String',TextTrace);
    set(handles.YTraceSelector, 'String', TextTrace);
end

if (length(varargin)>1)
    Settings=varargin{2};
    set(handles.XTraceSelector,'Value',Settings.XTraceSelectorValue);
    set(handles.YTraceSelector,'Value',Settings.YTraceSelectorValue);
    set(handles.PValue, 'String', Settings.PValueString);
    set(handles.NumberShuffles, 'String', Settings.NumberShufflesString);
    set(handles.NumberYValues, 'String', Settings.NumberYValuesString);
end


% This function send the current settings to the main interface for saving
% purposes and for the batch mode
function Settings=GetSettings(hObject)
handles=guidata(hObject);
Settings.XTraceSelectorValue=get(handles.XTraceSelector,'Value');
Settings.YTraceSelectorValue=get(handles.YTraceSelector,'Value');
Settings.PValueString=get(handles.PValue, 'String');
Settings.NumberShufflesString=get(handles.NumberShuffles, 'String');
Settings.NumberYValuesString=get(handles.NumberYValues, 'String');



% --- Outputs from this function are returned to the command line.
function varargout = Find_Coding_Traces_MI_Shuffle_Test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


% 'ApplyApps' is the main function of your Apps. It is launched by the
% Main interface when using batch mode. 
function ApplyApps_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SpikeTraceData
global X
global Y
global numXtraces
global numValuesY
global theseX
global yVal
global logProbX0givenY
global logProbX1givenY
global logProbY
global logProbX0
global logProbX1
global pVals
global shufX
global shufInds
global n
global shufMIvals
global MI
global yTrace

try
    % We turn the interface off for processing.
    InterfaceObj=findobj(handles.output,'Enable','on');
    set(InterfaceObj,'Enable','off');
    
    % get parameters from interface
    xTraceInds=get(handles.XTraceSelector, 'Value');
    numXtraces=length(xTraceInds);
    yTraceInd=get(handles.YTraceSelector, 'Value');
    yTrace=SpikeTraceData(yTraceInd).Trace;
    numValuesY=str2double(get(handles.NumberYValues, 'String'));
    numShufs=str2double(get(handles.NumberShuffles, 'String'));
    numTraces=length(SpikeTraceData);
    numXtraces=length(xTraceInds);
    maxPVal=str2double(get(handles.PValue, 'String'));

    shufMIvals=zeros(numShufs, numXtraces);
    
    h=waitbar(0, 'calculating shuffled MI...');

    sigma=3;%str2double(get(handles.Sigma, 'String'));
    N=10*sigma;

    % construct logical event matrix, X
    numPoints=length(SpikeTraceData(xTraceInds(1)).Trace);
    X=false(numXtraces, numPoints);
    for i=1:numXtraces
        traceInd=xTraceInds(i);
        if length(SpikeTraceData(traceInd).Trace)~=numPoints
            error('X Traces are not same length')
        else
            X(i,:)=logical(SpikeTraceData(traceInd).Trace);
        end
    end
    
    % smoothX for MI calculation
    smoothX=false(size(X));
    for n=1:size(X,1)
        smoothX(n,:)=logical(conv(single(X(n,:)), gausswin(N,5/sigma), 'same'));
    end
    
    % construct discrete Y
    if length(yTrace)~=numPoints
        msgbox('Warning: Y trace not same length as X traces. Program takes nearest Y value at each point in time of X trace, rather than resampling.')
        oldYtrace=yTrace;
        oldYtime=SpikeTraceData(yTraceInd).XVector;
        xTime=SpikeTraceData(xTraceInds(1)).XVector;
        yTrace=zeros(size(SpikeTraceData(xTraceInds(1)).Trace));
        for timeInd=1:numPoints
            [~, closestYtimeInd]=min(abs(oldYtime-xTime(timeInd)));
            yTrace(timeInd)=oldYtrace(closestYtimeInd);
        end
        
    else
        % divide y to have numValuesY discrete values, range 0 to
        % numValuesY-1
        Y=round((yTrace-min(yTrace))*(numValuesY-1)/(max(yTrace)-min(yTrace)));
        
    end
    
    %%%%% calculate actual MI
    % calculate probabilities
    logProbX0=log(sum(1-smoothX,2))-log(numPoints);
    logProbX1=log(sum(smoothX,2))-log(numPoints);
    logProbY=zeros(1,numValuesY);
    logProbX0givenY=zeros(numXtraces, numValuesY);
    logProbX1givenY=zeros(numXtraces, numValuesY);
    for yVal=0:numValuesY-1
        logProbY(yVal+1)=log(sum(Y==yVal))-log(numPoints);
        theseX=smoothX(:,Y==yVal);
        logProbX0givenY(:,yVal+1)=log(sum(1-theseX,2)+1)-log(size(theseX,2)+1);
        logProbX1givenY(:, yVal+1)=log(sum(theseX,2)+1)-log(size(theseX,2)+1);
    end
    logProbX0andY=log(exp(logProbX0givenY).*repmat(exp(logProbY),numXtraces,1));
    logProbX1andY=log(exp(logProbX1givenY).*repmat(exp(logProbY),numXtraces,1));
    
    % calculate MI
    MI=sum(exp(logProbX0andY).*(logProbX0andY-repmat(logProbX0,1,numValuesY)-repmat(logProbY,numXtraces,1)),2)+...
        sum(exp(logProbX1andY).*(logProbX1andY-repmat(logProbX1,1,numValuesY)-repmat(logProbY,numXtraces,1)),2); 
    

    %%%%%% calculate shuffled MI
    shufX=false(size(X));
    for shufInd=1:numShufs 
        if mod(shufInd, round(numShufs/50))==0
            waitbar(shufInd/numShufs, h)
        end
        % shuffle cells
        for n=1:numXtraces
            shufX(n,:)=X(n,randperm(numPoints));
        end

        % smooth traces and binarize
        for n=1:size(shufX,1)
            shufX(n,:)=logical(conv(single(shufX(n,:)), gausswin(N,5/sigma), 'same'));
        end

        % calculate probabilities
        logProbX0=log(sum(1-shufX,2))-log(numPoints);
        logProbX1=log(sum(shufX,2))-log(numPoints);
        logProbY=zeros(1,numValuesY);
        logProbX0givenY=zeros(numXtraces, numValuesY);
        logProbX1givenY=zeros(numXtraces, numValuesY);
        for yVal=0:numValuesY-1
            logProbY(yVal+1)=log(sum(Y==yVal))-log(numPoints);
            theseX=shufX(:,Y==yVal);
            logProbX0givenY(:,yVal+1)=log(sum(1-theseX,2)+1)-log(size(theseX,2)+1);
            logProbX1givenY(:, yVal+1)=log(sum(theseX,2)+1)-log(size(theseX,2)+1);
        end
        logProbX0andY=log(exp(logProbX0givenY).*repmat(exp(logProbY),numXtraces,1));
        logProbX1andY=log(exp(logProbX1givenY).*repmat(exp(logProbY),numXtraces,1));

        % calculate MI
        shufMIvals(shufInd, :)=sum(exp(logProbX0andY).*(logProbX0andY-repmat(logProbX0,1,numValuesY)-repmat(logProbY,numXtraces,1)),2)+...
            sum(exp(logProbX1andY).*(logProbX1andY-repmat(logProbX1,1,numValuesY)-repmat(logProbY,numXtraces,1)),2); 
    end
    
    % get p-vals
    pVals=zeros(numXtraces,1);
    for trInd=1:numXtraces
        pVals(trInd)=sum(shufMIvals(:,trInd)>=MI(trInd))/numShufs;
    end

    % Save p values in a new trace
    SpikeTraceData(numTraces+1).XVector=1:numXtraces;
    SpikeTraceData(numTraces+1).Trace=pVals;
    SpikeTraceData(numTraces+1).DataSize=size(pVals);
    SpikeTraceData(numTraces+1).Label.XLabel='trace number';
    SpikeTraceData(numTraces+1).Label.YLabel='p';
    SpikeTraceData(numTraces+1).Label.ListText='p values';
    
    % Save significant MI traces as new traces
    codingTraceInds=xTraceInds(find(pVals<=maxPVal));
    for i=1:length(codingTraceInds)
        origTraceInd=codingTraceInds(i);
        SpikeTraceData(numTraces+1+i)=SpikeTraceData(origTraceInd);
        SpikeTraceData(numTraces+1+i).Label.ListText=['pass MI shuf ', SpikeTraceData(origTraceInd).Label.ListText];
    end
    
    delete(h)
    
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



% --- Executes on selection change in XtraceIndselector.
function XTraceSelector_Callback(hObject, eventdata, handles)
% hObject    handle to XtraceIndselector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns XtraceIndselector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from XtraceIndselector


% --- Executes during object creation, after setting all properties.
function XTraceSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XtraceIndselector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in YTraceSelector.
function YTraceSelector_Callback(hObject, eventdata, handles)
% hObject    handle to YTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns YTraceSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from YTraceSelector


% --- Executes during object creation, after setting all properties.
function YTraceSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YTraceSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function PValue_Callback(hObject, eventdata, handles)
% hObject    handle to PValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PValue as text
%        str2double(get(hObject,'String')) returns contents of PValue as a double


% --- Executes during object creation, after setting all properties.
function PValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumberShuffles_Callback(hObject, eventdata, handles)
% hObject    handle to NumberShuffles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberShuffles as text
%        str2double(get(hObject,'String')) returns contents of NumberShuffles as a double


% --- Executes during object creation, after setting all properties.
function NumberShuffles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberShuffles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumberYValues_Callback(hObject, eventdata, handles)
% hObject    handle to NumberYValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberYValues as text
%        str2double(get(hObject,'String')) returns contents of NumberYValues as a double


% --- Executes during object creation, after setting all properties.
function NumberYValues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberYValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
