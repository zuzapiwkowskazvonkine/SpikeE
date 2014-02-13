function varargout = Get_XY_ObjectiveLocations(varargin)
% GET_XY_OBJECTIVELOCATIONS M-file for Get_XY_ObjectiveLocations.fig
%      GET_XY_OBJECTIVELOCATIONS, by itself, creates a new GET_XY_OBJECTIVELOCATIONS or raises the existing
%      singleton*.
%
%      H = GET_XY_OBJECTIVELOCATIONS returns the handle to a new GET_XY_OBJECTIVELOCATIONS or the handle to
%      the existing singleton*.
%
%      GET_XY_OBJECTIVELOCATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GET_XY_OBJECTIVELOCATIONS.M with the given input arguments.
%
%      GET_XY_OBJECTIVELOCATIONS('Property','Value',...) creates a new GET_XY_OBJECTIVELOCATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Get_XY_ObjectiveLocations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Get_XY_ObjectiveLocations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Get_XY_ObjectiveLocations

% Last Modified by GUIDE v2.5 07-Jul-2013 10:44:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Get_XY_ObjectiveLocations_OpeningFcn, ...
                   'gui_OutputFcn',  @Get_XY_ObjectiveLocations_OutputFcn, ...
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


% --- Executes just before Get_XY_ObjectiveLocations is made visible.
function Get_XY_ObjectiveLocations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Get_XY_ObjectiveLocations (see VARARGIN)

% Choose default command line output for Get_XY_ObjectiveLocations
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Get_XY_ObjectiveLocations wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeImageData;
global DLPstim;

   if ~isempty(SpikeImageData)
        for i=1:length(SpikeImageData)
            TextImage{i}=['Image ',num2str(i)];
        end
        set(handles.Image_Selector,'String',TextImage);
    end
    
  if ~isempty(DLPstim)
    set(handles.Xoffset,'String',DLPstim.SaveParam.Xoffset);
    set(handles.Yoffset,'String',DLPstim.SaveParam.Yoffset);
    set(handles.Case_Size,'String',DLPstim.SaveParam.CaseHeight);
    set(handles.Xdim,'String',DLPstim.SaveParam.CaseX);
    set(handles.Ydim,'String',DLPstim.SaveParam.CaseY);
    set(handles.Scale,'String',DLPstim.SaveParam.Scale);   
        
    else
        set(handles.DLPNotLoaded,'Value',1);
    end

if (length(varargin)>1)
    Settings=varargin{2};
%     set(handles.TraceSelector_Stims,'String',Settings.TraceSelectorStimsString);
%     set(handles.TraceSelector_Stims,'Value',Settings.TraceSelectorStimsValue);
% %     set(handles.TraceSelector_Spikes,'String',Settings.TraceSelectorSpikesString);
%     set(handles.TraceSelector_Spikes,'Value',Settings.TraceSelectorSpikesValue);
    set(handles.Xoffset,'String',Settings.XoffsetString);
    set(handles.Yoffset,'String',Settings.YoffsetString);
    set(handles.Case_Size,'String',Settings.CaseSizeString);
    set(handles.Xdim,'String',Settings.XdimString);
    set(handles.Ydim,'String',Settings.YdimString);
    set(handles.Scale,'String',Settings.ScaleString);
    
    set(handles.DLPNotLoaded,'Value',Settings.DLPNotLoadedValue); 
    set(handles.DLPtoImage,'Value',Settings.DLPtoImageValue); 
    set(handles.Imageto2p,'Value',Settings.Imageto2pValue); 
    set(handles.PlotonImage,'Value',Settings.PlotonImageValue); 
    
    set(handles.SFX,'String',Settings.SFXString);
    set(handles.SFY,'String',Settings.SFYString);
    set(handles.Xextent,'String',Settings.XextentString);
    set(handles.Yextent,'String',Settings.YextentString);
    
end


% --- Outputs from this function are returned to the command line.
function varargout = Get_XY_ObjectiveLocations_OutputFcn(hObject, eventdata, handles) 
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
Settings.ImageSelectorString=get(handles.Image_Selector,'String');
Settings.ImageSelectorValue=get(handles.Image_Selector,'Value');

Settings.XoffsetString=get(handles.Xoffset,'String');
Settings.YoffsetString=get(handles.Yoffset,'String');
Settings.CaseSizeString=get(handles.Case_Size,'String');
Settings.XdimString=get(handles.Xdim,'String');
Settings.YdimString=get(handles.Ydim,'String');
Settings.ScaleString=get(handles.Scale,'String');

Settings.DLPtoImageValue=get(handles.DLPtoImage,'Value');
Settings.Imageto2pValue=get(handles.Imageto2p,'Value');
Settings.PlotonImageValue=get(handles.PlotonImage,'Value');
Settings.DLPNotLoadedValue=get(handles.DLPNotLoaded,'Value');

Settings.SFXString=get(handles.SFX,'String');
Settings.SFYString=get(handles.SFY,'String');
Settings.XextentString=get(handles.Xextent,'String');
Settings.YextentString=get(handles.Yextent,'String');



% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeImageData;
global DLPstim;

ImagesToApply=get(handles.Image_Selector,'Value');



%%%%%%%%%%%%%

xoffset=str2double(get(handles.Xoffset,'String'));
yoffset=str2double(get(handles.Yoffset,'String'));
ydim=str2double(get(handles.Ydim,'String')); 
casesize=str2double(get(handles.Case_Size,'String')); 
xdim=str2double(get(handles.Xdim,'String')); 
scale=str2double(get(handles.Scale,'String'));
NoDLP=str2double(get(handles.DLPNotLoaded,'Value'));

DLPtoimage=get(handles.DLPtoImage,'Value');
imageto2p=get(handles.Imageto2p,'Value');
plotonimage=get(handles.PlotonImage,'Value');

sfx=str2double(get(handles.SFX,'String'));   %in pxls/um
sfy=str2double(get(handles.SFY,'String'));   %in pxls/um
xextent=str2double(get(handles.Xextent,'String'));
yextent=str2double(get(handles.Yextent,'String'));

total_screenwidth=800; % <== change here if screen resolution changed
WidthScreen=round(total_screenwidth/scale); %square screen section, bigger square
HeightScreen=WidthScreen;

global Coords
global Coords_2p

Coords=grid_coords(WidthScreen,HeightScreen,casesize,xdim,ydim,xoffset,yoffset);


% plot_grid(Coords);

global Trans_mat_toImage
global Trans_ori_toImage
        
if DLPtoimage==1
Coords_image=trans_coords(Coords,Trans_mat_toImage,Trans_ori_toImage);
% plot_grid(Coords_image);
end


global Trans_mat
global Trans_ori

if imageto2p==1
Coords_2p=trans_coords(Coords_image,Trans_mat,Trans_ori);    
% plot_grid(Coords_2p);
end


[Xstep_Xaxis, Ystep_Xaxis]=get_XY_steps_Xaxis(Coords_2p); % X and Y steps (in pxls) to move grid from TL to TR corner
[Xstep_Yaxis, Ystep_Yaxis]=get_XY_steps_Yaxis(Coords_2p); % X and Y steps (in pxls) to move grid from TL to BL corner

%conversion to pxls:
Xstep_Xaxis_um=Xstep_Xaxis/sfx;
Xstep_Yaxis_um=Xstep_Yaxis/sfx;
Ystep_Xaxis_um=Ystep_Xaxis/sfy;
Ystep_Yaxis_um=Ystep_Yaxis/sfy;

set(handles.Xstep_Xaxis_um,'String',num2str(Xstep_Xaxis_um));
set(handles.Xstep_Yaxis_um,'String',num2str(Xstep_Yaxis_um));
set(handles.Ystep_Xaxis_um,'String',num2str(Ystep_Xaxis_um));
set(handles.Ystep_Yaxis_um,'String',num2str(Ystep_Yaxis_um));

Coords_2p_Shift_Xaxis=shift(Coords_2p,Xstep_Xaxis,Ystep_Xaxis);
Coords_2p_Shift_Yaxis=shift(Coords_2p,Xstep_Yaxis,Ystep_Yaxis);

if plotonimage==1
    
    for n=1:length(ImagesToApply)
        plot_grids_on_image(Coords_2p,Coords_2p_Shift_Xaxis,Coords_2p_Shift_Yaxis,SpikeImageData(ImagesToApply(n)).Image) %white, red, green grids
        
    end
    
end

global Objective_Locations_X
global Objective_Locations_Y
global X_Y
nbfieldsXobj=1+ceil(xextent/Ystep_Yaxis_um)
nbfieldsYobj=1+ceil(yextent/Xstep_Xaxis_um)

Objective_Locations_X=zeros(nbfieldsYobj,nbfieldsXobj);
Objective_Locations_Y=zeros(nbfieldsYobj,nbfieldsXobj);

for i=1:nbfieldsYobj        %Yobj axis is Xaxis (in 2p coords)
    for j=1:nbfieldsXobj        %Xobj axis is Yaxis (in 2 p coords)
   
    Objective_Locations_X(i,j)=(j-1)*Ystep_Yaxis_um+(i-1)*Ystep_Xaxis_um;
    Objective_Locations_Y(i,j)=(i-1)*Xstep_Xaxis_um+(j-1)*Xstep_Yaxis_um;   
    X_Y{i,j}=[Objective_Locations_X(i,j) Objective_Locations_Y(i,j)];  
    end
end

Objective_Locations_X=flipud(round(Objective_Locations_X));
Objective_Locations_Y=flipud(round(Objective_Locations_Y));

for i=1:nbfieldsYobj        
    for j=1:nbfieldsXobj      
        X_Y{i,j}=[Objective_Locations_X(i,j) Objective_Locations_Y(i,j)];
    end
end

% print Objective Locations from X_Y to text file:

fname=[date '-tiling.txt'];
fileid=fopen(fname,'w');

for i=1:nbfieldsYobj
    for j=1:nbfieldsXobj
        fprintf(fileid,'(%4d,%4d)\t',X_Y{i,j});
    end
    fprintf(fileid,'\r\n');
end

fclose(fileid);

guidata(hObject, handles);
ValidateValues_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%

%generates coordinates for all corners of a grid
function coords=grid_coords(widthscreen,heightscreen,casesize,xdim,ydim,xoffset,yoffset) 

PixelCaseHeight=round(casesize*ydim);
PixelCaseWidth=round(casesize*xdim);

NumberCaseX=floor((widthscreen)/PixelCaseWidth);
NumberCaseY=floor((heightscreen)/PixelCaseHeight);

% We check the limit in number of possible case
NumberCaseX=min(widthscreen,max(1,NumberCaseX));
NumberCaseY=min(heightscreen,max(1,NumberCaseY));

LeftMatrix=0:PixelCaseWidth:widthscreen;
TopMatrix=0:PixelCaseHeight:heightscreen;

KeptIndices=randperm(NumberCaseX*NumberCaseY);
[XCoord,YCoord]=ind2sub([NumberCaseX,NumberCaseY],KeptIndices);

% XCoord=1:1:length(LeftMatrix);
% XCoord=repmat(XCoord,1,length(XCoord));
% XCoord=sort(XCoord);
% YCoord=1:1:length(TopMatrix);
% YCoord=repmat(YCoord,1,length(YCoord));

coord_matrix(1,:)=LeftMatrix(XCoord)+xoffset;
coord_matrix(2,:)=TopMatrix(YCoord)+yoffset;
coord_matrix(3,:)=LeftMatrix(XCoord)+PixelCaseWidth+xoffset;
coord_matrix(4,:)=TopMatrix(YCoord)+PixelCaseHeight+yoffset;

%top left corner:
coords(1,:)=coord_matrix(1,:);   
coords(2,:)=coord_matrix(2,:);
%top right corner:
coords(3,:)=coord_matrix(3,:);
coords(4,:)=coord_matrix(2,:);
%bottom left corner:
coords(5,:)=coord_matrix(1,:);
coords(6,:)=coord_matrix(4,:);
%bottom right corner:
coords(7,:)=coord_matrix(3,:);
coords(8,:)=coord_matrix(4,:);
        
function new_coords=trans_coords(coords,trans_mat,trans_vec)

new_coords=zeros(size(coords));

for k=1:size(coords,2)
vec=trans_mat*[coords(1,k); coords(2,k)] + trans_vec;
new_coords(1,k)=vec(1); 
new_coords(2,k)=vec(2);

vec=trans_mat*[coords(3,k); coords(4,k)] + trans_vec;
new_coords(3,k)=vec(1); 
new_coords(4,k)=vec(2);

vec=trans_mat*[coords(5,k); coords(6,k)] + trans_vec;
new_coords(5,k)=vec(1); 
new_coords(6,k)=vec(2);

vec=trans_mat*[coords(7,k); coords(8,k)] + trans_vec;
new_coords(7,k)=vec(1); 
new_coords(8,k)=vec(2);

end

function plot_grid(coords)
figure;
for i=1:2:7
    plot(coords(i,:),coords(i+1,:),'k.')
    hold on
    axis([min(min(coords))-10 max(max(coords))+10 min(min(coords))-10 max(max(coords))+10])
end

function plot_grid_on_image(coords,img)
% figure;
% imagesc(img);
% axis equal;
% hold on;
% for i=1:2:7
%     plot(coords(i+1,:),coords(i,:),'w.')    %the Y in the 2p image/coords system are the colums in fact, ie the x-axis of matlab plotting, so need to do plot(Y,X) 
%     hold on
% end

%same but with lines instead of dots:
figure;
imagesc(img);
axis equal;
hold on;

for k=1:size(coords,2)
    plot([coords(2,k) coords(4,k)],[coords(1,k) coords(3,k)],'w'); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords(8,k) coords(4,k)],[coords(7,k) coords(3,k)],'w'); % BR -> TR corners
    hold on
    plot([coords(6,k) coords(8,k)],[coords(5,k) coords(7,k)],'w'); % BL-> BR corners
    hold on
    plot([coords(6,k) coords(2,k)],[coords(5,k) coords(1,k)],'w'); % BL -> TL corners
    hold on  
end

function plot_grids_on_image(coords,coords2,coords3,img)
% figure;
% imagesc(img);
% axis equal;
% hold on;
% for i=1:2:7
%     plot(coords(i+1,:),coords(i,:),'w.')    %the Y in the 2p image/coords system are the colums in fact, ie the x-axis of matlab plotting, so need to do plot(Y,X) 
%     hold on
% end

%same but with lines instead of dots:
figure;
imagesc(img);
axis equal;
hold on;

for k=1:size(coords,2)
    plot([coords(2,k) coords(4,k)],[coords(1,k) coords(3,k)],'w'); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords(8,k) coords(4,k)],[coords(7,k) coords(3,k)],'w'); % BR -> TR corners
    hold on
    plot([coords(6,k) coords(8,k)],[coords(5,k) coords(7,k)],'w'); % BL-> BR corners
    hold on
    plot([coords(6,k) coords(2,k)],[coords(5,k) coords(1,k)],'w'); % BL -> TL corners
    hold on  
end

for k=1:size(coords2,2)
    plot([coords2(2,k) coords2(4,k)],[coords2(1,k) coords2(3,k)],'r'); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords2(8,k) coords2(4,k)],[coords2(7,k) coords2(3,k)],'r'); % BR -> TR corners
    hold on
    plot([coords2(6,k) coords2(8,k)],[coords2(5,k) coords2(7,k)],'r'); % BL-> BR corners
    hold on
    plot([coords2(6,k) coords2(2,k)],[coords2(5,k) coords2(1,k)],'r'); % BL -> TL corners
    hold on  
end

for k=1:size(coords3,2)
    plot([coords3(2,k) coords3(4,k)],[coords3(1,k) coords3(3,k)],'g'); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords3(8,k) coords3(4,k)],[coords3(7,k) coords3(3,k)],'g'); % BR -> TR corners
    hold on
    plot([coords3(6,k) coords3(8,k)],[coords3(5,k) coords3(7,k)],'g'); % BL-> BR corners
    hold on
    plot([coords3(6,k) coords3(2,k)],[coords3(5,k) coords3(1,k)],'g'); % BL -> TL corners
    hold on  
end


function [Xstep,Ystep]=get_XY_steps_Xaxis(coords)

k=1; %we assume 1 big square is always used for this App for simplicity

%TR-TL corner
Xstep=coords(3,k)-coords(1,k);
Ystep=coords(4,k)-coords(2,k);

function [Xstep,Ystep]=get_XY_steps_Yaxis(coords)

k=1; %we assume 1 big square is always used for this App for simplicity

%BL-TL corner
Xstep=coords(5,k)-coords(1,k);
Ystep=coords(6,k)-coords(2,k);



function shifted_coords=shift(coords,xstep,ystep)

k=1; %we assume 1 big square is always used for this App for simplicity

shifted_coords(1,k)=coords(1,k)+xstep;
shifted_coords(3,k)=coords(3,k)+xstep;
shifted_coords(5,k)=coords(5,k)+xstep;
shifted_coords(7,k)=coords(7,k)+xstep;

shifted_coords(2,k)=coords(2,k)+ystep;
shifted_coords(4,k)=coords(4,k)+ystep;
shifted_coords(6,k)=coords(6,k)+ystep;
shifted_coords(8,k)=coords(8,k)+ystep;



% --- Executes on button press in ValidateValues.
function ValidateValues_Callback(hObject, eventdata, handles)
% hObject    handle to ValidateValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume;


function Xoffset_Callback(hObject, eventdata, handles)
% hObject    handle to Xoffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xoffset as text
%        str2double(get(hObject,'String')) returns contents of Xoffset as a double


% --- Executes during object creation, after setting all properties.
function Xoffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xoffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Yoffset_Callback(hObject, eventdata, handles)
% hObject    handle to Yoffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yoffset as text
%        str2double(get(hObject,'String')) returns contents of Yoffset as a double


% --- Executes during object creation, after setting all properties.
function Yoffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yoffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Case_Size_Callback(hObject, eventdata, handles)
% hObject    handle to Case_Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Case_Size as text
%        str2double(get(hObject,'String')) returns contents of Case_Size as a double


% --- Executes during object creation, after setting all properties.
function Case_Size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Case_Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xdim_Callback(hObject, eventdata, handles)
% hObject    handle to Xdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xdim as text
%        str2double(get(hObject,'String')) returns contents of Xdim as a double


% --- Executes during object creation, after setting all properties.
function Xdim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Ydim_Callback(hObject, eventdata, handles)
% hObject    handle to Ydim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ydim as text
%        str2double(get(hObject,'String')) returns contents of Ydim as a double


% --- Executes during object creation, after setting all properties.
function Ydim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ydim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DLPNotLoaded.
function DLPNotLoaded_Callback(hObject, eventdata, handles)
% hObject    handle to DLPNotLoaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DLPNotLoaded



function Scale_Callback(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Scale as text
%        str2double(get(hObject,'String')) returns contents of Scale as a double


% --- Executes during object creation, after setting all properties.
function Scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DLPtoImage.
function DLPtoImage_Callback(hObject, eventdata, handles)
% hObject    handle to DLPtoImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DLPtoImage


% --- Executes on button press in Imageto2p.
function Imageto2p_Callback(hObject, eventdata, handles)
% hObject    handle to Imageto2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Imageto2p


% --- Executes on button press in PlotonImage.
function PlotonImage_Callback(hObject, eventdata, handles)
% hObject    handle to PlotonImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotonImage


% --- Executes on selection change in Image_Selector.
function Image_Selector_Callback(hObject, eventdata, handles)
% hObject    handle to Image_Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Image_Selector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Image_Selector


% --- Executes during object creation, after setting all properties.
function Image_Selector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Image_Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function Xstep_Xaxis_um_Callback(hObject, eventdata, handles)
% hObject    handle to Xstep_Xaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xstep_Xaxis_um as text
%        str2double(get(hObject,'String')) returns contents of Xstep_Xaxis_um as a double


% --- Executes during object creation, after setting all properties.
function Xstep_Xaxis_um_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xstep_Xaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xstep_Yaxis_um_Callback(hObject, eventdata, handles)
% hObject    handle to Xstep_Yaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xstep_Yaxis_um as text
%        str2double(get(hObject,'String')) returns contents of Xstep_Yaxis_um as a double


% --- Executes during object creation, after setting all properties.
function Xstep_Yaxis_um_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xstep_Yaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ystep_Xaxis_um_Callback(hObject, eventdata, handles)
% hObject    handle to Ystep_Xaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ystep_Xaxis_um as text
%        str2double(get(hObject,'String')) returns contents of Ystep_Xaxis_um as a double


% --- Executes during object creation, after setting all properties.
function Ystep_Xaxis_um_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ystep_Xaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ystep_Yaxis_um_Callback(hObject, eventdata, handles)
% hObject    handle to Ystep_Yaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ystep_Yaxis_um as text
%        str2double(get(hObject,'String')) returns contents of Ystep_Yaxis_um as a double


% --- Executes during object creation, after setting all properties.
function Ystep_Yaxis_um_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ystep_Yaxis_um (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xextent_Callback(hObject, eventdata, handles)
% hObject    handle to Xextent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xextent as text
%        str2double(get(hObject,'String')) returns contents of Xextent as a double


% --- Executes during object creation, after setting all properties.
function Xextent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xextent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yextent_Callback(hObject, eventdata, handles)
% hObject    handle to Yextent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yextent as text
%        str2double(get(hObject,'String')) returns contents of Yextent as a double


% --- Executes during object creation, after setting all properties.
function Yextent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yextent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
