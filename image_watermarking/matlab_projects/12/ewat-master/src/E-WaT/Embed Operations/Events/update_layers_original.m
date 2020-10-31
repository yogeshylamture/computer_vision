function update_layers_original(handles)

settings = get(handles.radiobutton_ycbcr,'Value');
full_color = get(handles.togglebutton_fullcolor_original,'Value');

switch full_color
    case 1.0 %%fullcolor is pushed
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_original,'Visible','off');
                set(handles.tab_image_original,'Visible','off');
                set(handles.tab_layers_ycbcr_original,'Visible','on');
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_original,'Visible','off');
                set(handles.tab_layers_rgb_original,'Visible','on');
                set(handles.tab_image_original,'Visible','off');
                
        end;
    case 0.0  %%everthing else
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_original,'Visible','off');
                set(handles.tab_image_original,'Visible','off');
                set(handles.tab_layers_ycbcr_original,'Visible','on');
                
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_original,'Visible','off');
                set(handles.tab_layers_rgb_original,'Visible','on');
                set(handles.tab_image_original,'Visible','off');
        end;
end;
        
        set(handles.togglebutton_image_original,'Value',0);
        set(handles.togglebutton_image_original,'Enable','on');
        set(handles.togglebutton_layers_original,'Value',1);
        set(handles.togglebutton_layers_original,'Enable','off');
          
        set(handles.tab_image_original,'Visible','off');