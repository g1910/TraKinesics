function varargout = TraKinesics(varargin)
% TRAKINESICS MATLAB code for TraKinesics.fig
%      TRAKINESICS, by itself, creates a new TRAKINESICS or raises the existing
%      singleton*.
%
%      H = TRAKINESICS returns the handle to a new TRAKINESICS or the handle to
%      the existing singleton*.
%
%      TRAKINESICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAKINESICS.M with the given input arguments.
%
%      TRAKINESICS('Property','Value',...) creates a new TRAKINESICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TraKinesics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      Stop.  All inputs are passed to TraKinesics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TraKinesics

% Last Modified by GUIDE v2.5 17-Nov-2014 17:28:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TraKinesics_OpeningFcn, ...
                   'gui_OutputFcn',  @TraKinesics_OutputFcn, ...
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



% --- Executes just before TraKinesics is made visible.
function TraKinesics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TraKinesics (see VARARGIN)
% set(findobj(gcf,'type','axes'),'Visible','off');
movegui('northwest');
% Choose default command line output for TraKinesics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TraKinesics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TraKinesics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    import java.awt.Robot ;
    import java.awt.event.* ;
    handles.Start = 1;
    pointer = Robot() ;
    screenSize = get(0,'screensize');
    global vid
    vid=videoinput('winvideo',1,'YUY2_320x240');
    vidRes = get(vid,'VideoResolution')
    global hImage
    hImage = image(zeros(vidRes(1),vidRes(2),get(vid,'NumberOfBands')),'parent',handles.cam);
    preview(vid,hImage);
    
    hmedianfilt2 = vision.MedianFilter([10 10]);
    press = 0;
    detection = 0;
    drag = 0;
    global start
    start = 1;
    while start == 1
        frame = getsnapshot(vid);
        skin = findSkinYUY(frame);
        filtered = filterS(skin);
        filteredMs = step(hmedianfilt2, filtered);
%         cam = findobj('Tag','cam');
%         filterfig = findobj('Tag','filtered');
%         fingersfig = findobj('Tag','fingers');
       	imshow(filteredMs,'Parent',handles.filtered);
        
        [F Z]= detect(filteredMs);
        F = bwareaopen(F, 230);
        imshow(F,'Parent',handles.fingers);
        comp = bwconncomp(F);
        S = regionprops(comp,'Centroid');
        
        sizeS = size(S,1);
        c = [0 0];
        if sizeS == 0
            if press == 0 && detection == 1 && drag == 0
                press = 1;
                tic;
               
            end
            drag = 1;
            detection = 0;
        else if sizeS<=2
                for i=1:sizeS
                    c = c + S(i).Centroid;
                end
                c = c/sizeS
                if sizeS == 1
                    if detection == 1
                        if drag == 0
                            pointer.mousePress(InputEvent.BUTTON1_MASK) ;
                            coord = c;
                            drag = 1;
                        else
                            set(handles.status,'String','Drag On');
                            newcoord = c;
                            diff(1) = (coord(1) - newcoord(1));
                            diff(2) = (newcoord(2)-coord(2));
                            diff
                            MouseMove(screenSize, pointer, diff);
                            coord = newcoord;
                        end
                    end
                else
                    if press == 1
                        t = toc;
                        if(t<0.4)
                            pointer.mousePress(InputEvent.BUTTON1_MASK) ;
                            pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
                            pointer.mousePress(InputEvent.BUTTON1_MASK) ;
                        end
                        press = 0;
                        set(handles.status,'String','Double Click');
                    end
                    if drag == 1
                        pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
                        drag = 0;
                        set(handles.status,'String','Single Click');
                    end
                    if detection==0
                        coord = c;
                        detection = 1;
                        set(handles.status,'String','Mouse Motion');
                    else
                        newcoord = c;
                        diff(1) = (coord(1) - newcoord(1));
                        diff(2) = (newcoord(2)-coord(2));
                        diff
                        MouseMove(screenSize, pointer, diff);
                        coord = newcoord;
                    end
                end

            end
        end
        pause(0.2);
    end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global start
    start = false;
    global vid
    stoppreview(vid);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global start
    start = false;
    global vid
    global hImage
%     stoppreview(vid);
% Hint: delete(hObject) closes the figure
delete(hObject);
close all;
