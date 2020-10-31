function set_profile(handles,profile)
iMark_script = get_root_data('iMark_script');
attack_parameters = struct;
iMark_script = setfield(iMark_script,'attack_parameters',attack_parameters);
set_root_data(handles,'iMark_script',iMark_script);
switch profile
    case 'iMark'
        %Compression
        set(handles.checkbox_jpg,'Value',1);
        set(handles.btn_edit_jpg,'Enable','on');
        set(handles.txt_value_jpg,'String','[60;100;10]');
        add_attack(handles,'jpg');
        
        set(handles.checkbox_color_reduction,'Value',1);
        set(handles.btn_edit_color_reduction,'Enable','on');
        set(handles.txt_value_color_reduction,'String','[0.1;0.4;0.1]');
        add_attack(handles,'color_reduction');
        
        %Noise
        set(handles.checkbox_gaussian_noise,'Value',1);
        set(handles.btn_edit_gaussian_noise,'Enable','on');
        set(handles.txt_value_gaussian_noise,'String','[0.0025;0.02;0.0025]');
        add_attack(handles,'gaussian_noise');
        
        set(handles.checkbox_bitplane,'Value',1);
        set(handles.btn_edit_bitplane,'Enable','on');
        set(handles.txt_value_bitplane,'String','[7 6 5]');
        add_attack(handles,'bitplane');
        
        %Enhancments
        set(handles.checkbox_blur,'Value',1);
        set(handles.btn_edit_blur,'Enable','on');
        set(handles.txt_value_blur,'String','[3;15;3]');
        add_attack(handles,'blur');
        
        set(handles.checkbox_contrast,'Value',1);
        set(handles.btn_edit_contrast,'Enable','on');
        set(handles.txt_value_contrast,'String','[0.1; 0.4; 0.1]');
        add_attack(handles,'contrast');
        
        set(handles.checkbox_brighten,'Value',1);
        set(handles.btn_edit_brighten,'Enable','on');
        set(handles.txt_value_brighten,'String','[3; 12; 3]');
        add_attack(handles,'brighten');
        
        %Geometric
        set(handles.checkbox_rotation,'Value',1);
        set(handles.btn_edit_rotation,'Enable','on');
        set(handles.txt_value_rotation,'String','[-2 -0.5 0.5 2]');
        add_attack(handles,'rotation');
        
        set(handles.checkbox_crop,'Value',1);
        set(handles.btn_edit_crop,'Enable','on');
        set(handles.txt_value_crop,'String','[5; 25; 5]');
        add_attack(handles,'crop');
        
        set(handles.checkbox_flip,'Value',1);
        set(handles.txt_value_flip,'String','[1 2]');
        add_attack(handles,'flip');
        
        
        set(handles.checkbox_scale,'Value',1);
        set(handles.btn_edit_scale,'Enable','on');
        set(handles.txt_value_scale,'String','[5; 25; 5]');
        add_attack(handles,'scale');
    case 'Color Manipulations'
        set(handles.checkbox_red,'Value',1);
        set(handles.btn_edit_red,'Enable','on');
        set(handles.txt_value_red,'String','[-15;15;3]');
        add_attack(handles,'red');
        
        set(handles.checkbox_green,'Value',1);
        set(handles.btn_edit_green,'Enable','on');
        set(handles.txt_value_green,'String','[-15;15;3]');
        add_attack(handles,'green');
        
        set(handles.checkbox_blue,'Value',1);
        set(handles.btn_edit_blue,'Enable','on');
        set(handles.txt_value_blue,'String','[-15;15;3]');
        add_attack(handles,'blue');
        
        set(handles.checkbox_y,'Value',1);
        set(handles.btn_edit_y,'Enable','on');
        set(handles.txt_value_y,'String','[-15;15;3]');
        add_attack(handles,'y');
        
        set(handles.checkbox_cb,'Value',1);
        set(handles.btn_edit_cb,'Enable','on');
        set(handles.txt_value_cb,'String','[-15;15;3]');
        add_attack(handles,'cb');
        
        set(handles.checkbox_cr,'Value',1);
        set(handles.btn_edit_cr,'Enable','on');
        set(handles.txt_value_cr,'String','[-15;15;3]');
        add_attack(handles,'cr');
        
        set(handles.checkbox_hue,'Value',1);
        set(handles.btn_edit_hue,'Enable','on');
        set(handles.txt_value_hue,'String','[-15;15;3]');
        add_attack(handles,'hue');
        
        set(handles.checkbox_saturation,'Value',1);
        set(handles.btn_edit_saturation,'Enable','on');
        set(handles.txt_value_saturation,'String','[-15;15;3]');
        add_attack(handles,'saturation');
        
        set(handles.checkbox_value,'Value',1);
        set(handles.btn_edit_value,'Enable','on');
        set(handles.txt_value_value,'String','[-15;15;3]');
        add_attack(handles,'value');
    case 'Noise'
        set(handles.checkbox_gaussian_noise,'Value',1);
        set(handles.btn_edit_gaussian_noise,'Enable','on');
        set(handles.txt_value_gaussian_noise,'String','[0.0025;0.025;0.0025]');
        add_attack(handles,'gaussian_noise');
        
        set(handles.checkbox_salt_pepper_noise,'Value',1);
        set(handles.btn_edit_salt_pepper_noise,'Enable','on');
        set(handles.txt_value_salt_pepper_noise,'String','[0.003;0.03;0.003]');
        add_attack(handles,'salt_pepper_noise');
        
        set(handles.checkbox_speckle_noise,'Value',1);
        set(handles.btn_edit_speckle_noise,'Enable','on');
        set(handles.txt_value_speckle_noise,'String','[0.0025;0.025;0.0025]');
        add_attack(handles,'speckle_noise');
        
        set(handles.checkbox_bitplane,'Value',1);
        set(handles.btn_edit_bitplane,'Enable','on');
        set(handles.txt_value_bitplane,'String','[7 6 5]');
        add_attack(handles,'bitplane');
    case 'Compression'
        set(handles.checkbox_jpg,'Value',1);
        set(handles.btn_edit_jpg,'Enable','on');
        set(handles.txt_value_jpg,'String','[30;100;5]');
        add_attack(handles,'jpg');
        
        set(handles.checkbox_color_reduction,'Value',1);
        set(handles.btn_edit_color_reduction,'Enable','on');
        set(handles.txt_value_color_reduction,'String','[0.2;2;0.2]');
        add_attack(handles,'color_reduction');
    case 'Enhancements'
        set(handles.checkbox_blur,'Value',1);
        set(handles.btn_edit_blur,'Enable','on');
        set(handles.txt_value_blur,'String','[2;20;2]');
        add_attack(handles,'blur');
        
        set(handles.checkbox_sharpen,'Value',1);
        set(handles.btn_edit_sharpen,'Enable','on');
        set(handles.txt_value_sharpen,'String','[1]');
        add_attack(handles,'sharpen');
        
        set(handles.checkbox_motion,'Value',1);
        set(handles.btn_edit_motion,'Enable','on');
        set(handles.txt_value_motion,'String','[3;30;3]');
        add_attack(handles,'motion');
        
        set(handles.checkbox_gamma,'Value',1);
        set(handles.btn_edit_gamma,'Enable','on');
        set(handles.txt_value_gamma,'String','[0.1 0.3 0.6 0.8 0.9 1.1 1.2 1.4 1.7 2]');
        add_attack(handles,'gamma');
        
        set(handles.checkbox_contrast,'Value',1);
        set(handles.btn_edit_contrast,'Enable','on');
        set(handles.txt_value_contrast,'String','[0.05;0.5; 0.05]');
        add_attack(handles,'contrast');
        
        set(handles.checkbox_brighten,'Value',1);
        set(handles.btn_edit_brighten,'Enable','on');
        set(handles.txt_value_brighten,'String','[1;15;1]');
        add_attack(handles,'brighten');
    case 'Geometric Distortions'
    
        set(handles.checkbox_rotation,'Value',1);
        set(handles.btn_edit_rotation,'Enable','on');
        set(handles.txt_value_rotation,'String','[-2 -1 -0.75 -0.5 -0.25 0.25 0.5 0.75 1 2 5 10 15 30 45 90 180 270]');
        add_attack(handles,'rotation');
        
        set(handles.checkbox_rotation_crop,'Value',1);
        set(handles.btn_edit_rotation_crop,'Enable','on');
        set(handles.txt_value_rotation_crop,'String','[-2 -1 -0.75 -0.5 -0.25 0.25 0.5 0.75 1 2 5 10 15 30 45 90 180 270]');
        add_attack(handles,'rotation_crop');
        
        set(handles.checkbox_rotation_scale,'Value',1);
        set(handles.btn_edit_rotation_scale,'Enable','on');
        set(handles.txt_value_rotation_scale,'String','[-2 -1 -0.75 -0.5 -0.25 0.25 0.5 0.75 1 2 5 10 15 30 45 90 180 270]');
        add_attack(handles,'rotation_scale');
        
        set(handles.checkbox_crop,'Value',1);
        set(handles.btn_edit_crop,'Enable','on');
        set(handles.txt_value_crop,'String','[1; 25; 1]');
        add_attack(handles,'crop');
        
        set(handles.checkbox_flip,'Value',1);
        set(handles.btn_edit_flip,'Enable','on');
        set(handles.txt_value_flip,'String','[1 2]');
        add_attack(handles,'flip');
        
        set(handles.checkbox_scale,'Value',1);
        set(handles.btn_edit_scale,'Enable','on');
        set(handles.txt_value_scale,'String','[5; 50; 5]');
        add_attack(handles,'scale');
        
        set(handles.checkbox_shear_x,'Value',1);
        set(handles.btn_edit_shear_x,'Enable','on');
        set(handles.txt_value_shear_x,'String','[0.01 0.02 0.04 0.6 0.08 0.1 0.15 0.2]');
        add_attack(handles,'shear_x');
        
        set(handles.checkbox_shear_y,'Value',1);
        set(handles.btn_edit_shear_y,'Enable','on');
        set(handles.txt_value_shear_y,'String','[0.01 0.02 0.04 0.6 0.08 0.1 0.15 0.2]');
        add_attack(handles,'shear_y');
    otherwise
        
        
end









