function update_image_original(handles)

        
                set(handles.togglebutton_layers_original,'Value',0);
                set(handles.togglebutton_layers_original,'Enable','on');
                set(handles.togglebutton_image_original,'Enable','off');
                set(handles.togglebutton_image_original,'Value',1);
                
                set(handles.tab_image_original,'Visible','on');
                set(handles.tab_layers_rgb_original,'Visible','off');
                set(handles.tab_layers_ycbcr_original,'Visible','off');
                
               