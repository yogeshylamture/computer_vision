function tab_attack(handles,type)

switch type
    case 'initialize' 
        %buttons
        set(handles.btn_tab_compression,'Value',1.0);
        set(handles.btn_tab_compression,'Enable','off');
        set(handles.btn_tab_color_manipulation,'Value',0.0);
        set(handles.btn_tab_color_manipulation,'Enable','on');
        set(handles.btn_tab_enhancements,'Value',0.0);
        set(handles.btn_tab_enhancements,'Enable','on');
        set(handles.btn_tab_geometric,'Value',0.0);
        set(handles.btn_tab_geometric,'Enable','on');
        set(handles.btn_tab_noise,'Value',0.0);
        set(handles.btn_tab_noise,'Enable','on');
        
        %tabs
        set(handles.tab_compression,'Visible','on');
        set(handles.tab_color_manipulation,'Visible','off');
        set(handles.tab_enhancements,'Visible','off');
        set(handles.tab_geometric,'Visible','off');
        set(handles.tab_noise,'Visible','off');
    case 'compression'
        %buttons
        set(handles.btn_tab_compression,'Value',1.0);
        set(handles.btn_tab_compression,'Enable','off');
        set(handles.btn_tab_color_manipulation,'Value',0.0);
        set(handles.btn_tab_color_manipulation,'Enable','on');
        set(handles.btn_tab_enhancements,'Value',0.0);
        set(handles.btn_tab_enhancements,'Enable','on');
        set(handles.btn_tab_geometric,'Value',0.0);
        set(handles.btn_tab_geometric,'Enable','on');
        set(handles.btn_tab_noise,'Value',0.0);
        set(handles.btn_tab_noise,'Enable','on');
        
        %tabs
        set(handles.tab_compression,'Visible','on');
        set(handles.tab_color_manipulation,'Visible','off');
        set(handles.tab_enhancements,'Visible','off');
        set(handles.tab_geometric,'Visible','off');
        set(handles.tab_noise,'Visible','off');
    case 'color manipulation'
        %buttons
        set(handles.btn_tab_compression,'Value',0.0);
        set(handles.btn_tab_compression,'Enable','on');
        set(handles.btn_tab_color_manipulation,'Value',1.0);
        set(handles.btn_tab_color_manipulation,'Enable','off');
        set(handles.btn_tab_enhancements,'Value',0.0);
        set(handles.btn_tab_enhancements,'Enable','on');
        set(handles.btn_tab_geometric,'Value',0.0);
        set(handles.btn_tab_geometric,'Enable','on');
        set(handles.btn_tab_noise,'Value',0.0);
        set(handles.btn_tab_noise,'Enable','on');
        
        %tabs
        set(handles.tab_compression,'Visible','off');
        set(handles.tab_color_manipulation,'Visible','on');
        set(handles.tab_enhancements,'Visible','off');
        set(handles.tab_geometric,'Visible','off');
        set(handles.tab_noise,'Visible','off');
    case 'enhancements'
        %buttons
        set(handles.btn_tab_compression,'Value',0.0);
        set(handles.btn_tab_compression,'Enable','on');
        set(handles.btn_tab_color_manipulation,'Value',0.0);
        set(handles.btn_tab_color_manipulation,'Enable','on');
        set(handles.btn_tab_enhancements,'Value',1.0);
        set(handles.btn_tab_enhancements,'Enable','off');
        set(handles.btn_tab_geometric,'Value',0.0);
        set(handles.btn_tab_geometric,'Enable','on');
        set(handles.btn_tab_noise,'Value',0.0);
        set(handles.btn_tab_noise,'Enable','on');
        
        %tabs
        set(handles.tab_compression,'Visible','off');
        set(handles.tab_color_manipulation,'Visible','off');
        set(handles.tab_enhancements,'Visible','on');
        set(handles.tab_geometric,'Visible','off');
        set(handles.tab_noise,'Visible','off');
    case 'geometric'
        %buttons
        set(handles.btn_tab_compression,'Value',0.0);
        set(handles.btn_tab_compression,'Enable','on');
        set(handles.btn_tab_color_manipulation,'Value',0.0);
        set(handles.btn_tab_color_manipulation,'Enable','on');
        set(handles.btn_tab_enhancements,'Value',0.0);
        set(handles.btn_tab_enhancements,'Enable','on');
        set(handles.btn_tab_geometric,'Value',1.0);
        set(handles.btn_tab_geometric,'Enable','off');
        set(handles.btn_tab_noise,'Value',0.0);
        set(handles.btn_tab_noise,'Enable','on');
        
        %tabs
        set(handles.tab_compression,'Visible','off');
        set(handles.tab_color_manipulation,'Visible','off');
        set(handles.tab_enhancements,'Visible','off');
        set(handles.tab_geometric,'Visible','on');
        set(handles.tab_noise,'Visible','off');
    case 'noise'
        %buttons
        set(handles.btn_tab_compression,'Value',0.0);
        set(handles.btn_tab_compression,'Enable','on');
        set(handles.btn_tab_color_manipulation,'Value',0.0);
        set(handles.btn_tab_color_manipulation,'Enable','on');
        set(handles.btn_tab_enhancements,'Value',0.0);
        set(handles.btn_tab_enhancements,'Enable','on');
        set(handles.btn_tab_geometric,'Value',0.0);
        set(handles.btn_tab_geometric,'Enable','on');
        set(handles.btn_tab_noise,'Value',1.0);
        set(handles.btn_tab_noise,'Enable','off');
        
        %tabs
        set(handles.tab_compression,'Visible','off');
        set(handles.tab_color_manipulation,'Visible','off');
        set(handles.tab_enhancements,'Visible','off');
        set(handles.tab_geometric,'Visible','off');
        set(handles.tab_noise,'Visible','on');
end
