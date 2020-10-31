function enable_attack(handles)

    set(handles.popup_profile,'Enable','on');
    
    set(handles.tab_compression,'Visible','on');
    
    set(handles.btn_tab_geometric,'Visible','on');
    set(handles.btn_tab_compression,'Visible','on');
    set(handles.btn_tab_noise,'Visible','on');
    set(handles.btn_tab_color_manipulation,'Visible','on');
    set(handles.btn_tab_enhancements,'Visible','on');
    
    set(handles.btn_tab_geometric,'Enable','on');
    set(handles.btn_tab_compression,'Enable','off');
    set(handles.btn_tab_noise,'Enable','on');
    set(handles.btn_tab_color_manipulation,'Enable','on');
    set(handles.btn_tab_enhancements,'Enable','on');
    
    set(handles.btn_tab_geometric,'Value',0.0);
    set(handles.btn_tab_compression,'Value',0.0);
    set(handles.btn_tab_noise,'Value',1.0);
    set(handles.btn_tab_color_manipulation,'Value',0.0);
    set(handles.btn_tab_enhancements,'Value',0.0);