function update_layers_watermarked_embed(handles)

settings = get(handles.radiobutton_ycbcr,'Value');
full_color = get(handles.togglebutton_fullcolor_watermarked_embed,'Value');

switch full_color
    case 1.0 %%fullcolor is pushed
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','off');
                set(handles.tab_image_watermarked_embed,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','on');
                
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','on');
                set(handles.tab_image_watermarked_embed,'Visible','off');
                
        end;
    case 0.0  %%everthing else
        switch settings
            case 1.0            % ycbcr is selected
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','off');
                set(handles.tab_image_watermarked_embed,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','on');
                
            case 0.0            %rgb is selected
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','on');
                set(handles.tab_image_watermarked_embed,'Visible','off');
                
        end;
end;
        
        set(handles.togglebutton_image_watermarked_embed,'Value',0);
        set(handles.togglebutton_image_watermarked_embed,'Enable','on');
        set(handles.togglebutton_layers_watermarked_embed,'Value',1);
        set(handles.togglebutton_layers_watermarked_embed,'Enable','off');
          
        set(handles.tab_image_watermarked_embed,'Visible','off');