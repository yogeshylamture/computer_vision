function reset_checkboxes(handles)

%Compression
set(handles.checkbox_jpg,'Value',0);
set(handles.checkbox_color_reduction,'Value',0);
%Noise
set(handles.checkbox_gaussian_noise,'Value',0);
set(handles.checkbox_salt_pepper_noise,'Value',0);
set(handles.checkbox_speckle_noise,'Value',0);
set(handles.checkbox_bitplane,'Value',0);
%Enhancments
set(handles.checkbox_blur,'Value',0);
set(handles.checkbox_sharpen,'Value',0);
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