function update_image_attacked_attacked(handles)

        
                set(handles.togglebutton_layers_attacked_attacked,'Value',0);
                set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
                set(handles.togglebutton_image_attacked_attacked,'Enable','off');
                set(handles.togglebutton_image_attacked_attacked,'Value',1);
                
                set(handles.tab_image_attacked_attacked,'Visible','on');
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
                
                
        

        