function update_layers_watermarked_attacked(handles)

settings = get(handles.radiobutton_ycbcr,'Value');
full_color = get(handles.togglebutton_fullcolor_watermarked_attacked,'Value');

switch full_color
    case 1.0 %%fullcolor is pushed
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','off');
                set(handles.tab_image_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','on');
                
                
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','on');
                set(handles.tab_image_watermarked_attacked,'Visible','off');
                
                
        end;
    case 0.0  %%everthing else
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','off');
                set(handles.tab_image_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','on');
                
                
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','on');
                set(handles.tab_image_watermarked_attacked,'Visible','off');
                
                
        end;
end;
        
        set(handles.togglebutton_image_watermarked_attacked,'Value',0);
        set(handles.togglebutton_image_watermarked_attacked,'Enable','on');
        set(handles.togglebutton_layers_watermarked_attacked,'Enable','off');
        set(handles.togglebutton_layers_watermarked_attacked,'Value',1);
          
        set(handles.tab_image_watermarked_attacked,'Visible','off');