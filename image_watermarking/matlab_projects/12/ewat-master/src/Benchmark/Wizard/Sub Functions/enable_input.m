function enable_input(handles)

        set(handles.popup_spectrum,'Enable','on');
        set(handles.popup_layer,'Enable','on');
        
        set(handles.input_message,'Enable','on');
        set(handles.popup_key_size,'Enable','on');
        
        set(handles.checkbox_input_done,'Enable','on');
        
        set(handles.btn_load,'Enable','on');
        set(handles.btn_image_dataset,'Enable','on');
        set(handles.tab_summary_input,'Visible','off');
        set(handles.tab_key,'Visible','on');
        
        