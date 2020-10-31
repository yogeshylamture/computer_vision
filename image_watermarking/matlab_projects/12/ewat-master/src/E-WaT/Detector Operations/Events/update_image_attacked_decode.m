function update_image_attacked_decode(handles)

        
                set(handles.togglebutton_layers_attacked_decode,'Value',0);
                set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                set(handles.togglebutton_image_attacked_decode,'Enable','off');
                
                set(handles.tab_image_attacked_decode,'Visible','on');
                set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                
                selected = get(handles.radiobutton_rgb,'Value');
                
                if selected == 1.0      %rgb is selected
                    set(handles.radiobutton_icon_rgb_attacked_decode,'Value',1);
                    set(handles.radiobutton_icon_rgb_attacked_decode,'Enable','off');
                else
                    set(handles.radiobutton_icon_ycbcr_attacked_decode,'Value',1);
                    set(handles.radiobutton_icon_ycbcr_attacked_decode,'Enable','off');
                end;
        

        