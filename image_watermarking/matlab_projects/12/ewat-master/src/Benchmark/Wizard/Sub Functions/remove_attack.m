function remove_attack(handles,attack_type)

    set_btn = strcat('handles.btn_edit_',attack_type);
    get_value = strcat('handles.txt_value_',attack_type);
    set(eval(set_btn),'Enable','off');
    set(eval(set_btn),'String','Edit');
    value_type = get(eval(get_value),'String'); 
    
    iMark_script = get_root_data('iMark_script');
    attack_parameters =iMark_script.attack_parameters;
    attack_parameters = rmfield(attack_parameters,attack_type);
    iMark_script = setfield(iMark_script,'attack_parameters',attack_parameters);
    
    set_root_data(handles,'iMark_script',iMark_script);
    
    