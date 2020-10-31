function varargout = embedding(varargin)
% EMBEDDING MATLAB code for embedding.fig
%      EMBEDDING, by itself, creates a new EMBEDDING or raises the existing
%      singleton*.
%
%      H = EMBEDDING returns the handle to a new EMBEDDING or the handle to
%      the existing singleton*.
%
%      EMBEDDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMBEDDING.M with the given input arguments.
%
%      EMBEDDING('Property','Value',...) creates a new EMBEDDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before embedding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to embedding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help embedding

% Last Modified by GUIDE v2.5 09-Apr-2016 09:15:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @embedding_OpeningFcn, ...
    'gui_OutputFcn',  @embedding_OutputFcn, ...
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



% --- Executes just before embedding is made visible.
function embedding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to embedding (see VARARGIN)

% Choose default command line output for embedding
handles.output = hObject;
handles.LL = 0;
handles.Y=0;
handles.Cb=0;
handles.Cr=0;
handles.HL=0;
handles.LH=0;
handles.HH=0;
handles.sChon=0;
handles.Q1=0;
handles.Q2=0;
handles.Q3=0;
handles.Q4=0;
handles.chonPhan=0;
handles.tempW1=0;
handles.tempW2=0;
handles.tempW3=0;
handles.tempW4=0;
handles.viTriNhung1=0;
handles.viTriNhung2=0;
handles.viTriNhung3=0;
handles.viTriNhung4=0;


%[LL,HL,LH,HH]
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes embedding wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = embedding_OutputFcn(hObject, eventdata, handles)
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

set(handles.txtNhieuBien1,'String','');
set(handles.txtNhieuBien2,'String','');
set(handles.txtNhieuBien3,'String','');
set(handles.txtNhieuBien4,'String','');
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhGoc=imread(strcat(anhmau,fname));
axes(handles.axes1)  %Fisso l'axes per il plot
%anhGoc=double(anhGoc1);
imshow(anhGoc)

%Xu Ly Anh Goc
YCBCR=rgb2ycbcr(anhGoc); % chuyen RGB sang YCbCr
Y=YCBCR(:,:,1);
Cb=YCBCR(:,:,2); % lay phan Cb
Cr=YCBCR(:,:,3);
handles.Y=Y;
handles.Cr=Cr;
guidata(hObject, handles);
%Chia Anh Thanh 4 Phan

[row, col]=size(Cb);
mr = round(row/2); % median of rows
mc = round(col/2); % median of columns

% Phan 1
Q1 = Cb(1:mr  , 1:mc);
p1=edge(Q1,'canny');
axes(handles.axes6)
imshow(p1)
% dem so bien
[labeledImage, numberOfEdgesp1] = bwlabel(p1);
numberOfEdgesp1;

% phan 2
Q2 = Cb(1:mr  , (mc+1):col);
p2=edge(Q2,'canny');
axes(handles.axes7)
imshow(p2)
% dem so bien
[labeledImage, numberOfEdgesp2] = bwlabel(p2);
numberOfEdgesp2;

% phan 3
Q3 = Cb((mr+1):row , 1:mc);
p3=edge(Q3,'canny');
axes(handles.axes8)
imshow(p3)
% dem so bien
[labeledImage, numberOfEdgesp3] = bwlabel(p3);
numberOfEdgesp3;

% Pham 4
Q4 = Cb((mr+1):row , (mc+1):col);
p4=edge(Q4,'canny');
axes(handles.axes9)
imshow(p4)
%Dem So Bien
[labeledImage, numberOfEdgesp4] = bwlabel(p4);
numberOfEdgesp4;

handles.Q1=Q1;
handles.Q2=Q2;
handles.Q3=Q3;
handles.Q4=Q4;
guidata(hObject, handles);
% Tim phan tu c� so bien lon nhat
h=[numberOfEdgesp1 numberOfEdgesp2 numberOfEdgesp3 numberOfEdgesp4];
y=1;
max=h(1);
for i=1:4
    if h(i)>max
        max =h(i);
        y=i;
    else
        max=max;
        
    end
end
handles.chonPhan=y;
guidata(hObject, handles);
pchon=p1;
phanTuChon=Q1;
if y==1
    pchon=p1;
    phanTuChon=Q1;
    set(handles.txtNhieuBien1,'String','Phan Nhieu Bien Nhat');
    %figure(2),imshow(p1),title('Phan Tu Nhieu Bien Nhat');
end
if y==2
    pchon=p2;
    phanTuChon=Q2;
    set(handles.txtNhieuBien2,'String','Phan Nhieu Bien Nhat');
    %figure(2),imshow(p2),title('Phan Tu Nhieu Bien Nhat');
end
if y==3
    pchon=p3;
    phanTuChon=Q3;
    set(handles.txtNhieuBien3,'String','Phan Nhieu Bien Nhat');
    %figure(2),imshow(p3),title('Phan Tu Nhieu Bien Nhat');
end
if y==4
    pchon=p4;
    phanTuChon=Q4;
    set(handles.txtNhieuBien4,'String','Phan Nhieu Bien Nhat');
    % figure(2),imshow(p4),title('Phan Tu Nhieu Bien Nhat');
end
%figure(2);%,imshow(pchon),title('Phan Tu Nhieu Bien Nhat');
%subplot(2,1,1);imshow(pchon);title('Phan Tu Nhieu Bien Nhat');
%subplot(2,1,2);imshow(phanTuChon);title('Chon Phan Tu');
%phanChon=double(phanTuChon);
[LL,HL,LH,HH] = dwt2(phanTuChon,'haar');
size(LL)
handles.LL=LL;
handles.HL=HL;
handles.LH=LH;
handles.HH=HH;
guidata(hObject, handles);
%figure(3);
%subplot(2,2,1);imshow(LL);title('LL band of image');
%subplot(2,2,2);imshow(LH);title('LH band of image');
%subplot(2,2,3);imshow(HL);title('HL band of image');
%subplot(2,2,4);imshow(HH);title('HH band of image');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhThuyVan=imread(strcat(anhmau,fname));
R=anhThuyVan(:,:,1);
G=anhThuyVan(:,:,2);
B=anhThuyVan(:,:,3);
%I=cat(3,R,G,B);
%figure(1),imshow(R),title('R');
%figure(2),imshow(G),title('G');
%figure(3),imshow(B),title('B');
%figure(3),imshow(I),title('I');
%anhThuyVan=rgb2gray(anhTV);
axes(handles.axes5)             %Fisso l'axes per il plot
imshow(anhThuyVan)
% Chia Anh Thanh 4 Phan
% Chuyen tung phan cua thuy van thanh mot ma tran mot hang c� so phan tu
% = mrW x mcW
[rowW, colW,z3]=size(anhThuyVan);
z3
mrW = round(rowW/2); % median of rows
mcW = round(colW/2); % median of columns
save data.mat mrW mcW

% kich thuoc ma tran temp
z=mrW*mcW;
tempW1=1:z;
tempW1
tempW2=1:z;
tempW3=1:z;
tempW4=1:z;
chay=1;
% Phan 1
W1  = anhThuyVan(1:mrW  , 1:mcW,:);
[r1,c1]=size(W1)

for t1=1:mrW
     if chay>z,
            break;
     end
    for t2=1:mcW
       
        tempW1(chay)=W1(t1,t2);
        chay=chay+1;
    end
end    
% phan 2
chay2=1;
W2 = anhThuyVan(1:mrW  , (mcW+1):colW,:);
for t1=1:mrW
    if chay2>z,
            break;
    end
    for t2=1:mcW
        
        tempW2(chay2)=W2(t1,t2);
        chay2=chay2+1;
    end
end  
% phan 3
chay3=1;
W3  = anhThuyVan((mrW+1):rowW , 1:mcW,:);
for t1=1:mrW
    if chay3>z,
            break;
    end
    for t2=1:mcW
        
        tempW3(chay3)=W3(t1,t2);
        chay3=chay3+1;
    end
end  
% Pham 4
chay4=1;
W4 = anhThuyVan((mrW+1):rowW , (mcW+1):colW,:);
for t1=1:mrW
    if chay4>z,
            break;
    end
    for t2=1:mcW
        
        tempW4(chay4)=W4(t1,t2);
        chay4=chay4+1;
    end
end  
a=W1(10,15,:)
b=W1(5,2,:)
handles.tempW1=tempW1;
handles.tempW2=tempW2;
handles.tempW3=tempW3;
handles.tempW4=tempW4;
guidata(hObject, handles);

%size(W1)
%size(W2)
%z
 figure;
    subplot(2, 2, 1);
    imshow(W1); title('1');
    subplot(2, 2, 2);
    imshow(W2);title('2');
    subplot(2, 2, 3);
    imshow(W3);title('3');
    subplot(2, 2, 4);
    imshow(W4);title(' 4');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LLw=handles.LL;
HL=handles.HL;
LH=handles.LH;
HH=handles.HH;
Q1=handles.Q1;
Q2=handles.Q2;
Q3=handles.Q3;
Q4=handles.Q4;
Y=handles.Y;
Cr=handles.Cr;
sQ=size(Q1);
chonPhan=handles.chonPhan;
tempW1=handles.tempW1;
tempW2=handles.tempW2;
tempW3=handles.tempW3;
tempW4=handles.tempW4;
tempW1
tempW2
tempW3
tempW4
z=size(tempW1);
chay=1;
dongNhung1=0;
dongNhung2=0;
dongNhung3=0;
dongNhung4=0;
anhDaThuyVan=0;
[rowLL,colLL]=size(LLw)
% NHUNG W1
for r1=1:rowLL
     if chay>z,
            dongNhung1=r1-1;
            break;
     end
    for c1=1:colLL
        
       
        LLw(r1,c1)=( LLw(r1,c1) + 0.1*tempW1(chay));
        chay=chay+1;
    end
end
dongNhung1
% Nhung W2
chay2=1;
for r2=(dongNhung1+1):rowLL
    if chay2>z,
            dongNhung2=r2-1;
            break;
    end
    for c2=1:colLL
        
        LLw(r2,c2)=( LLw(r2,c2) + 0.1*tempW2(chay2));
        chay2=chay2+1;
    end
end
dongNhung2
% Nhung W3
chay3=1;
for r3=(dongNhung2+1):rowLL
    if chay3>z,
            dongNhung3=r3-1;
            break;
    end
    for c3=1:colLL
        
        LLw(r3,c3)=( LLw(r3,c3) + 0.1*tempW3(chay3));
        chay3=chay3+1;
    end
end
dongNhung3
%Nhung W4
chay4=1;
for r4=(dongNhung3+1):rowLL
    if chay4>z,
            dongNhung4=r4-1;
            break;
    end
    for c4=1:colLL
        
        LLw(r4,c4)=( LLw(r4,c4) + 0.1*tempW4(chay4));
        chay4=chay4+1;
    end
end
%figure(2),imshow(LLw),title('LLw');
if chonPhan==1
    Q=idwt2(LLw, HL, LH, HH,'haar', sQ);
    Cb=[Q,Q2;Q3,Q4];
    YCbCr=cat(3,Y,Cb,Cr);
    anhDaThuyVan=ycbcr2rgb(YCbCr);
    axes(handles.axes4);             %Fisso l'axes per il plot
    imshow(anhDaThuyVan);
    
end
if chonPhan==2
    Q=idwt2(LLw, HL, LH, HH, 'haar', sQ);
    Cb=[Q1,Q;Q3,Q4];
    YCbCr=cat(3,Y,Cb,Cr);
    anhDaThuyVan=ycbcr2rgb(YCbCr);
    axes(handles.axes4);             %Fisso l'axes per il plot
    imshow(anhDaThuyVan);
    
end
if chonPhan==3
    Q=idwt2(double(LLw), HL, LH, HH, 'haar', sQ);
    Cb=[Q1,Q2;Q,Q4];
    YCbCr=cat(3,Y,Cb,Cr);
    anhDaThuyVan=ycbcr2rgb(YCbCr);
    axes(handles.axes4);             %Fisso l'axes per il plot
    imshow(anhDaThuyVan);
    
end
if chonPhan==4
    Q=idwt2(LLw, HL, LH, HH, 'haar', sQ);
    Cb=[Q,Q2;Q3,Q];
    YCbCr=cat(3,Y,Cb,Cr);
    anhDaThuyVan=ycbcr2rgb(YCbCr);
    axes(handles.axes4);             %Fisso l'axes per il plot
    imshow(anhDaThuyVan);
    
end
% Luu Anh Da Nhung Thuy Van
global var;
[filename,pathname,filterindex]=uiputfile({'*.jpg;*.jpeg;*.gif;*.tif;*.tiff;*.rgb;*.bmp;*.png',...
    'All support image files';'*.jpg;*.jpeg','JPEG files(*.jpg;*.jpeg)';'*.gif','GIF files (*.gif)';...
    '*.tif;*.tiff','TIFF files (*.tif;*.tiff)';'*.bmp','Bitmap files (*.bmp)';'*.png','PNG files (*.png)'},'Luu dang file anh');
var=strcat(pathname,filename);
imwrite(anhDaThuyVan,var);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes4
