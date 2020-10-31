function checkboxes_profile(handles,profile)

switch profile
    case 'iMark'
        
        %Compression
        set(handles.checkbox_jpg,'Value',1);
        set(handles.txt_value_jpg,'String','[100;60;10]');
        add_attack(handles,'jpg');
        
        set(handles.checkbox_color_reduction,'Value',1);
        set(handles.txt_value_jpg,'String','[0.5;2;0.5]');
        add_attack(handles,'color_reduction');
        %Noise
        set(handles.checkbox_gaussian_noise,'Value',1);
        set(handles.txt_value_gaussian_noise,'String','[0.0025;0.02;0.0025]');
        add_attack(handles,'gaussian_noise');
        
        set(handles.checkbox_bitplanes,'Value',1);
        set(handles.txt_value_bitplanes,'String','[7 6 5]');
        add_attack(handles,'bitplanes');
        
        %Enhancments
        set(handles.checkbox_blur,'Value',1);
        set(handles.txt_value_blur,'String','[3;15;3]');
        add_attack(handles,'blur');
        
        set(handles.checkbox_contrast,'Value',1);
        set(handles.txt_value_contrast,'String','[0.1; 0.4; 0.1]');
        add_attack(handles,'contrast');
        
        set(handles.checkbox_brighten,'Value',1);
        set(handles.txt_value_brighten,'String','[3; 12; 3]');
        add_attack(handles,'brighten');
        
        %Geometric
        set(handles.checkbox_rotation,'Value',1);
        set(handles.txt_value_rotation,'String','[-2 -0.5 0.5 2]');
        add_attack(handles,'rotation');
        
        set(handles.checkbox_crop,'Value',1);
        set(handles.txt_value_crop,'String','[5; 25; 5]');
        add_attack(handles,'crop');
        
        set(handles.checkbox_flip,'Value',1);
        attack = get_root_data('attack');
        attack = setfield(attack,'flip','');
        set_root_data(handles,'attack',attack);
        
        set(handles.checkbox_scale,'Value',1);
        set(handles.txt_value_scale,'String','[5; 25; 5]');
        add_attack(handles,'scale');
        
        attack = get_root_data('attack')
        
        
        
    case 'Color Manipulations'
        reset_checkboxes(handles)
        
    case 'Noise'
        reset_checkboxes(handles)
        
    case 'Compression'
        reset_checkboxes(handles)
        
    case 'Enhancements'
        reset_checkboxes(handles)
        
    case 'Geometric Distortions'
        reset_checkboxes(handles)
        
    case 'StirMark'
        reset_checkboxes(handles)
        
    otherwise
        return
end


function reset_checkboxes(handles)

%Compression
set(handles.checkbox_jpg,'Value',0);
set(handles.checkbox_color_reduction,'Value',0);
%Noise
set(handles.checkbox_gaussian_noise,'Value',0);
set(handles.checkbox_salt_pepper_noise,'Value',0);
set(handles.checkbox_speckle_noise,'Value',0);
set(handles.checkbox_bitplanes,'Value',0);
%Enhancments
set(handles.checkbox_blur,'Value',0);
set(handles.checkbox_disk,'Value',0);
set(handles.checkbox_motion,'Value',0);
set(handles.checkbox_gamma,'Value',0);
set(handles.checkbox_contrast,'Value',0);
set(handles.checkbox_brighten,'Value',0);
%Geometric
set(handles.checkbox_rotation,'Value',0);
set(handles.checkbox_rotation_crop,'Value',0);
set(handles.checkbox_rotation_scale,'Value',0);
set(handles.checkbox_crop,'Value',0);
set(handles.checkbox_flip,'Value',0);
set(handles.checkbox_scale,'Value',0);
set(handles.checkbox_shear_x,'Value',0);
set(handles.checkbox_shear_y,'Value',0);
set(handles.checkbox_resize_optional,'Value',0);
%Color Manipulations
set(handles.checkbox_red,'Value',0);
set(handles.checkbox_green,'Value',0);
set(handles.checkbox_blue,'Value',0);
set(handles.checkbox_y,'Value',0);
set(handles.checkbox_cb,'Value',0);
set(handles.checkbox_cr,'Value',0);
set(handles.checkbox_hue,'Value',0);
set(handles.checkbox_saturation,'Value',0);
set(handles.checkbox_value,'Value',0);






