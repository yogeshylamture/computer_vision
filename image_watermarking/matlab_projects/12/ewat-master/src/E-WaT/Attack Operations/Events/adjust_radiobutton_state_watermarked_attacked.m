function adjust_radiobutton_state_watermarked_attacked(handles,radiobutton)

switch radiobutton
    case 'rgb'
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
        
    case 'red'
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'green'
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'blue'
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'ycbcr'
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'y'
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'cb'
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
    case 'cr'
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Enable','off');
        set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',1);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_y_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Enable','on');
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','on');
        
        set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
        set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
        set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',0);
end