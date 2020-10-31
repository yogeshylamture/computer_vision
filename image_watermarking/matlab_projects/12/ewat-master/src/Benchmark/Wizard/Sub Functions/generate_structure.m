function generate_structure(handles,type)

switch type
    case 'Input'
        
    case 'Watermark'
        
        scheme_value = get(handles.popup_scheme,'Value');
        scheme_list = get(handles.popup_scheme,'String');
        scheme_name = char(scheme_list(scheme_value,1));
        
        domain_value = get(handles.popup_domain,'Value');
        domain_list = get(handles.popup_domain,'String');
        domain_name = char(domain_list(domain_value,1)); 
        
        embed_value = get(handles.popup_embed_watermark,'Value');
        embed_list = get(handles.popup_embed_watermark,'String');
        embed_name = char(embed_list(embed_value,1)); 
        
        detect_value = get(handles.popup_detect_watermark,'Value');
        detect_list = get(handles.popup_detect_watermark,'String');
        detect_name = char(detect_list(detect_value,1));
        
        embed_parameters = get_root_data('embed_parameters');
        detect_parameters = get_root_data('detect_parameters');
        
        watermark_parameters = struct('scheme',scheme_name,'domain',domain_name,'embed_algorithm',embed_name,'embed_parameters',embed_parameters,'detect_algorithm',detect_name,'detect_parameters',detect_parameters)
        
        set_root_data(handles,'watermark_parameters',watermark_parameters);
        
    case 'Parameters'
    case 'Attack'
end