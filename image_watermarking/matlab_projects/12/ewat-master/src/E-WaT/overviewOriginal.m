function varargout = overviewOriginal(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @overviewOriginal_OpeningFcn, ...
    'gui_OutputFcn',  @overviewOriginal_OutputFcn, ...
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


%% Opening function
function overviewOriginal_OpeningFcn(hObject, eventdata, handles, varargin)
clc;

handles.output = hObject;

guidata(hObject, handles);

type = get_root_data('image_type');
switch type
    case 'grayscale'
        original = im2double(get_root_data('original_plot_grayscale'));
        [H W D] = size(original);
        watermarked = imresize(im2double(get_root_data('watermarked_attacked_plot_grayscale')), [H W]);
        attacked = imresize(im2double(get_root_data('attacked_decode_plot_grayscale')), [H W]);
        
    case 'layered'
        original = im2double(get_root_data('original_plot_rgb'));
        [H W D] = size(original);
        watermarked = imresize(im2double(get_root_data('watermarked_attacked_plot_rgb')), [H W]);
        attacked = imresize(im2double(get_root_data('attacked_decode_plot_rgb')), [H W]);
end;



axes(handles.axes1_original);
imshow(original);
axis off;

axes(handles.axes1_watermarked);
imshow(watermarked);
axis off;

axes(handles.axes2_watermarked);
imshow(watermarked);
axis off;

axes(handles.axes2_attacked);
imshow(attacked);
axis off;

axes(handles.axes3_original);
imshow(original);
axis off;

axes(handles.axes3_attacked);
imshow(attacked);
axis off;

messageType = get_root_data('chosen_message');
switch(messageType)
    case 'imag'
        message_embedded = im2double(get_root_data('embedded_image'));
        [mH mW mD] = size(message_embedded);
        message_detected = imresize(im2double(get_root_data('detected_image')), [mH mW]);

        axes(handles.axes4_embed);
        imshow(message_embedded);
        axis off;

        axes(handles.axes4_detected);
        imshow(message_detected);
        axis off;
    case 'text'
        message_embedded_t = get_root_data('embedded_text');
        message_detected_t = get_root_data('detected_text');
        set(handles.messageEmbedded, 'String', message_embedded_t);
        set(handles.messageDetected, 'String', message_detected_t);
        set(handles.messageEmbedded, 'Visible', 'on');
        set(handles.messageDetected, 'Visible', 'on');
end

%% ICONS

%display icons on buttons
setIcon(handles.zoomIn, imread('Icons\zoomIn.jpg'), 25, 25);        %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
setIcon(handles.zoomInClick, imread('Icons\zoomInClick.jpg'), 25, 25);   %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
setIcon(handles.pan, imread('Icons\pan.jpg'), 25, 25);              %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
setIcon(handles.zoomOutAll, imread('Icons\zoomOutAll.jpg'), 25, 25);%call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions

%% Calculate parameters


[mse_watermarked,psnr_watermarked,ber_watermarked,] = calculate_statistical(original,watermarked);
[mse_attacked,psnr_attacked,ber_attacked,] = calculate_statistical(watermarked,attacked);
[mse_original,psnr_original,ber_original,] = calculate_statistical(original,attacked);
wnr = psnr_watermarked/psnr_original;

% Place calculations in root so that calculations don't have do be done
% twice

set_root_data(handles,'mse_watermarked',mse_watermarked);
set_root_data(handles,'psnr_watermarked',psnr_watermarked);
set_root_data(handles,'ber_watermarked',ber_watermarked);

set_root_data(handles,'mse_attacked',mse_watermarked);
set_root_data(handles,'psnr_attacked',psnr_watermarked);
set_root_data(handles,'ber_attacked',ber_watermarked);

set_root_data(handles,'mse_original',mse_watermarked);
set_root_data(handles,'psnr_original',psnr_watermarked);
set_root_data(handles,'ber_original',ber_watermarked);

set_root_data(handles,'wnr',wnr);

set(handles.wnr, 'String', [num2str(round(wnr*1000)/1000) ' dB']);


switch (messageType)
    case 'imag'
        [mse_mess,psnr_mess,ber_mess,] = calculate_statistical(message_embedded,message_detected);
        set(handles.text_mse_mess,'String',round(mse_mess));
        set(handles.text_psnr_mess,'String',[num2str(round(psnr_mess*100)/100) ' dB']);
        set(handles.text_ber_mess,'String',round(ber_mess*1000)/1000);
    case 'text'
        ber_mess = calculate_ber_text(message_embedded_t,message_detected_t);
        set(handles.text_mse_mess,'String','/');
        set(handles.text_psnr_mess,'String','/');
        set(handles.text_ber_mess,'String',round(ber_mess*1000)/1000);
end

set(handles.text_mse_watermarked,'String',round(mse_watermarked));
set(handles.text_psnr_watermarked,'String',[num2str(round(psnr_watermarked*100)/100) ' dB']);
set(handles.text_ber_watermarked,'String',round(ber_watermarked*1000)/1000);

set(handles.text_mse_attacked,'String',round(mse_attacked));
set(handles.text_psnr_attacked,'String',[num2str(round(psnr_attacked*100)/100) ' dB']);
set(handles.text_ber_attacked,'String',round(ber_attacked*1000)/1000);

set(handles.text_mse_original,'String',round(mse_original));
set(handles.text_psnr_original,'String',[num2str(round(psnr_original*100)/100) ' dB']);
set(handles.text_ber_original,'String',round(ber_original*1000)/1000);

%% CAPACITY

        [H W D] = size(original);

        capLSBBITS = floor(H/2)*floor(W/2);
        capLSBCHARS = floor(H/16)*floor(W/21);
        capPatchworkBITS = floor(H/4)*floor(W/4)/2;
        capPatchworkCHARS = floor(H/4)*floor(W/4)/16;
        capCorrelationBITS = floor(H/2)*floor(W/2);
        capCorrelationCHARS = floor(H/2)*floor(W/2)/8;
        capDCTbits = floor(H/8)*floor(W/8);
        capDCTchars = floor(H/8)*floor(W/8)/8;
        capDWTbits = (floor(H/4)*floor(W/4))/(4^2);
        capDWTchars = ((floor(H/4)*floor(W/4))/(4^2))/8;
        capQIMbits = floor(H)*floor(W)/8;
        capQIMchars = floor(H)*floor(W)/64;

        set(handles.capLSBkey, 'String', [num2str(capLSBBITS), ' bit(s)']);
        set(handles.capPatchwork, 'String', [num2str(capPatchworkBITS), ' bit(s) ']);
        set(handles.capCorrelation, 'String', [num2str(capCorrelationBITS), ' bit(s) ']);
        set(handles.capDCT, 'String', [num2str(capDCTbits), 'bit(s)']);
        set(handles.capDWT, 'String', [num2str(capDWTbits), 'bit(s)']);
        set(handles.capQIM, 'String', [num2str(capQIMbits), 'bit(s)']);



%% EXPORT TO EXCEL

% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------- UIT ROOT HALEN ? ------------------------------------
type = get_root_data('image_type');
switch type
    case 'grayscale'
        original = im2double(get_root_data('original_plot_grayscale'));
        
    case 'layered'
        original = im2double(get_root_data('original_plot_rgb'));
        
end;

message_embedded = im2double(get_root_data('embedded_image'));
message_detected = im2double(get_root_data('detected_image'));

message_embedded_t = get_root_data('embedded_text');
message_detected_t = get_root_data('detected_text');


mse_watermarked = get_root_data('mse_watermarked');
psnr_watermarked = get_root_data('psnr_watermarked');
ber_watermarked = get_root_data('ber_watermarked');

mse_attacked = get_root_data('mse_attacked');
psnr_attacked = get_root_data('psnr_attacked');
ber_attacked = get_root_data('ber_attacked');

mse_original = get_root_data('mse_original');
psnr_original = get_root_data('psnr_original');
ber_original = get_root_data('ber_original');

wnr = get_root_data('wnr');

[H W D] = size(original);

capLSBBITS = floor(H/2)*floor(W/2);
capLSBCHARS = floor(H/16)*floor(W/21);
capCorrelationBITS = floor(H/2)*floor(W/2);
capCorrelationCHARS = floor(floor(H/2)*floor(W/2)/8);
capDCTbits = floor(H/8)*floor(W/8);
capDCTchars = floor(floor(H/8)*floor(W/8)/8);
capDWTbits = (floor(H/2)*floor(W/2))/(4^2);
capDWTchars = floor((floor(H/2)*floor(W/2))/(4^2)/8);
% ------------------------------------------------------------------

[filename, pathname, index] = uiputfile( ...
    {'*.xlsx' ; '*.xls'}, ...
    'Export to excel');

if(~strcmp(filename, '0') &&  ~strcmp(pathname, '0'))
messageType = get_root_data('chosen_message');
    switch (messageType)
        case 'imag'
            [mse_mess,psnr_mess,ber_mess,] = calculate_statistical(message_embedded,message_detected);

            d = {'', 'Original vs watermarked', 'Watermarked vs attacked', 'Original vs attacked', 'Embedded vs detected message','', ''; ...
                'MSE',  mse_watermarked, mse_attacked, mse_original, mse_mess,'', ''; ...
                'PSNR', psnr_watermarked, psnr_attacked, psnr_original, psnr_mess,'', ''; ...
                'BER', ber_watermarked, ber_attacked, ber_original, ber_mess,'', '';...
                '', '', '', '','','', '' ; ...
                'Capacity', '', '', '', '', '', '';...
                'LSB with key', 'LSB without key', 'Patchwork', 'Correlation', 'DCT', 'DWT', ''; ...
                capLSBBITS,capLSBBITS,1,capCorrelationBITS,capDCTbits ,capDWTbits, 'bit(s)';...
                capLSBCHARS, capLSBCHARS, 1,capCorrelationCHARS, capDCTchars, capDWTchars, 'char(s)';...
                'WNR', wnr, '', '', '','', ''};
        case 'text'
            ber_mess = calculate_ber_text(message_embedded_t,message_detected_t);
            d = {'', 'Original vs watermarked', 'Watermarked vs attacked', 'Original vs attacked', 'Embedded vs detected message','', ''; ...
                'MSE',  mse_watermarked, mse_attacked, mse_original, '','', ''; ...
                'PSNR', psnr_watermarked, psnr_attacked, psnr_original, '','', ''; ...
                'BER', ber_watermarked, ber_attacked, ber_original, ber_mess,'', '';...
                '', '', '', '','','', ''; ...
                'Capacity', '', '', '', '', '', '';...
                'LSB with key', 'LSB without key', 'Patchwork', 'Correlation', 'DCT', 'DWT', ''; ...
                capLSBBITS,capLSBBITS,1,capCorrelationBITS,capDCTbits ,capDWTbits, 'bit(s)';...
                capLSBCHARS, capLSBCHARS,1, capCorrelationCHARS, capDCTchars, capDWTchars, 'char(s)';...
                'WNR', wnr, '', '', '','', ''};
    end
    xlswrite([pathname filename], d, 'Blad1', 'A1');
end



%% ZOOM
%%
% --- Executes on button press in zoomIn.
function zoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to zoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
if(get(handles.zoomIn, 'Value') == 1.0)             %zoom toggled on
    set(handles.pan, 'Value', 0.0);                     %toglle pan-button of
    pan off                                             %turn pan off
    axes_handles = zeros(1,6);                         %put handles of all axes in one vector
    axes_handles(1) = handles.axes1_original;
    axes_handles(2) = handles.axes1_watermarked;
    axes_handles(3) = handles.axes2_watermarked;
    axes_handles(4) = handles.axes2_attacked;
    axes_handles(5) = handles.axes3_original;
    axes_handles(6) = handles.axes3_attacked;
    linkaxes(axes_handles);                             %links axes together
    axes_m_1 = handles.axes4_embed;
    axes_m_2 = handles.axes4_detected;
    linkaxes([axes_m_1, axes_m_2]);                             %links axes together
    zoom                                                %enable dynamic zoom
else
    zoom off
end

%%
% --- Executes on button press in zoomInClick.
function zoomInClick_Callback(hObject, eventdata, handles)
% hObject    handle to zoomInClick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.zoomIn, 'Value', 0.0);      %toggle zoom button off
zoom off
set(handles.pan, 'Value', 0.0);     %toglle pan-button of
pan off                             %turn pan off
ax = get(gcf,'CurrentAxes');        %get current active axes
im = getimage(ax);                  %get image of current active axes
figure                              %open new figure
imshow(im);                         %show image


%%
% --- Executes on button press in pan.
function pan_Callback(hObject, eventdata, handles)
% hObject    handle to pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
if(get(handles.pan, 'Value') == 1.0)
    set(handles.zoomIn, 'Value', 0.0);                      %toglle pan-button of
    zoom off                                                %turn zoom off
    pan                                                     %enable pan
else
    pan off
end

%%
% --- Executes on button press in zoomOutAll.
function zoomOutAll_Callback(hObject, eventdata, handles)
% hObject    handle to zoomOutAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
set(handles.zoomIn, 'Value', 0.0);                      %toggle zoomIn-button off
zoom off                                                %turn zoom off
set(handles.pan, 'Value', 0.0);                         %toggle pan-button off
pan off                                                 %turn pan off
zoomOutAll_overview(handles);                           %resets all axes to initial zoom

%%
% --- Executes on button press in helpZoom.
function helpZoom_Callback(hObject, eventdata, handles)
% hObject    handle to helpZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%show info help message
msgbox('In this inteface, MSE, PSNR, BER and WSNR are computed between images at different steps in the watermarking process. MSE is the mean squared error, the mean of all the sqaured differences between an image and its distorted counterpart. PSNR is the peak singal to noise ratio, the ratio of the squared maximum pixel value to the MSE. BER stands for bit error rate and is the number of pixels or characters that is different in the distorted image divided by the total number of pixels. WNR is the watermark to noise ratio, the ratio of the PSNR after embedding and PSNR after attack. To zoom in on any of the images or axes of the figure, click on the ''zoom in''-button. Then click on an image to zoom in or use the mouse to scroll up. To zoom in on a specific area, simply select that area. You can zoom out by holding CTRL while clicking on an image or axe or by scrolling down. To open an image in a new figure, click on the image and then hit the view-in-new-figure button. To restore an image, simply double click on it. To restore all the images and axes, use the ''zoom out all''-button. Panning is possible after clicking the pan-button.', 'Info', 'help');



%% Output function
function varargout = overviewOriginal_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
close;








