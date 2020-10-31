%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%
%GUI watermarking: This is the main gui an the base of all the calculations

%% Main function
function varargout = ewat(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ewat_OpeningFcn, ...
                   'gui_OutputFcn',  @ewat_OutputFcn, ...
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

%% Opening Function
function ewat_OpeningFcn(hObject, eventdata, handles, varargin)

        handles.output = hObject;
        guidata(hObject, handles);
        
        %initialize tabs
        set(handles.tab_embed,'Visible','off');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_decode,'Visible','off');
        set(handles.tab_layers_rgb_original,'Visible','off');
        set(handles.tab_settings,'Visible','off');
        
        set(handles.tab_control,'Visible','off');
        set(handles.tab_decoded_text,'Visible','off');
        set(handles.tab_decoded_image,'Visible','off');
        %initialize axes
        set(handles.axes_image_original, 'Visible', 'off');
        set(handles.axes_icon_rgb_original, 'Visible', 'off');
        set(handles.axes_layer_green_watermarked_attacked, 'Visible', 'off');
        set(handles.axes_layer_blue_watermarked_attacked, 'Visible', 'off');
        set(handles.axes_layer_red_watermarked_attacked, 'Visible', 'off');
        
        %initialize togglebuttons
        set(handles.togglebutton_image_original,'Value',1);
        set(handles.togglebutton_fullcolor_original,'Value',1);
        set(handles.togglebutton_embed,'Visible','off');
        set(handles.togglebutton_attack,'Visible','off');
        set(handles.togglebutton_decode,'Visible','off');
        
        set(handles.pushbutton_overview,'Visible','off');
        
        %initialize icons
        
        setIcon(handles.pushbutton_save_watermarked_embed, imread('save.jpg'), 25, 25);        %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
        setIcon(handles.pushbutton_save_watermarked_attacked, imread('save.jpg'), 25, 25);        %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
        setIcon(handles.pushbutton_save_attacked_attacked, imread('save.jpg'), 25, 25);        %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions
        setIcon(handles.pushbutton_save_attacked_decoded, imread('save.jpg'), 25, 25);        %call setIcon function which displays the passed image in the passed uicontrol with the passed dimensions

        setappdata(0,'hroot_data', gcf);                        %this has to be made to place global data in it
        set_root_data(handles,'image_representation','ycbcr'); 
        set_root_data(handles,'handles_main',handles);
        
%%
function textbox_image_name_CreateFcn(hObject, eventdata, handles)

%% Browse
function pushbutton_browse_Callback(hObject, eventdata, handles)

         [tempname, temppath] = uigetfile({'*.jpg;*.jpeg;*.gif;*.bmp;*.tif;*.tiff;*.png','Images(*.bmp, *.jpg, *.jpeg, *.gif,*.png, *.tif, *.tiff)'},'Select an image');
         if tempname ==0;
             msgbox('No image was selected','Warning','warn');
         else
         [filepath ,filename,ext,tempver] = fileparts(strcat(temppath, '\', tempname));
         set(handles.textbox_image_name, 'String', [filename ext]);                     %displays name of selected image in textbox
         
         set(handles.tab_watermarked_embed,'Visible','off');
         set(handles.tab_layers_ycbcr_original,'Visible','off');   
         
         image_info= imfinfo([filepath filename ext]);
         image_type = getfield(image_info,'ColorType');
             switch image_type
                 case 'grayscale'
                     %read image
                     image_read =imread([filepath filename ext]);
                     image = cat(3,image_read,image_read,image_read);
                     
                     %special initialization
                     set(handles.togglebutton_layers_original,'Visible','off');
                     set(handles.togglebutton_layers_watermarked_embed,'Visible','off');
                     set(handles.togglebutton_layers_watermarked_attacked,'Visible','off');
                     set(handles.togglebutton_layers_attacked_attacked,'Visible','off');
                     set(handles.togglebutton_layers_attacked_decode,'Visible','off');
                     
                     set(handles.togglebutton_image_original,'Enable','off');
                     set(handles.togglebutton_image_watermarked_embed,'Enable','off');
                     set(handles.togglebutton_image_watermarked_attacked,'Enable','off');
                     set(handles.togglebutton_image_attacked_attacked,'Enable','off');
                     set(handles.togglebutton_image_attacked_decode,'Enable','off');
                     
                     set_root_data(handles,'image_type','grayscale');
                     
                     new_image = make_compatible(image);
                     
                     calculate_components_original(handles,new_image);
                     
                     set(handles.tab_settings,'Visible','off');
                 case 'truecolor'
                     %read image
                     image =imread([filepath filename ext]);
                     
                     %special initialization
                     set(handles.togglebutton_layers_original,'Visible','on');
                     set(handles.togglebutton_layers_watermarked_embed,'Visible','on');
                     set(handles.togglebutton_layers_watermarked_attacked,'Visible','on');
                     set(handles.togglebutton_layers_attacked_attacked,'Visible','on');
                     set(handles.togglebutton_layers_attacked_decode,'Visible','on');
                     
                     set(handles.togglebutton_layers_original,'Enable','on');
                     set(handles.togglebutton_layers_watermarked_embed,'Enable','on');
                     set(handles.togglebutton_layers_watermarked_attacked,'Enable','on');
                     set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
                     set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                     
                     set_root_data(handles,'image_type','layered');
                     
                     new_image = make_compatible(image);
                     
                     calculate_components_original(handles,im2uint8(new_image));
                     
                     set(handles.tab_settings,'Visible','on');
                 case 'indexed'
                     %read image
                     [image_index,image_map] =imread([filepath filename ext]);
                     image = ind2rgb(image_index,image_map);
                     
                     %special initialization
                     set(handles.togglebutton_layers_original,'Visible','on');
                     set(handles.togglebutton_layers_watermarked_embed,'Visible','on');
                     set(handles.togglebutton_layers_watermarked_attacked,'Visible','on');
                     set(handles.togglebutton_layers_attacked_attacked,'Visible','on');
                     set(handles.togglebutton_layers_attacked_decode,'Visible','on');
                     
                     set(handles.togglebutton_layers_original,'Enable','on');
                     set(handles.togglebutton_layers_watermarked_embed,'Enable','on');
                     set(handles.togglebutton_layers_watermarked_attacked,'Enable','on');
                     set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
                     set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                     
                     
                     set_root_data(handles,'image_type','layered');
                     
                     new_image = make_compatible(image);
                     
                     calculate_components_original(handles,im2uint8(new_image));
                                         
                     set(handles.tab_settings,'Visible','on');
              end
     
        
             
        set(handles.axes_image_original,'Visible','on');
        axes(handles.axes_image_original);
        axis off;
        
        %initialize the radiobuttons
        
        set(handles.radiobutton_icon_rgb_original,'Value',1);
        set(handles.radiobutton_icon_rgb_original,'Enable','off');
        
        set(handles.radiobutton_rgb,'Value',1);                
        set(handles.radiobutton_ycbcr,'Value',0);
        
        set(handles.radiobutton_rgb,'Enable','off');                
        set(handles.radiobutton_ycbcr,'Enable','on');
        
        set(handles.radiobutton_on,'Enable','off');
        set(handles.radiobutton_on,'Value',1);
        
        set(handles.radiobutton_off,'Enable','on');
        set(handles.radiobutton_off,'Value',0);
        
        set_root_data(handles,'layer_settings','rgb');
        
        %initialize the togglebuttons
        set(handles.togglebutton_image_original,'Value',1);             
        set(handles.togglebutton_image_original,'Enable','off');
        
        set(handles.togglebutton_fullcolor_original,'Value',1);
        set(handles.togglebutton_fullcolor_original,'Enable','off');
        
        set(handles.togglebutton_layers_original,'Value',0);
        set(handles.togglebutton_layers_original,'Enable','on');
        
        set(handles.togglebutton_histogram_original,'Enable','on');
        set(handles.togglebutton_histogram_original,'Value',0);
        
        set(handles.togglebutton_dct_original,'Enable','on');
        set(handles.togglebutton_dct_original,'Value',0);
        
        set(handles.togglebutton_dwt_original,'Enable','on');
        set(handles.togglebutton_dwt_original,'Value',0);
        
        set(handles.togglebutton_image_watermarked_attacked,'Value',1);             
        set(handles.togglebutton_image_watermarked_attacked,'Enable','off');
        
        set(handles.togglebutton_fullcolor_watermarked_attacked,'Value',1);
        set(handles.togglebutton_fullcolor_watermarked_attacked,'Enable','off');
        
        set(handles.togglebutton_layers_watermarked_attacked,'Value',0);
        set(handles.togglebutton_layers_watermarked_attacked,'Enable','on');
        
        set(handles.togglebutton_histogram_watermarked_attacked,'Enable','on');
        set(handles.togglebutton_histogram_watermarked_attacked,'Value',0);
        
        set(handles.togglebutton_dct_watermarked_attacked,'Enable','on');
        set(handles.togglebutton_dct_watermarked_attacked,'Value',0);
        
        set(handles.togglebutton_dwt_watermarked_attacked,'Enable','on');
        set(handles.togglebutton_dwt_watermarked_attacked,'Value',0)
        
        set(handles.togglebutton_image_attacked_attacked,'Value',1);
        set(handles.togglebutton_image_attacked_attacked,'Enable','off');
        
        set(handles.togglebutton_fullcolor_attacked_attacked,'Value',1);
        set(handles.togglebutton_fullcolor_attacked_attacked,'Enable','off');
        
        set(handles.togglebutton_layers_attacked_attacked,'Value',0);
        set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
        
        set(handles.togglebutton_histogram_attacked_attacked,'Enable','on');
        set(handles.togglebutton_histogram_attacked_attacked,'Value',0);
        
        set(handles.togglebutton_dct_attacked_attacked,'Enable','on');
        set(handles.togglebutton_dct_attacked_attacked,'Value',0);
        
        set(handles.togglebutton_dwt_attacked_attacked,'Enable','on');
        set(handles.togglebutton_dwt_attacked_attacked,'Value',0)
        
        set(handles.togglebutton_image_attacked_decode,'Value',1);
        set(handles.togglebutton_image_attacked_decode,'Enable','off');
        
        set(handles.togglebutton_fullcolor_attacked_decode,'Value',1);
        set(handles.togglebutton_fullcolor_attacked_decode,'Enable','off');
        
        set(handles.togglebutton_layers_attacked_decode,'Value',0);
        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
        
        set(handles.togglebutton_histogram_attacked_decode,'Enable','on');
        set(handles.togglebutton_histogram_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dct_attacked_decode,'Enable','on');
        set(handles.togglebutton_dct_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dwt_attacked_decode,'Enable','on');
        set(handles.togglebutton_dwt_attacked_decode,'Value',0)        
        
        % main togglebuttons
        set(handles.togglebutton_embed,'Enable','off');
        set(handles.togglebutton_attack,'Enable','on');
        set(handles.togglebutton_decode,'Enable','on');
        
        set(handles.togglebutton_embed,'Value',1);
        set(handles.togglebutton_attack,'Value',0);
        set(handles.togglebutton_decode,'Value',0);
        
        set(handles.togglebutton_embed,'Visible','on');
        set(handles.togglebutton_attack,'Visible','off');
        set(handles.togglebutton_decode,'Visible','off');
        
        %initialize the tabs
        set(handles.tab_embed,'Visible','on'); 
        set(handles.tab_control,'Visible','on'); 
        set(handles.tab_attack,'Visible','off'); 
        set(handles.tab_decode,'Visible','off'); 
        set(handles.tab_original,'Visible','on');
        set(handles.tab_image_original,'Visible','on');
        set(handles.tab_layers_rgb_original,'Visible','off');
        set(handles.tab_layers_ycbcr_original,'Visible','off');
        set(handles.tab_attacked_attacked,'Visible','off');
        set(handles.tab_layers_rgb_attacked_attacked,'Visible','off');
        set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
        
        set(handles.pushbutton_overview,'Visible','off');
         end;
        
                
%% Output function
function varargout = ewat_OutputFcn(hObject, eventdata, handles) 
        varargout{1} = handles.output;
        
%% YCbCr settings
function radiobutton_ycbcr_Callback(hObject, eventdata, handles)

        change_to_ycbcr_view(handles);
        msgbox('Conversion errors will occur in the YCbCr mode','Warning: conversion errors', 'warn');

%% RGB settings
function radiobutton_rgb_Callback(hObject, eventdata, handles)

        change_to_rgb_view(handles);
        
%% Settings on
function radiobutton_on_Callback(hObject, eventdata, handles)

        set(handles.radiobutton_on,'Enable','off');
        set(handles.radiobutton_off,'Enable','on');        

        set(handles.radiobutton_on,'Value',1);
        set(handles.radiobutton_off,'Value',0);
%% Setting off
function radiobutton_off_Callback(hObject, eventdata, handles)

        set(handles.radiobutton_on,'Enable','on');
        set(handles.radiobutton_off,'Enable','off');
        
        set(handles.radiobutton_on,'Value',0);
        set(handles.radiobutton_off,'Value',1);
        
%% Watermarking GUI
function pushbutton_watermark_Callback(hObject, eventdata, handles)

        set_variables_original(handles);
        set_root_data(handles,'attack','no');
        
        set_radiobutton_all(handles);
        
        watermarking;
        
%% Attack GUI
function pushbutton_attack_Callback(hObject, eventdata, handles)
        
        set_variables_watermarked_attacked(handles);
        
        rgb_image = getimage(handles.axes_image_watermarked_attacked);
        set_root_data(handles,'plot_watermarked_attacked',rgb_image);
        
        set_root_data(handles,'attack','yes');            %reset the component
        attacks;

%% No attack        
function pushbutton_no_attack_Callback(hObject, eventdata, handles)
        
        no_attack(handles);
        
%% Decode GUI
function pushbutton_decode_Callback(hObject, eventdata, handles)

        set_variables_attacked_decode(handles);
        
        used_methode = get_root_data('watermarking_methode');
        set_root_data(handles,'title',used_methode);
        
        switch used_methode
            case 'lsb'
                no_key = get_root_data('no_key');
                if (no_key == 1)
                    LSB_DETECTOR_nokey;
                else
                    LSB_DETECTOR_key;
                end
            case 'patch'
                patch_detect;
            case 'correlation'
                correlation_detect;
            case 'dct'
                dct_detect;
            case 'dwt'
                dwt_detect;
            case 'qim'
                QIM_detect;
            case 'cdma'
                cdma_detect;
        end;
                
        
%% Embed tab
function togglebutton_embed_Callback(hObject, eventdata, handles)

        set(handles.togglebutton_embed,'Enable','off');
        set(handles.togglebutton_attack,'Enable','on');
        set(handles.togglebutton_decode,'Enable','on');

        set(handles.togglebutton_attack,'Value',0);
        set(handles.togglebutton_decode,'Value',0);
        
        set(handles.tab_embed,'Visible','on');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_decode,'Visible','off');
        
        
%% Attack tab
function togglebutton_attack_Callback(hObject, eventdata, handles) 

        set(handles.togglebutton_embed,'Enable','on');
        set(handles.togglebutton_attack,'Enable','off');
        set(handles.togglebutton_decode,'Enable','on');

        set(handles.togglebutton_embed,'Value',0);
        set(handles.togglebutton_decode,'Value',0);
        
        set(handles.tab_embed,'Visible','off');
        set(handles.tab_attack,'Visible','on');
        set(handles.tab_decode,'Visible','off');
        
%% Decode tab
function togglebutton_decode_Callback(hObject, eventdata, handles)

        set(handles.togglebutton_embed,'Enable','on');
        set(handles.togglebutton_attack,'Enable','on');
        set(handles.togglebutton_decode,'Enable','off');
        
        set(handles.togglebutton_image_attacked_decode,'Value',1);
        set(handles.togglebutton_image_attacked_decode,'Enable','off');
        
        set(handles.togglebutton_fullcolor_attacked_decode,'Value',1);
        set(handles.togglebutton_fullcolor_attacked_decode,'Enable','off');
        
        set(handles.togglebutton_layers_attacked_decode,'Value',0);
        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
        
        set(handles.togglebutton_histogram_attacked_decode,'Enable','on');
        set(handles.togglebutton_histogram_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dct_attacked_decode,'Enable','on');
        set(handles.togglebutton_dct_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dwt_attacked_decode,'Enable','on');
        set(handles.togglebutton_dwt_attacked_decode,'Value',0)       

        set(handles.togglebutton_attack,'Value',0);
        set(handles.togglebutton_embed,'Value',0);

        set(handles.tab_embed,'Visible','off');
        set(handles.tab_attack,'Visible','off');
        set(handles.tab_decode,'Visible','on');
        
        set(handles.tab_image_attacked_decode,'Visible','on');
        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');


%% Togglebutton Image original
function togglebutton_image_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_image_original(handles);
        else
            update_image_original(handles);
            update_image_watermarked_embed(handles);
        end;
        
%% Togglebutton Layers original
function togglebutton_layers_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_layers_original(handles);
        else
            update_layers_original(handles);
            update_layers_watermarked_embed(handles);
        end;
                
%% Full color event original
function togglebutton_fullcolor_original_Callback(hObject, eventdata, handles)
    
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_fullcolor_original(handles);
        else
            update_fullcolor_original(handles);
            update_fullcolor_watermarked_embed(handles);
        end;
        
%% Histogram event original
function togglebutton_histogram_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_histogram_original(handles);
        else
            update_histogram_original(handles);
            update_histogram_watermarked_embed(handles);
        end;
        
%% DCT event original
function togglebutton_dct_original_Callback(hObject, eventdata, handles)
        
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dct_original(handles);
        else
            update_dct_original(handles);
            update_dct_watermarked_embed(handles);
        end;
        
        
%% DWT event original
function togglebutton_dwt_original_Callback(hObject, eventdata, handles)
        
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dwt_original(handles);
        else
            update_dwt_original(handles);
            update_dwt_watermarked_embed(handles);
        end;
        
%% Radiobutton rgb original
function radiobutton_icon_rgb_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'rgb');
            adjust_radiobutton_state_watermarked_embed(handles,'rgb');
        else
            adjust_radiobutton_state_original(handles,'rgb');
            adjust_radiobutton_state_watermarked_embed(handles,'rgb');
        end;

        

%% Radiobutton red original
function radiobutton_layer_red_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'red');
            
        else
            adjust_radiobutton_state_original(handles,'red');
            adjust_radiobutton_state_watermarked_embed(handles,'red');
        end;

%% Radiobutton green original
function radiobutton_layer_green_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'green');
        else
            adjust_radiobutton_state_original(handles,'green');
            adjust_radiobutton_state_watermarked_embed(handles,'green');
        end;
        
%% Radiobutton blue original
function radiobutton_layer_blue_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'blue');
        else
            adjust_radiobutton_state_original(handles,'blue');
            adjust_radiobutton_state_watermarked_embed(handles,'blue');
        end;
    
%% Radiobutton YCbCr original
function radiobutton_icon_ycbcr_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'ycbcr');
        else
            adjust_radiobutton_state_original(handles,'ycbcr');
            adjust_radiobutton_state_watermarked_embed(handles,'ycbcr');
        end;

%% Radiobutton Y original
function radiobutton_layer_y_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'y');
        else
            adjust_radiobutton_state_original(handles,'y');
            adjust_radiobutton_state_watermarked_embed(handles,'y');
        end;

%% Radiobutton Cb original
function radiobutton_layer_cb_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'cb');
        else
            adjust_radiobutton_state_original(handles,'cb');
            adjust_radiobutton_state_watermarked_embed(handles,'cb');
        end;

%% Radiobutton Cr original
function radiobutton_layer_cr_original_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_original(handles,'cr');
        else
            adjust_radiobutton_state_original(handles,'cr');
            adjust_radiobutton_state_watermarked_embed(handles,'cr');
        end;

%%
function togglebutton_image_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_image_watermarked_embed(handles);
        else
            update_image_watermarked_embed(handles);
            update_image_original(handles);
        end;
%%
function togglebutton_layers_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_layers_watermarked_embed(handles);
        else
            update_layers_watermarked_embed(handles);
            update_layers_original(handles);
        end;
%%
function togglebutton_fullcolor_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_fullcolor_watermarked_embed(handles);
        else
            update_fullcolor_watermarked_embed(handles);
            update_fullcolor_original(handles);
        end;
%%
function togglebutton_histogram_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_histogram_watermarked_embed(handles);
        else
            update_histogram_watermarked_embed(handles);
            update_histogram_original(handles);
        end;
%%
function togglebutton_dct_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dct_watermarked_embed(handles);
        else
            update_dct_watermarked_embed(handles);
            update_dct_original(handles);
        end;
%%
function togglebutton_dwt_watermarked_embed_Callback(hObject, eventdata, handles)    
    
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dwt_watermarked_embed(handles);
        else
            update_dwt_watermarked_embed(handles);
            update_dwt_original(handles);
        end;
%%
function radiobutton_icon_rgb_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'rgb');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'rgb');
            adjust_radiobutton_state_original(handles,'rgb');
        end;

        
%%
function radiobutton_layer_red_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'red');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'red');
            adjust_radiobutton_state_original(handles,'red');
        end;
%%
function radiobutton_layer_green_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'green');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'green');
            adjust_radiobutton_state_original(handles,'green');
        end;
%%
function radiobutton_layer_blue_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'blue');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'blue');
            adjust_radiobutton_state_original(handles,'blue');
        end;
%%
function radiobutton_icon_ycbcr_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'ycbcr');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'ycbcr');
            adjust_radiobutton_state_original(handles,'ycbcr');
        end;
%%
function radiobutton_layer_y_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'y');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'y');
            adjust_radiobutton_state_original(handles,'y');
        end;
%%
function radiobutton_layer_cb_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'cb');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'cb');
            adjust_radiobutton_state_original(handles,'cb');
        end;
%%
function radiobutton_layer_cr_watermarked_embed_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_embed(handles,'cr');
        else
            adjust_radiobutton_state_watermarked_embed(handles,'cr');
            adjust_radiobutton_state_original(handles,'cr');
        end;
        

%% Togglebutton Image watermarked_attacked
function togglebutton_image_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_image_watermarked_attacked(handles);
        else
            update_image_watermarked_attacked(handles);
            update_image_attacked_attacked(handles);
        end;
        
%% Togglebutton Layers watermarked_attacked
function togglebutton_layers_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_layers_watermarked_attacked(handles);
        else
            update_layers_watermarked_attacked(handles);
            update_layers_attacked_attacked(handles);
        end;
                
%% Full color event watermarked_attacked
function togglebutton_fullcolor_watermarked_attacked_Callback(hObject, eventdata, handles)
    
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_fullcolor_watermarked_attacked(handles);
        else
            update_fullcolor_watermarked_attacked(handles);
            update_fullcolor_attacked_attacked(handles);
        end;
        
%% Histogram event watermarked_attacked
function togglebutton_histogram_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_histogram_watermarked_attacked(handles);
        else
            update_histogram_watermarked_attacked(handles);
            update_histogram_attacked_attacked(handles);
        end;
        
%% DCT event watermarked_attacked
function togglebutton_dct_watermarked_attacked_Callback(hObject, eventdata, handles)
        
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dct_watermarked_attacked(handles);
        else
            update_dct_watermarked_attacked(handles);
            update_dct_attacked_attacked(handles);
        end;
        
        
%% DWT event watermarked_attacked
function togglebutton_dwt_watermarked_attacked_Callback(hObject, eventdata, handles)
        
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dwt_watermarked_attacked(handles);
        else
            update_dwt_watermarked_attacked(handles);
            update_dwt_attacked_attacked(handles);
        end;
        
%% Radiobutton rgb watermarked_attacked
function radiobutton_icon_rgb_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'rgb');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'rgb');
            adjust_radiobutton_state_attacked_attacked(handles,'rgb');
        end;

        

%% Radiobutton red watermarked_attacked
function radiobutton_layer_red_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'red');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'red');
            adjust_radiobutton_state_attacked_attacked(handles,'red');
        end;

%% Radiobutton green watermarked_attacked
function radiobutton_layer_green_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'green');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'green');
            adjust_radiobutton_state_attacked_attacked(handles,'green');
        end;
        
%% Radiobutton blue watermarked_attacked
function radiobutton_layer_blue_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'blue');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'blue');
            adjust_radiobutton_state_attacked_attacked(handles,'blue');
        end;
    
%% Radiobutton YCbCr watermarked_attacked
function radiobutton_icon_ycbcr_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'ycbcr');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'ycbcr');
            adjust_radiobutton_state_attacked_attacked(handles,'ycbcr');
        end;

%% Radiobutton Y watermarked_attacked
function radiobutton_layer_y_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'y');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'y');
            adjust_radiobutton_state_attacked_attacked(handles,'y');
        end;

%% Radiobutton Cb watermarked_attacked
function radiobutton_layer_cb_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'cb');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'cb');
            adjust_radiobutton_state_attacked_attacked(handles,'cb');
        end;

%% Radiobutton Cr watermarked_attacked
function radiobutton_layer_cr_watermarked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_watermarked_attacked(handles,'cr');
        else
            adjust_radiobutton_state_watermarked_attacked(handles,'cr');
            adjust_radiobutton_state_attacked_attacked(handles,'cr');
        end;

%%
function togglebutton_image_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_image_attacked_attacked(handles);
        else
            update_image_attacked_attacked(handles);
            update_image_watermarked_attacked(handles);
        end;
%%
function togglebutton_layers_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_layers_attacked_attacked(handles);
        else
            update_layers_attacked_attacked(handles);
            update_layers_watermarked_attacked(handles);
        end;
%%
function togglebutton_fullcolor_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_fullcolor_attacked_attacked(handles);
        else
            update_fullcolor_attacked_attacked(handles);
            update_fullcolor_watermarked_attacked(handles);
        end;
%%
function togglebutton_histogram_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_histogram_attacked_attacked(handles);
        else
            update_histogram_attacked_attacked(handles);
            update_histogram_watermarked_attacked(handles);
        end;
%%
function togglebutton_dct_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dct_attacked_attacked(handles);
        else
            update_dct_attacked_attacked(handles);
            update_dct_watermarked_attacked(handles);
        end;
%%
function togglebutton_dwt_attacked_attacked_Callback(hObject, eventdata, handles)    
    
        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            update_dwt_attacked_attacked(handles);
        else
            update_dwt_attacked_attacked(handles);
            update_dwt_watermarked_attacked(handles);
        end;
%%
function radiobutton_icon_rgb_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'rgb');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'rgb');
            adjust_radiobutton_state_watermarked_attacked(handles,'rgb');
        end;

        
%%
function radiobutton_layer_red_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'red');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'red');
            adjust_radiobutton_state_watermarked_attacked(handles,'red');
        end;
%%
function radiobutton_layer_green_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'green');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'green');
            adjust_radiobutton_state_watermarked_attacked(handles,'green');
        end;
%%
function radiobutton_layer_blue_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'blue');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'blue');
            adjust_radiobutton_state_watermarked_attacked(handles,'blue');
        end;
%%
function radiobutton_icon_ycbcr_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'ycbcr');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'ycbcr');
            adjust_radiobutton_state_watermarked_attacked(handles,'ycbcr');
        end;
%%
function radiobutton_layer_y_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'y');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'y');
            adjust_radiobutton_state_watermarked_attacked(handles,'y');
        end;
%%
function radiobutton_layer_cb_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'cb');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'cb');
            adjust_radiobutton_state_watermarked_attacked(handles,'cb');
        end;
%%
function radiobutton_layer_cr_attacked_attacked_Callback(hObject, eventdata, handles)

        setting = get(handles.radiobutton_on,'Value');

        if setting == 0.0
            adjust_radiobutton_state_attacked_attacked(handles,'cr');
        else
            adjust_radiobutton_state_attacked_attacked(handles,'cr');
            adjust_radiobutton_state_watermarked_attacked(handles,'cr');
        end;
        
%% Decode tab setting
%%
function togglebutton_image_attacked_decode_Callback(hObject, eventdata, handles)

        update_image_attacked_decode(handles);
%%
function togglebutton_layers_attacked_decode_Callback(hObject, eventdata, handles)

        update_layers_attacked_decode(handles);
%%
function togglebutton_fullcolor_attacked_decode_Callback(hObject, eventdata, handles)

        update_fullcolor_attacked_decode(handles);
%%
function togglebutton_histogram_attacked_decode_Callback(hObject, eventdata, handles)

        update_histogram_attacked_decode(handles);
%%
function togglebutton_dct_attacked_decode_Callback(hObject, eventdata, handles)

        update_dct_attacked_decode(handles);
%%
function togglebutton_dwt_attacked_decode_Callback(hObject, eventdata, handles)    
    
        update_dwt_attacked_decode(handles);
%%
function radiobutton_icon_rgb_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'rgb');
%%
function radiobutton_layer_red_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'red');
%%
function radiobutton_layer_green_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'green');
%%
function radiobutton_layer_blue_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'blue');
%%
function radiobutton_icon_ycbcr_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'ycbcr');
%%
function radiobutton_layer_y_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'y');
%%
function radiobutton_layer_cb_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'cb');
%%
function radiobutton_layer_cr_attacked_decode_Callback(hObject, eventdata, handles)

        adjust_radiobutton_state_attacked_decode(handles,'cr');

%% Overview
function pushbutton_overview_Callback(hObject, eventdata, handles)

        overview;

%%
function edit_decoded_information_Callback(hObject, eventdata, handles)

function edit_decoded_information_CreateFcn(hObject, eventdata, handles)

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
%% Save watermarked        
function pushbutton_save_watermarked_embed_Callback(hObject, eventdata, handles)

        image_type = get_root_data('image_type');

        switch image_type
            case 'grayscale'
                image_save = get_root_data('watermarked_embed_plot_grayscale');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;

            case 'layered'
                image_save = get_root_data('watermarked_embed_plot_rgb');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;
        end;
        
function pushbutton_save_watermarked_attacked_Callback(hObject, eventdata, handles)

        image_type = get_root_data('image_type');

        switch image_type
            case 'grayscale'
                image_save = get_root_data('watermarked_attacked_plot_grayscale');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;

            case 'layered'
                image_save = get_root_data('watermarked_attacked_plot_rgb');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;
        end;

function pushbutton_save_attacked_attacked_Callback(hObject, eventdata, handles)
        
        image_type = get_root_data('image_type');

        switch image_type
            case 'grayscale'
                image_save = get_root_data('attacked_attacked_plot_grayscale');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;

            case 'layered'
                image_save = get_root_data('attacked_attacked_plot_rgb');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;
        end;

% --- Executes on button press in pushbutton_save_attacked_decoded.
function pushbutton_save_attacked_decoded_Callback(hObject, eventdata, handles)
        
        image_type = get_root_data('image_type');

        switch image_type
            case 'grayscale'
                image_save = get_root_data('attacked_decoded_plot_grayscale');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;

            case 'layered'
                image_save = get_root_data('attacked_decoded_plot_rgb');

                [filename, pathname, index] = uiputfile( ...
                 {'*.bmp';' *.jpg';'*.gif';'*.png';'*.tif'}, ...
                 'Save image');

                if filename == 0
                   msgbox('The image is not saved','Warning','info');
                else
                   ext = extension(index);
                   imwrite(image_save, strcat(pathname, '\', filename, ext));   
                end;
        end;

function pushbutton_browse_info_Callback(hObject, eventdata, handles)

    msgbox('Choose an image that you want to use for watermarking. The image has to be at least 256 x 256.','Help','help'); 

function pushbutton_representation_info_Callback(hObject, eventdata, handles)

    msgbox('Here you can select how the image wel be showed. You can choose between RGB and YCbCr.','Help','help');  

function pushbutton_setting_info_Callback(hObject, eventdata, handles)

    msgbox('Here you can choose to link the different controls of the GUI. When Link Control is turned off, the left and right image can be controlled separately. When turned on, the left and right image will be controlled simultaneous.','Help','help');

function pushbutton_embed_info_Callback(hObject, eventdata, handles)
    
    msgbox('In this part of the GUI you can view and compare the original image to the watermarked image.','Help','help');

function pushbutton_attack_info_Callback(hObject, eventdata, handles)
    
    msgbox('In this part of the GUI you can view and compare the watermarked image to the attacked image.','Help','help');

function pushbutton_decode_info_Callback(hObject, eventdata, handles)
    
    msgbox('In this part of the GUI you can view the attacked image and compare to the message extracted from it.','Help','help');

%% manual
function pushbutton_manual_Callback(hObject, eventdata, handles)

    open('E-Wat_User_guide.pdf');

%% close
function pushbutton_close_Callback(hObject, eventdata, handles)

        close();

function pushbutton_about_Callback(hObject, eventdata, handles)

    About;
