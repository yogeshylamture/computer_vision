function [name_image full_image_rgb working_layer working_image]=calculate_variables_input(handles)

        spectrum = get(handles.popup_spectrum,'Value');
        layer = get(handles.popup_layer,'Value');
        
        full_image_rgb = get_root_data('full_image');
        
        name_image = get_root_data('image_name');
        
        switch spectrum
            case 1.0    %rgb selected
                switch layer
                    case 1.0    %red selected
                        working_image = full_image_rgb(:,:,1);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','RGB');
                        working_layer = 'Red layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 2.0    %green selected
                        working_image = full_image_rgb(:,:,2);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','RGB');
                        working_layer = 'Green layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 3.0    %blue selected
                        working_image = full_image_rgb(:,:,3);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','RGB');
                        working_layer = 'Blue layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                end
            case 2.0    %yiq selected
                converted_image = im2uint8(rgb2ntsc(full_image_rgb));
                switch layer
                    case 1.0    %y selected
                        working_image = converted_image(:,:,1);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','NTSC(YIQ)');
                        working_layer = 'NTSC Y-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 2.0    %I selected
                        working_image = converted_image(:,:,2);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','NTSC(YIQ)');
                        working_layer = 'I-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 3.0    %Q selected
                        working_image = converted_image(:,:,3);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','NTSC(YIQ)');
                        working_layer = 'Q-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                end
            case 3.0    %YCbCr selected
                converted_image = im2uint8(rgb2ycbcr(full_image_rgb));
                switch layer
                    case 1.0    %y selected
                        working_image = converted_image(:,:,1);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','YCbCr');
                        working_layer = 'Y-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 2.0    %CB selected
                        working_image = converted_image(:,:,2);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','YCbCr');
                        working_layer = 'Cb-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 3.0    %Cr selected
                        working_image = converted_image(:,:,3);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','YCbCr');
                        working_layer = 'Cr-layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                end
            case 4.0    %hsv selected
                converted_image = im2uint8(rgb2hsv(full_image_rgb));
                switch layer
                    case 1.0    %hue selected
                        working_image = converted_image(:,:,1);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','HSV');
                        working_layer = 'Hue layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 2.0    %saturation selected
                        working_image = converted_image(:,:,2);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','HSV');
                        working_layer = 'Saturation layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                    case 3.0    %Value selected
                        working_image = converted_image(:,:,3);
                        set_root_data(handles,'working_image',working_image);
                        
                        set(handles.txt_image_spectrum,'string','HSV');
                        working_layer = 'Value layer';
                        set(handles.txt_image_layer,'string',working_layer);
                        
                end
        end