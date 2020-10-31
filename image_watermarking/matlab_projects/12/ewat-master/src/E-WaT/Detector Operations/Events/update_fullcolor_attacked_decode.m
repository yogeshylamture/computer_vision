function update_fullcolor_attacked_decode(handles)

         set(handles.togglebutton_image_attacked_decode,'Enable','on');
                
         set(handles.togglebutton_fullcolor_attacked_decode,'Enable','off');
       
         set(handles.togglebutton_histogram_attacked_decode,'Enable','on');
         set(handles.togglebutton_histogram_attacked_decode,'Value',0);

         set(handles.togglebutton_dct_attacked_decode,'Enable','on');
         set(handles.togglebutton_dct_attacked_decode,'Value',0);

         set(handles.togglebutton_dwt_attacked_decode,'Enable','on');
         set(handles.togglebutton_dwt_attacked_decode,'Value',0);
         
         set(handles.label_image_attacked_decode,'String','Image Attacked');
                         
         set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
         set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');

         set(handles.label_layer_y_attacked_decode,'String','Y layer');
         set(handles.label_layer_cb_attacked_decode,'String','Cb Layer');
         set(handles.label_layer_cr_attacked_decode,'String','Cr Layer ');

         set(handles.label_layer_red_attacked_decode,'String','Red Layer ');
         set(handles.label_layer_green_attacked_decode,'String','Green Layer ');
         set(handles.label_layer_blue_attacked_decode,'String','Blue Layer ');
         
         image_type = get_root_data('image_type');
        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('attacked_decode_plot_grayscale');
                
                set(handles.label_image_attacked_decode,'String','Image Attacked');
                
                axes(handles.axes_image_attacked_decode);
                imshow(image_gray);
            case 'layered'
                
                set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_y_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_cb_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_cr_attacked_decode,'Visible','on');

                set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_red_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_green_attacked_decode,'Visible','on');
                set(handles.radiobutton_layer_blue_attacked_decode,'Visible','on');

                
                image_rgb = get_root_data('attacked_decode_plot_rgb');

                axes(handles.axes_image_attacked_decode);
                imshow(image_rgb);
        
                y = get_root_data('attacked_decode_plot_y');
                cb = get_root_data('attacked_decode_plot_cb');
                cr = get_root_data('attacked_decode_plot_cr');
                
                red = get_root_data('attacked_decode_plot_red');
                green = get_root_data('attacked_decode_plot_green');
                blue = get_root_data('attacked_decode_plot_blue');
                
                axes(handles.axes_layer_y_attacked_decode);
                imshow(y);
                
                axes(handles.axes_layer_y_attacked_decode);
                imshow(y);
                axes(handles.axes_layer_cb_attacked_decode);
                imshow(cb);
                axes(handles.axes_layer_cr_attacked_decode);
                imshow(cr);
                
                axes(handles.axes_layer_red_attacked_decode);
                imshow(red);
                axes(handles.axes_layer_green_attacked_decode);
                imshow(green);
                axes(handles.axes_layer_blue_attacked_decode);
                imshow(blue);
        
                axes(handles.axes_icon_rgb_attacked_decode);
                imshow(image_rgb);
                axes(handles.axes_icon_ycbcr_attacked_decode);
                imshow(image_rgb);        
        end;
        
        