function update_image_watermarked_attacked(handles)

        
                set(handles.togglebutton_layers_watermarked_attacked,'Value',0);
                set(handles.togglebutton_layers_watermarked_attacked,'Enable','on');
                set(handles.togglebutton_image_watermarked_attacked,'Enable','off');
                set(handles.togglebutton_image_watermarked_attacked,'Value',1);
                
                set(handles.tab_image_watermarked_attacked,'Visible','on');
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');
                
               