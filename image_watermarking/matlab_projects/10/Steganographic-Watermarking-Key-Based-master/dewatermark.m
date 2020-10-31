function varargout = dewatermark(varargin)
% DEWATERMARK M-file for dewatermark.fig
%      DEWATERMARK, by itself, creates a new DEWATERMARK or raises the existing
%      singleton*.
%
%      H = DEWATERMARK returns the handle to a new DEWATERMARK or the handle to
%      the existing singleton*.
%
%      DEWATERMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEWATERMARK.M with the given input arguments.
%
%      DEWATERMARK('Property','Value',...) creates a new DEWATERMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dewatermark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dewatermark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dewatermark

% Last Modified by GUIDE v2.5 17-Mar-2016 10:56:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dewatermark_OpeningFcn, ...
                   'gui_OutputFcn',  @dewatermark_OutputFcn, ...
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


% --- Executes just before dewatermark is made visible.
function dewatermark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dewatermark (see VARARGIN)

% Choose default command line output for dewatermark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global key_d        %define a global variable to be used for any key
if isempty(key_d)   %Check if the global variables already initialized
key_d=0;            %Initialize to 0
global type         %define a global variable for the type of watermark
type=0;             %set to 0 (type: Text)
end
% UIWAIT makes dewatermark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dewatermark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit3,'String','Decrypting...');                         %Inform you that the operation of dewatermarking has started
img=get(handles.edit1,'String');                                        %acquire the name or path of the image
if isempty(img)                                                         %Check if it is empty
    set(handles.edit3,'String','No file specified image!');    %Notified the absence of the image name
    return                                                              %end execution
end
global key_d                                                            %Using the global variable key_d
global type                                                             %Using the global variable type
st='';                                                                  %I create a container for the watermark
if key_d==0                                                             %If you do not want to use any key:
    if type==0
        st=dewatermark_k(imread(img));                                  %Calling the function dewatermarking_k without key
    else
        img_logo=dewatermark_img(imread(img));                          %Calling the function dewatermarking_img without key
    end
else                                                                    %Otherwise:
    if type==0
        st=dewatermark_k(imread(img),str2num(get(handles.edit2,'String')));             %Calling the function dewatermarking_k with key selected

 else
        img_logo=dewatermark_img(imread(img),str2num(get(handles.edit2,'String')));     %Calling the function dewatermarking_img with key selected
    end
end

%Mostro i risultati
if type==1
    figure
    imshow(img_logo)
    title('Message')
    set(handles.edit3,'String','Message: Image!');
else
    set(handles.edit3,'String',st);                                         %show the watermark text
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global key_d
key_d=1-key_d;                      %If key=0 its fixed at 1, if key=1 its fixed at 0
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type
type=0;         %Type Text
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type
type=1;         %Type Image
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Delete the global variables
clear global key_d                                 
clear global type 
% Hint: delete(hObject) closes the figure
delete(hObject);
