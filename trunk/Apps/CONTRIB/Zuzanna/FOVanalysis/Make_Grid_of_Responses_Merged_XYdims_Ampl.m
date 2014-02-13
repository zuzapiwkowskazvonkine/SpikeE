function varargout = Make_Grid_of_Responses_Merged_XYdims_Ampl(varargin)
% MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL M-file for Make_Grid_of_Responses_Merged_XYdims_Ampl.fig
%      MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL, by itself, creates a new MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL or raises the existing
%      singleton*.
%
%      H = MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL returns the handle to a new MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL or the handle to
%      the existing singleton*.
%
%      MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL.M with the given input arguments.
%
%      MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL('Property','Value',...) creates a new MAKE_GRID_OF_RESPONSES_MERGED_XYDIMS_AMPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Make_Grid_of_Responses_Merged_XYdims_Ampl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Make_Grid_of_Responses_Merged_XYdims_Ampl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Make_Grid_of_Responses_Merged_XYdims_Ampl

% Last Modified by GUIDE v2.5 19-Nov-2013 17:48:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Make_Grid_of_Responses_Merged_XYdims_Ampl_OpeningFcn, ...
                   'gui_OutputFcn',  @Make_Grid_of_Responses_Merged_XYdims_Ampl_OutputFcn, ...
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


% --- Executes just before Make_Grid_of_Responses_Merged_XYdims_Ampl is made visible.
function Make_Grid_of_Responses_Merged_XYdims_Ampl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Make_Grid_of_Responses_Merged_XYdims_Ampl (see VARARGIN)

% Choose default command line output for Make_Grid_of_Responses_Merged_XYdims_Ampl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Make_Grid_of_Responses_Merged_XYdims_Ampl wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SpikeImageData;
global DLPstim;
global SpikeTraceData;

set(handles.SavingPath,'String','C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_DCN\Other\FOVstest');
handles.Path='C:\Users\Zuzanna\Documents\DataStanford2013\Analysis\Surprise_DCN\Other\FOVstest';

   if ~isempty(SpikeImageData)
        for i=1:length(SpikeImageData)
            TextImage{i}=['Image ',num2str(i)];
        end
        set(handles.Image_Selector,'String',TextImage);
   end
    
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
   
  if ~isempty(DLPstim)
    set(handles.Xoffset,'String',DLPstim.SaveParam.Xoffset);
    set(handles.Yoffset,'String',DLPstim.SaveParam.Yoffset);
    set(handles.Scale,'String',DLPstim.SaveParam.Scale);   
        
    else
        set(handles.DLPNotLoaded,'Value',1);
    end

if (length(varargin)>1)
    Settings=varargin{2};

    set(handles.Xoffset,'String',Settings.XoffsetString);
    set(handles.Yoffset,'String',Settings.YoffsetString);
    set(handles.Scale,'String',Settings.ScaleString);
    
    set(handles.DLPNotLoaded,'Value',Settings.DLPNotLoadedValue); 
    set(handles.DLPtoImage,'Value',Settings.DLPtoImageValue); 
    set(handles.Imageto2p,'Value',Settings.Imageto2pValue); 
    
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
function varargout = Make_Grid_of_Responses_Merged_XYdims_Ampl_OutputFcn(hObject, eventdata, handles) 
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
Settings.ScaleString=get(handles.Scale,'String');

Settings.DLPtoImageValue=get(handles.DLPtoImage,'Value');
Settings.Imageto2pValue=get(handles.Imageto2p,'Value');
Settings.DLPNotLoadedValue=get(handles.DLPNotLoaded,'Value');

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

Settings.TraceStimDursString=get(handles.TraceStimDurs,'String');
Settings.TraceStimDursValue=get(handles.TraceStimDurs,'Value');


Settings.YsizetargetString= get(handles.Ysizetarget,'String');
Settings.XsizetargetString= get(handles.Xsizetarget,'String');


% --- Executes on button press in ApplyApps.
function ApplyApps_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyApps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SpikeImageData;
global DLPstim;
global SpikeTraceData;

ImagesToApply=get(handles.Image_Selector,'Value');

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

%%%%%%%%%%%%%

xoffset=str2double(get(handles.Xoffset,'String'));
yoffset=str2double(get(handles.Yoffset,'String'));
scale=str2double(get(handles.Scale,'String'));
NoDLP=str2double(get(handles.DLPNotLoaded,'Value'));

DLPtoimage=get(handles.DLPtoImage,'Value');
imageto2p=get(handles.Imageto2p,'Value');

%%%%%%%%%%%%

fovxloctrace=get(handles.FOVXlocTrace,'Value');
fovyloctrace=get(handles.FOVYlocTrace,'Value');
sfx=str2double(get(handles.SFX,'String'));
sfy=str2double(get(handles.SFY,'String'));

total_screenwidth=800; % <== change here if screen resolution changed
WidthScreen=round(total_screenwidth/scale); %square screen section, bigger square
HeightScreen=WidthScreen;

[sortint,sortint_ind]=sort(SpikeTraceData(intstrace).Trace);
oldint=0;

% arrays for accumulating data for multi-File plots:
Coords2p_Array={};
CoordsSign2p_Array={};
FOVimageArray={};
Resps_Array={};
Xshift=[];
Yshift=[];

FOVvec=zeros(2*length(ImagesToApply),1);
for i=ImagesToApply
st=SpikeImageData(i).Label.ListText;
f=sscanf(st,'%*1c %d');  %recover FOV nb from the labels of the FOV images
FOVvec(f)=i; %correspondance table to find the index in ImagesToApply corresponding to a given FOV nb.
end

% get max and min response amplitudes for color coding:
minresp=min(SpikeTraceData(respstrace).Trace);
maxresp=max(SpikeTraceData(respstrace).Trace);
%

% a first loop to determine the index of the last File of target
% xsizetarget && ysizetarget
% (needed for plotting purposes later)

for z=1:length(SpikeTraceData(nbtracestrace).Trace) % loop over Files (ie groups of PSTHs from one stimulus sequence)    
    k=sortint_ind(z); % when looping over Files, use the sorted indices so that neigboring Files have same intensities   
    if SpikeTraceData(xsizetrace).Trace(k)==xsizetarget &&  SpikeTraceData(ysizetrace).Trace(k)==ysizetarget
        lastfile=z;
    end
end


% then actual loop for plotting:
for z=1:length(SpikeTraceData(nbtracestrace).Trace) % loop over Files (ie groups of PSTHs from one stimulus sequence)
    
    k=sortint_ind(z); % when looping over Files, use the sorted indices so that neigboring Files have same intensities
    
    if SpikeTraceData(xsizetrace).Trace(k)==xsizetarget && SpikeTraceData(ysizetrace).Trace(k)==ysizetarget
        
        im_ind=SpikeTraceData(fovtrace).Trace(k);
        im=FOVvec(im_ind);
        
        
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
        
        % shifting params given the FOV's shift
        xshift=-sfx*SpikeTraceData(fovxloctrace).Trace(im_ind);       %in pxls
        yshift=-sfy*SpikeTraceData(fovyloctrace).Trace(im_ind);       %in pxls
        
        % global Coords
        % global Coords_2p
        
        Coords=grid_coords(WidthScreen,HeightScreen,casesize,xdim,ydim,xoffset,yoffset); % coords of the stimulus grid
        
        %get (x,y) indices of PSTHs eliciting significant response:
        
        % get indices of the PSTHs from this file (relative to 1, ie to first PSTH in Traces):
        tottraces=sum(SpikeTraceData(nbtracestrace).Trace(1:k-1));
        firstpsth=tottraces+1;
        lastpsth=tottraces+SpikeTraceData(nbtracestrace).Trace(k);
        inds=psth1trace+firstpsth-1:1:psth1trace+lastpsth-1;
        xs=[];
        ys=[];
        resps=[];
        
        % of those, get (X,Y) of PSTHs with significant responses:
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
                colorresp=max(1,floor(relresp*64)) %colormaps have 64 hues typically
                resps(end+1)=colorresp;
                
            end
        end
        
        if length(xs)>0
            Coords_Sign=rect_coords(WidthScreen,HeightScreen,casesize,xdim,ydim,xoffset,yoffset,xs,ys); % coords of grid rectangles eliciting significant response
        end
        
        % plot_grid(Coords);
        
        global Trans_mat_toImage
        global Trans_ori_toImage
        
        if DLPtoimage==1
            Coords_image=trans_coords(Coords,Trans_mat_toImage,Trans_ori_toImage);
            if length(xs)>0
                Coords_Sign_image=trans_coords(Coords_Sign,Trans_mat_toImage,Trans_ori_toImage);
            end
            % plot_grid(Coords_image);
        end
        
        global Trans_mat
        global Trans_ori
        
        if imageto2p==1
            Coords_2p=trans_coords(Coords_image,Trans_mat,Trans_ori);
            if length(xs)>0
                Coords_Sign_2p=trans_coords(Coords_Sign_image,Trans_mat,Trans_ori);
            end
            % plot_grid(Coords_2p);
        end
        
        %accumulate data in arrays or plot it depending on File specifics
        
        if int==oldint
            
            %accumulate data to plot in Arrays
            FOVimageArray{end+1}=SpikeImageData(im).Image;
            Coords2p_Array{end+1}=Coords_2p;
            
            if length(xs)>0
                CoordsSign2p_Array{end+1}=Coords_Sign_2p;
                Resps_Array{end+1}=resps;
            else
                CoordsSign2p_Array{end+1}=0;
                Resps_Array{end+1}=0;
            end
            Xshift(end+1)=xshift;
            Yshift(end+1)=yshift;
            
            if z==lastfile  % last File -> plot and save
                % get size of rectangle including all the FOVs:
                %size of 1 img (we assume here they all have the same size):
                xsize=size(FOVimageArray{1},2);
                ysize=size(FOVimageArray{1},1);
                xmin=min(Xshift);
                xmax=max(Xshift)+xsize;
                xtot=xmax-xmin+1;
                ymin=min(Yshift);
                ymax=max(Yshift)+ysize;
                ytot=ymax-ymin+1;
                xyns=ones(ytot,xtot);
                xyimg=zeros(ytot,xtot);
                
                
                for n=1:length(FOVimageArray) %get mean FOV image based on the ones in the Array
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+1;
                    xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+FOVimageArray{n};
                end
                meanFOV=xyimg./xyns;
                
                % plot that mean FOV image on new fig p
                p=figure;
                imagesc(meanFOV);
                axis equal;
                hold on;
                
                % plot the grids and the significant response rectangles
                for n=1:length(Coords2p_Array)
                    
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    
                    plot_grid_on_image_shift(Coords2p_Array{n},'w',p,xstart,ystart);
                    
                    
                    if CoordsSign2p_Array{n}~=0
                        plot_rect_on_image_shift(CoordsSign2p_Array{n},'r',p,xstart,ystart,Resps_Array{n}); 
                    end
                    
                end
                
                % save fig p
                fname=[handles.Path '\' 'Int' num2str(int) '_' num2str(intW) 'uW_Xsize' num2str(xsizetarget) '_Ysize' num2str(ysizetarget) '_' SpikeTraceData(inds(1)).Filename '.fig'];
                title(['Int ' num2str(int) '/' num2str(intW) ' uW, Xsize:' num2str(xsizetarget) ', Ysize:' num2str(ysizetarget)]);
                saveas(p,fname);
            end
            
            
        else
            % plot based on accumulated Arrays, and save resulting figure
            if oldint>0 % this condition excludes the first File
                
                % get size of rectangle including all the FOVs:
                %size of 1 img (we assume here they all have the same size):
                xsize=size(FOVimageArray{1},2);
                ysize=size(FOVimageArray{1},1);
                xmin=min(Xshift);
                xmax=max(Xshift)+xsize;
                xtot=xmax-xmin+1;
                ymin=min(Yshift);
                ymax=max(Yshift)+ysize;
                ytot=ymax-ymin+1;
                xyns=ones(ytot,xtot);
                xyimg=zeros(ytot,xtot);
                
                for n=1:length(FOVimageArray) %get mean FOV image based on the ones in the Array
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+1;
                    xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+FOVimageArray{n};
                end
                meanFOV=xyimg./xyns;
                
                % plot that mean FOV image on new fig p
                p=figure;
                imagesc(meanFOV);
                axis equal;
                hold on;
                
                %plot the grids and the significant response rectangles
                for n=1:length(Coords2p_Array)
                    
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    
                    plot_grid_on_image_shift(Coords2p_Array{n},'w',p,xstart,ystart);
                    if CoordsSign2p_Array{n}~=0
                        plot_rect_on_image_shift(CoordsSign2p_Array{n},'r',p,xstart,ystart,Resps_Array{n}); %%%%% NEED TO CHANGE COLOR HERE
                    end
                    
                end
                
                % save fig p
                fname=[handles.Path '\' 'Int' num2str(int) '_' num2str(intW) 'uW_Xsize' num2str(xsizetarget) '_Ysize' num2str(ysizetarget) '_' SpikeTraceData(inds(1)).Filename '.fig'];
                title(['Int ' num2str(int) '/' num2str(intW) ' uW, Xsize:' num2str(xsizetarget) ', Ysize:' num2str(ysizetarget)]);
                saveas(p,fname);
            end
            
            % now reset arrays
            Coords2p_Array={};
            CoordsSign2p_Array={};
            Resps_Array={};
            FOVimageArray={};
            Xshift=[];
            Yshift=[];
            
            % fill Arrays{1}
            
            FOVimageArray{end+1}=SpikeImageData(im).Image;
            Coords2p_Array{end+1}=Coords_2p;
            
            if length(xs)>0
                CoordsSign2p_Array{end+1}=Coords_Sign_2p;
                Resps_Array{end+1}=resps;
            else
                CoordsSign2p_Array{end+1}=0;
                Resps_Array{end+1}=0;
            end
            Xshift(end+1)=xshift;
            Yshift(end+1)=yshift;
            
            % plot if last File:
            if z==lastfile  % last File -> plot and save
                % get size of rectangle including all the FOVs:
                %size of 1 img (we assume here they all have the same size):
                xsize=size(FOVimageArray{1},2);
                ysize=size(FOVimageArray{1},1);
                xmin=min(Xshift);
                xmax=max(Xshift)+xsize;
                xtot=xmax-xmin+1;
                ymin=min(Yshift);
                ymax=max(Yshift)+ysize;
                ytot=ymax-ymin+1;
                xyns=ones(ytot,xtot);
                xyimg=zeros(ytot,xtot);
                'bla'
                
                for n=1:length(FOVimageArray) %get mean FOV image based on the ones in the Array
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyns(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+1;
                    xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)=xyimg(ystart:ystart+ysize-1,xstart:xstart+xsize-1)+FOVimageArray{n};
                end
                meanFOV=xyimg./xyns;
                
                % plot that mean FOV image on new fig p
                p=figure;
                imagesc(meanFOV);
                axis equal;
                hold on;
                
                % plot the grids and the significant response rectangles
                for n=1:length(Coords2p_Array)
                    
                    xstart=Xshift(n)-xmin+1;
                    ystart=Yshift(n)-ymin+1;
                    
                    plot_grid_on_image_shift(Coords2p_Array{n},'w',p,xstart,ystart);
                    if CoordsSign2p_Array{n}~=0
                        plot_rect_on_image_shift(CoordsSign2p_Array{n},'r',p,xstart,ystart,Resps_Array{n}); % COLOR CHANGE
                    end
                    
                end
                
                % save fig p
                fname=[handles.Path '\' 'Int' num2str(int) '_' num2str(intW) 'uW_Xsize' num2str(xsizetarget) '_Ysize' num2str(ysizetarget) '_' SpikeTraceData(inds(1)).Filename '.fig'];
                title(['Int ' num2str(int) '/' num2str(intW) ' uW, Xsize:' num2str(xsizetarget) ', Ysize:' num2str(ysizetarget)]);
                saveas(p,fname);
            end
        end
        
        
        oldint=int; %store Intensity for comparison in the next iteration of the loop over Files
        oldintW=intW;
        oldinds=inds; %store PSTH indices because needed for saving figure in subsequent iteration of loop
    end
end



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

function fig=plot_grid_on_image_shift(coords,scolor,fig,xshift,yshift)

if fig==0
fig=figure;
else
    figure(fig);
    hold on;
end
% imagesc(xshift,yshift,img);
% axis equal;
% hold on;

%shift coords
for i=1:2:size(coords,1)
    coords(i,:)=coords(i,:)+yshift;
    coords(i+1,:)=coords(i+1,:)+xshift;
end

for k=1:size(coords,2)
    plot([coords(2,k) coords(4,k)],[coords(1,k) coords(3,k)],scolor); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords(8,k) coords(4,k)],[coords(7,k) coords(3,k)],scolor); % BR -> TR corners
    hold on
    plot([coords(6,k) coords(8,k)],[coords(5,k) coords(7,k)],scolor); % BL-> BR corners
    hold on
    plot([coords(6,k) coords(2,k)],[coords(5,k) coords(1,k)],scolor); % BL -> TL corners
    hold on  
end

%%%%%%%%%%%%%%%%%%%%%%%%% plotting rectangles of chosen indices out of a grid:

%generates coordinates for chosen rectangles out of a grid
function coords=rect_coords(widthscreen,heightscreen,casesize,xdim,ydim,xoffset,yoffset,indx,indy) 

PixelCaseHeight=round(casesize*ydim);
PixelCaseWidth=round(casesize*xdim);

LeftMatrix=0:PixelCaseWidth:widthscreen;
TopMatrix=0:PixelCaseHeight:heightscreen;

XCoord=indx;
YCoord=indy;

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

function fig=plot_rect_on_image_shift(coords,scolor,fig,xshift,yshift,colorval) 
if strcmp(scolor,'r')
    lw=2;
else
    lw=0.5;
end

if fig==0
fig=figure;
else
    figure(fig);
    hold on;
end
% imagesc(img);
% axis equal;

%shift coords
for i=1:2:size(coords,1)
    coords(i,:)=coords(i,:)+yshift;
    coords(i+1,:)=coords(i+1,:)+xshift;
end

m=colormap('jet');


for k=1:size(coords,2)
    
    vcolor=m(colorval(k),:)
    
    plot([coords(2,k) coords(4,k)],[coords(1,k) coords(3,k)],'color',vcolor,'LineWidth',lw); % line between TL and TR corners (again, plot X as a function of Y and not the opposite)
    hold on
    plot([coords(8,k) coords(4,k)],[coords(7,k) coords(3,k)],'color',vcolor,'LineWidth',lw); % BR -> TR corners
    hold on
    plot([coords(6,k) coords(8,k)],[coords(5,k) coords(7,k)],'color',vcolor,'LineWidth',lw); % BL-> BR corners
    hold on
    plot([coords(6,k) coords(2,k)],[coords(5,k) coords(1,k)],'color',vcolor,'LineWidth',lw); % BL -> TL corners
    hold on  
end

colormap('default');



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
