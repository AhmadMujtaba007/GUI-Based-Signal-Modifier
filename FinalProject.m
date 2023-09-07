function varargout = FinalProject(varargin)
global player
% FINALPROJECT MATLAB code for FinalProject.fig
%      FINALPROJECT, by itself, creates a new FINALPROJECT or raises the existing
%      singleton*.
%
%      H = FINALPROJECT returns the handle to a new FINALPROJECT or the handle to
%      the existing singleton*.
%
%      FINALPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALPROJECT.M with the given input arguments.
%
%      FINALPROJECT('Property','Value',...) creates a new FINALPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalProject

% Last Modified by GUIDE v2.5 16-May-2022 18:56:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalProject_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalProject_OutputFcn, ...
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


% --- Executes just before FinalProject is made visible.
function FinalProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalProject (see VARARGIN)

% Choose default command line output for FinalProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%loding the audio file from the PC 
[filename, pathname] = uigetfile({'*.wav*'},'File Selector'); 
set( handles.text3, 'String', filename);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
audio1 = get(handles.text3, 'String');
[handles.y , handles.Fs ] = audioread(audio1)  ;  
player = audioplayer(handles.y,handles.Fs) ; 
handles.player = player  ; 
play(handles.player) ; 
guidata(hObject,handles) ; 



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
guidata(hObject,handles) ; 
pause(handles.player) ; 



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
guidata(hObject,handles) ; 
resume(handles.player)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 

audio1 = get(handles.text3, 'String');
[y , Fs ] = audioread(audio1)  ;
axes(handles.axes1) ;
steps = 1024 ; 
f = linspace(0,Fs ,steps) ; 
y_plot = abs(fft(y,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');


           


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton6.


% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider1 , 'value') ; 
set(handles.s1_value , 'String' , get(handles.slider1, 'value') ) ;  
filtered = val.*filter(LP , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new ;
play(handles.player) ;
axes(handles.axes2) ;
steps = 1024 ; 
f = linspace(0,200,steps) ; 
y_plot = abs(fft(filtered,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');
 guidata(hObject,handles) ; 

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider2 , 'value') ; 
set(handles.s2_value , 'String' , get(handles.slider2, 'value') ) ; 
filtered = val.*filter(BP1 , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new  ; 
play(handles.player) ; 
axes(handles.axes2) ;
steps = 1024 ; 
f = linspace(200,1000 ,steps) ; 
y_plot = abs(fft(filtered,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');
guidata(hObject,handles) ;


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
audio1 = get(handles.text3, 'String');
[y , Fs ] = audioread(audio1)  ;
axes(handles.axes1) ;
t = linspace(0,length(y)/Fs ,length(y)) ; 
plot(t,y) ; 
xlabel('Time') ; 
ylabel('Amplitude');
title('Time Domain Plot of Audio Signal ');


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider5 , 'value') ; 
set(handles.s5_value , 'String' , get(handles.slider5, 'value') ) ; 
filtered = val.*filter(BP4 , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new  ; 
play(handles.player) ; 
axes(handles.axes2) ;
steps = 1024 ; 
f = linspace(3000,4000  ,steps) ; 
y_plot = abs(fft(filtered,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');
guidata(hObject,handles) ;


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider3 , 'value') ; 
set(handles.s3_value , 'String' , get(handles.slider3, 'value') ) ; 
filtered = val.*filter(BP2 , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new  ; 
play(handles.player) ; 
axes(handles.axes2) ;
steps = 1024 ; 
f = linspace(1000,2000  ,steps) ; 
y_plot = abs(fft(filtered,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');
guidata(hObject,handles) ;

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider4 , 'value') ; 
set(handles.s4_value , 'String' , get(handles.slider4, 'value') ) ; 
filtered = val.*filter(BP3 , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new  ; 
play(handles.player) ; 
axes(handles.axes2) ;
steps = 1024 ; 
f = linspace(2000,3000  ,steps) ; 
y_plot = abs(fft(filtered,steps)) ;
plot( f(1:steps) , y_plot(1:steps) ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');
guidata(hObject,handles) ;

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider6 , 'value') ; 
set(handles.s6_value , 'String' , get(handles.slider6, 'value') ) ; 
filtered = val.*filter(HP , handles.y)  ;
player_new = audioplayer(filtered,handles.Fs) ; 
handles.player = player_new  ; 
play(handles.player) ; 
axes(handles.axes2) ;
steps = 1024 ; 

% f = linspace(4000,44100,steps) ; 
% y_plot = abs(fft(filtered,steps)) ;
% plot( f(1:steps) , y_plot(1:steps) ) ; 

y_plot = abs(fft(filtered)) ;
plot( y_plot ) ; 
xlabel('Frequency (Hz)') ; 
ylabel('Amplitude');
title('Frequency Domain Plot of Audio Signal ');

guidata(hObject,handles) ;

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
