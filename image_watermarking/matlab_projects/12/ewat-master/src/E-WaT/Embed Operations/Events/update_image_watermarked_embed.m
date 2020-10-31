function update_image_watermarked_embed(handles)

        
                set(handles.togglebutton_layers_watermarked_embed,'Value',0);
                set(handles.togglebutton_layers_watermarked_embed,'Enable','on');
                set(handles.togglebutton_image_watermarked_embed,'Enable','off');
                set(handles.togglebutton_image_watermarked_embed,'Value',1);
                
                set(handles.tab_image_watermarked_embed,'Visible','on');
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');
                
               