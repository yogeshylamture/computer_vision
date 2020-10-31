function update_layers_attacked_decode(handles)

settings = get(handles.radiobutton_ycbcr,'Value');
full_color = get(handles.togglebutton_fullcolor_attacked_decode,'Value');

switch full_color
    case 1.0 %%fullcolor is pushed
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                set(handles.tab_image_attacked_decode,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_layer_y_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_layer_cb_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_layer_cr_attacked_decode,'Visible','on');
                
%                 
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                set(handles.tab_layers_rgb_attacked_decode,'Visible','on');
                set(handles.tab_image_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','on');
                                
                set(handles.radiobutton_layer_red_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_green_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_layer_blue_attacked_decode,'Visible','on');
        end;
    case 0.0  %%everthing else
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                set(handles.tab_image_attacked_decode,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','on');
                
                set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_layer_y_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_layer_cb_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_layer_cr_attacked_decode,'Visible','off');
                
%                 
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                set(handles.tab_layers_rgb_attacked_decode,'Visible','on');
                set(handles.tab_image_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','off');
                                
                set(handles.radiobutton_layer_red_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_layer_green_attacked_decode,'Visible','off');
                
                set(handles.radiobutton_layer_blue_attacked_decode,'Visible','off');
        end;
end;
        
        set(handles.togglebutton_image_attacked_decode,'Value',0);
        set(handles.togglebutton_image_attacked_decode,'Enable','on');
        set(handles.togglebutton_layers_attacked_decode,'Enable','off');
          
        set(handles.tab_image_attacked_decode,'Visible','off');