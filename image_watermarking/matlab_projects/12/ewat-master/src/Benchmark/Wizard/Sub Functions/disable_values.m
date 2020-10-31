function disable_values(handles)

%Compression
set(handles.txt_value_jpg,'Enable','off');
set(handles.txt_value_color_reduction,'Enable','off');

%Noise
set(handles.txt_value_gaussian_noise,'Enable','off');
set(handles.txt_value_salt_pepper_noise,'Enable','off');
set(handles.txt_value_speckle_noise,'Enable','off');
set(handles.txt_value_bitplane,'Enable','off');
    
%Enhancements
set(handles.txt_value_blur,'Enable','off');
set(handles.txt_value_sharpen,'Enable','off');
set(handles.txt_value_motion,'Enable','off');
set(handles.txt_value_gamma,'Enable','off');
set(handles.txt_value_contrast,'Enable','off');
set(handles.txt_value_brighten,'Enable','off');

%Geometric
set(handles.txt_value_rotation,'Enable','off');
set(handles.txt_value_rotation_crop,'Enable','off');
set(handles.txt_value_rotation_scale,'Enable','off');
set(handles.txt_value_crop,'Enable','off');
set(handles.txt_value_scale,'Enable','off');
set(handles.txt_value_shear_x,'Enable','off');
set(handles.txt_value_shear_y,'Enable','off');

%Color manipulation
set(handles.txt_value_red,'Enable','off');
set(handles.txt_value_green,'Enable','off');
set(handles.txt_value_blue,'Enable','off');
set(handles.txt_value_y,'Enable','off');
set(handles.txt_value_cb,'Enable','off');
set(handles.txt_value_cr,'Enable','off');
set(handles.txt_value_hue,'Enable','off');
set(handles.txt_value_saturation,'Enable','off');
set(handles.txt_value_value,'Enable','off');
