function varargout = mainform(varargin)
% MAINFORM M-file for mainform.fig
%      MAINFORM, by itself, creates a new MAINFORM or raises the existing
%      singleton*.
%
%      H = MAINFORM returns the handle to a new MAINFORM or the handle to
%      the existing singleton*.
%
%      MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFORM.M with the given input arguments.
%
%      MAINFORM('Property','Value',...) creates a new MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainform

% Last Modified by GUIDE v2.5 06-Jul-2010 13:42:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainform_OpeningFcn, ...
                   'gui_OutputFcn',  @mainform_OutputFcn, ...
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


% --- Executes just before mainform is made visible.
function mainform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainform (see VARARGIN)

% Choose default command line output for mainform
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Prepare space for image display
axes(handles.axes2);
axis off;   
% UIWAIT makes mainform wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Clear main Matlab windows
clc;

% Clear all variables
clear all;


% --- Outputs from this function are returned to the command line.
function varargout = mainform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global image_loaded;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Invoke file selection window
[filename,pathname]=uigetfile({'*.jpg';'*.bmp'},'Wybierz obraz');

% Load image
image_loaded = imresize(imread(filename),[250 250]);
image(image_loaded,'parent',handles.axes2);
axes(handles.axes2);
axis off;

% Make button and text area active
set(handles.edit1,'Enable','on');
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','on');

% Display filename under image
set(handles.text3,'String',filename);


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global image_loaded;
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

image_temporary = image_loaded;

% Generate watermark bits from text area
watermark = zeros(1,192);
ascii_codes = unicode2native(get(handles.edit1,'String'), 'ISO-8859-1');
for l=1:size(ascii_codes,2)
    code_string=num2str(dec2bin(ascii_codes(l),8));
    for m=1:8
        code_string(m);
        watermark(m+((l-1)*8))=eval(code_string(m));
    end
end

% Display watermark in Matlab window
watermark

% Conversion RGB -> YCbCr
image_temporary_ycbcr = rgb2ycbcr(image_temporary);

% Extract Y, Cb, Cr components
y=image_temporary_ycbcr(:,:,1);
cb=image_temporary_ycbcr(:,:,2);
cr=image_temporary_ycbcr(:,:,3);

% Create LSB martix for Cb and Cr components
% For 2-bit coding use mod(component,4)
lsbits_cb = mod(cb,2);
lsbits_cr = mod(cr,2);

% --WATERMARK EMBEDDING ALGORITHM--

bit_position=1;

for w=1:(300/25)
    for k=1:(400/25)
        
        % Embed watermark bits in blocks 25x25
        if mod((w+k),2)==0
            
            if(watermark(bit_position)==1)
                % If current watermark bit is 1, then LSB of Cb is 0 and LSB of Cr is 1
                % cb=cb-lsbits_cb
                % cr=cr-lsbits_cr+1;
                % For 2-bit coding use cr()=cr()+3;
                cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25);
                cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)+1;
            else                
                % If current watermark bit is 0, then LSB of Cb is 1 and LSB of Cr is 0
                cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25);
                cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)+1;        
    
            end
        else
            % Oppoosite scheme in adjacents blocks
            if(watermark(bit_position)==1)
                cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25);
                cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)+1;
            else
                cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cb(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25);
                cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)=cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)-lsbits_cr(((w-1)*25)+1:w*25,((k-1)*25)+1:k*25)+1;
            end
        end
        bit_position=bit_position+1;
    end
end

% Create result image
image_temporary_ycbcr(:,:,1)=y;
image_temporary_ycbcr(:,:,2)=cb;
image_temporary_ycbcr(:,:,3)=cr;

% Conversion YCbCr -> RGB
image_output = ycbcr2rgb(image_temporary_ycbcr);

% Save result file
imwrite(image_output,'output.bmp','bmp');

% Load watermarked image
image_loaded = image_output;

image(image_loaded,'parent',handles.axes2);
axes(handles.axes2);
axis off;

% Display filename under image
set(handles.text3,'String','output.bmp');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_loaded;
image_temporary = image_loaded;

% Define starting watermark payload as zero bits
watermark = zeros(1,192);

% Conversion RGB -> YCbCr
image_temporary_ycbcr = rgb2ycbcr(image_temporary);

% Extract Y, Cb, Cr components
y=image_temporary_ycbcr(:,:,1);
cb=image_temporary_ycbcr(:,:,2);
cr=image_temporary_ycbcr(:,:,3);

% Create LSB martix for Cb and Cr components
lsbits_cb = mod(cb,2);
lsbits_cr = mod(cr,2);

% --WATERMARK EXTRACTION ALGORITHM--
bit_position=1;

% Counters used for deciding watermark value in block
counter0=0;
counter1=0;

for blok_w=1:(300/25)
    for blok_k=1:(400/25)
        
        % Read image in blocks 25x25
        if mod((blok_w+blok_k),2)==0
            for w=((blok_w-1)*25)+1:blok_w*25
                for k=((blok_k-1)*25)+1:blok_k*25
                    if lsbits_cb(w,k)<1
                    % For 2-bit coding use lsbits_cb()<2;
                        counter1=counter1+1;
                    else
                        counter0=counter0+1;
                    end
                    if lsbits_cr(w,k)>=1
                        counter1=counter1+1;
                    else
                        counter0=counter0+1;
                    end
                end
            end
        else
            for w=((blok_w-1)*25)+1:blok_w*25
                for k=((blok_k-1)*25)+1:blok_k*25
                    if lsbits_cb(w,k)>=1
                        counter1=counter1+1;
                    else
                        counter0=counter0+1;
                    end
                    if lsbits_cr(w,k)<1
                        counter1=counter1+1;
                    else
                        counter0=counter0+1;
                    end
                end
            end
        end
        
        % Decision of watermark bit value in current block
        if counter0 > counter1
            watermark(bit_position)=0;
        else
            watermark(bit_position)=1;
        end
        
        % Move to next position in watermark
        bit_position=bit_position+1;
        
        % Reset counters
        counter0=0;
        counter1=0;
    end
end

% Conversion of binary form of watermark to text displayed in text area
read_bit=1;
for read_byte=1:(192/8)
    ascii_code=0;
    for read_bit=1:8
        bit_decimal_value=watermark(read_bit+((read_byte-1)*8))*2^(abs((read_bit-1)-7));
        ascii_code=ascii_code+bit_decimal_value;
    end
    napis(read_byte)=ascii_code;
end

% Display read text in text area
set(handles.edit2,'String',char(native2unicode(napis, 'ISO-8859-1')));


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Simple watermark embedding system','','Krzysztof Parobczak,','Military University of Technology','Warsaw, Poland','','2010'});
