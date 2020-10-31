function update_layers_attacked_attacked(handles)

settings = get(handles.radiobutton_ycbcr,'Value');
full_color = get(handles.togglebutton_fullcolor_attacked_attacked,'Value');

switch full_color
    case 1.0 %%fullcolor is pushed
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','off');
                set(handles.tab_image_attacked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_icon_ycbcr_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_layer_y_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_layer_cb_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_layer_cr_attacked_attacked,'Visible','on');
                
%                 
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','on');
                set(handles.tab_image_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_icon_rgb_attacked_attacked,'Visible','on');
                                
                set(handles.radiobutton_layer_red_attacked_attacked,'Visible','on');
                 
                set(handles.radiobutton_layer_green_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_layer_blue_attacked_attacked,'Visible','on');
        end;
    case 0.0  %%everthing else
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','off');
                set(handles.tab_image_attacked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','on');
                
                set(handles.radiobutton_icon_ycbcr_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_layer_y_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_layer_cb_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_layer_cr_attacked_attacked,'Visible','off');
                
%                 
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','on');
                set(handles.tab_image_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_icon_rgb_attacked_attacked,'Visible','off');
                                
                set(handles.radiobutton_layer_red_attacked_attacked,'Visible','off');
                 
                set(handles.radiobutton_layer_green_attacked_attacked,'Visible','off');
                
                set(handles.radiobutton_layer_blue_attacked_attacked,'Visible','off');
        end;
end;
        
        set(handles.togglebutton_image_attacked_attacked,'Value',0);
        set(handles.togglebutton_image_attacked_attacked,'Enable','on');
        set(handles.togglebutton_layers_attacked_attacked,'Enable','off');
        set(handles.togglebutton_layers_attacked_attacked,'Value',1);
        
        
        set(handles.tab_image_attacked_attacked,'Visible','off');