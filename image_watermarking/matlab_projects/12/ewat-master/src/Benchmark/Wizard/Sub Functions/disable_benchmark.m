function disable_benchmark(handles)

        set(handles.btn_benchmark,'Enable','off');
        set(handles.radiobutton_matlab,'Enable','off');
        set(handles.radiobutton_basic_pdf,'Enable','off');
        set(handles.radiobutton_basic_html,'Enable','off');
        set(handles.radiobutton_basic_doc,'Enable','off');
        set(handles.radiobutton_advanced_pdf,'Enable','off');
        set(handles.radiobutton_advanced_html,'Enable','off');
        set(handles.radiobutton_advanced_doc,'Enable','off');
        set(handles.btn_view_results,'Enable','off');
        
        