function set_ui(handles,property)

switch property
    case 'initialize'
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.txt_parameter_name,'Enable','on');
        set(handles.checkbox_name_done,'Value',0);
        
        set(handles.popup_type,'Enable','off');
        set(handles.popup_value,'Enable','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
        
        set(handles.btn_remove_specified_integer,'Enable','off');
        set(handles.btn_up_specified_integer,'Enable','off');
        set(handles.btn_down_specified_integer,'Enable','off');
        
        set(handles.btn_remove_specified_double,'Enable','off');
        set(handles.btn_up_specified_double,'Enable','off');
        set(handles.btn_down_specified_double,'Enable','off');
        
        set(handles.btn_remove_specified_string,'Enable','off');
        set(handles.btn_up_specified_string,'Enable','off');
        set(handles.btn_down_specified_string,'Enable','off');
        
        set(handles.popup_type,'Value',1);
        set(handles.popup_value,'Value',1);
        
        
    case 'done_name'
        
        set(handles.txt_parameter_name,'Enable','off');
        set(handles.btn_next,'Enable','off');
        
        set(handles.popup_type,'Enable','on');
        
        set(handles.popup_value,'Enable','on');
        
        set(handles.tab_fixed_integer,'Visible','on');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
    case 'reset'
        
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.txt_parameter_name,'Enable','on');
        
        set(handles.popup_type,'Enable','off');
        set(handles.popup_value,'Enable','off');
        
        set(handles.popup_type,'Value',1);
        set(handles.popup_value,'Value',1);
        
        set(handles.popup_value,'string',strvcat('Static','Linear','Specified'));
        set(handles.popup_type,'string',strvcat('Integer','Double','String'));
        
    case 'clear values'
        set(handles.txt_fixed_integer,'String','');
        set(handles.label_fixed_integer,'Visible','off');
        
        set(handles.txt_fixed_double,'String','');
        set(handles.label_fixed_double,'Visible','off');
        
        set(handles.txt_fixed_string,'String','');
        set(handles.label_fixed_string,'Visible','off');
        
        
        set(handles.txt_start_integer,'String','');
        set(handles.txt_step_integer,'String','');
        set(handles.txt_end_integer,'String','');
        set(handles.label_linear_integer,'Visible','off');
                
        set(handles.txt_start_double,'String','');
        set(handles.txt_step_double,'String','');
        set(handles.txt_end_double,'String','');
        set(handles.label_linear_double,'Visible','off');
        
        
        set(handles.txt_specified_integer,'String','');
        set(handles.listbox_integer,'String','');
        set(handles.label_list_specified,'String','');
        
        
        set(handles.txt_specified_double,'String','');
        set(handles.listbox_double,'String','');
        
        set(handles.txt_specified_string,'String','');
        set(handles.listbox_string,'String','');
        
        
        
    case 'fixed integer'
        set(handles.tab_fixed_integer,'Visible','on');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'linear integer'
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','on');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'specified integer'
        string = get(handles.txt_parameter_name,'String');
        set(handles.label_list_specified,'String',[string, ':']);
               
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','on');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'fixed double'
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','on');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'linear double'
        
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','on');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'specified double'
        string = get(handles.txt_parameter_name,'String');
        set(handles.label_list_specified,'String',[string, ':']);
        
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','on');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'fixed string'
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','on');
        set(handles.tab_specified_string,'Visible','off');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
    case 'specified string'
        string = get(handles.txt_parameter_name,'String');
        set(handles.label_list_specified,'String',[string, ':']);
        
        set(handles.tab_fixed_integer,'Visible','off');
        set(handles.tab_linear_integer,'Visible','off');
        set(handles.tab_specified_integer,'Visible','off');
        
        set(handles.tab_fixed_double,'Visible','off');
        set(handles.tab_linear_double,'Visible','off');
        set(handles.tab_specified_double,'Visible','off');
        
        set(handles.tab_fixed_string,'Visible','off');
        set(handles.tab_specified_string,'Visible','on');
        
        set(handles.btn_back,'Visible','off');
        set(handles.btn_next,'Enable','off');
end