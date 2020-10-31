function adjust_radiobutton_state_original(handles,radiobutton)

switch radiobutton
    case 'rgb'
        set(handles.radiobutton_icon_rgb_original,'Enable','off');
        set(handles.radiobutton_icon_rgb_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
        
    case 'red'
        set(handles.radiobutton_layer_red_original,'Enable','off');
        set(handles.radiobutton_layer_red_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'green'
        set(handles.radiobutton_layer_green_original,'Enable','off');
        set(handles.radiobutton_layer_green_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'blue'
        set(handles.radiobutton_layer_blue_original,'Enable','off');
        set(handles.radiobutton_layer_blue_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'ycbcr'
        set(handles.radiobutton_icon_ycbcr_original,'Enable','off');
        set(handles.radiobutton_icon_ycbcr_original,'Value',1);
        
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'y'
        set(handles.radiobutton_layer_y_original,'Enable','off');
        set(handles.radiobutton_layer_y_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'cb'
        set(handles.radiobutton_layer_cb_original,'Enable','off');
        set(handles.radiobutton_layer_cb_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        set(handles.radiobutton_layer_cr_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_icon_rgb_original,'Value',0);
        set(handles.radiobutton_layer_cr_original,'Value',0);
    case 'cr'
        set(handles.radiobutton_layer_cr_original,'Enable','off');
        set(handles.radiobutton_layer_cr_original,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_original,'Enable','on');
        set(handles.radiobutton_layer_red_original,'Enable','on');
        set(handles.radiobutton_layer_green_original,'Enable','on');
        set(handles.radiobutton_layer_blue_original,'Enable','on');
        set(handles.radiobutton_layer_y_original,'Enable','on');
        set(handles.radiobutton_layer_cb_original,'Enable','on');
        set(handles.radiobutton_icon_rgb_original,'Enable','on');
        
        set(handles.radiobutton_layer_red_original,'Value',0);
        set(handles.radiobutton_layer_green_original,'Value',0);
        set(handles.radiobutton_layer_blue_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Value',0);
        set(handles.radiobutton_layer_y_original,'Value',0);
        set(handles.radiobutton_layer_cb_original,'Value',0);
        set(handles.radiobutton_icon_rgb_original,'Value',0);
end