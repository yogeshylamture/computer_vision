function disable_input(handles)

        set(handles.tab_axes_image,'Visible','on');
        set(handles.tab_summary_input,'Visible','on');
        
        set(handles.btn_load,'Enable','off');
        set(handles.btn_image_dataset,'Enable','off');
        
        set(handles.popup_spectrum,'Enable','off');
        set(handles.popup_layer,'Enable','off');
        set(handles.popup_key_size,'Enable','off');
        
        
        set(handles.input_message,'Enable','off');
        
        set(handles.btn_next_input,'Enable','on');
        