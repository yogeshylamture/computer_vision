function update_fullcolor_original(handles)

         set(handles.togglebutton_image_original,'Enable','on');
                
         set(handles.togglebutton_fullcolor_original,'Enable','off');
         set(handles.togglebutton_fullcolor_original,'Value',1);
       
         set(handles.togglebutton_histogram_original,'Enable','on');
         set(handles.togglebutton_histogram_original,'Value',0);

         set(handles.togglebutton_dct_original,'Enable','on');
         set(handles.togglebutton_dct_original,'Value',0);

         set(handles.togglebutton_dwt_original,'Enable','on');
         set(handles.togglebutton_dwt_original,'Value',0);
         
         set(handles.label_image_original,'String','Image Original ');
                         
         set(handles.label_icon_ycbcr_original,'String','Icon Image');
         set(handles.label_icon_rgb_original,'String','Icon Image');

         set(handles.label_layer_y_original,'String','Y layer');
         set(handles.label_layer_cb_original,'String','Cb Layer');
         set(handles.label_layer_cr_original,'String','Cr Layer ');

         set(handles.label_layer_red_original,'String','Red Layer ');
         set(handles.label_layer_green_original,'String','Green Layer ');
         set(handles.label_layer_blue_original,'String','Blue Layer ');
         
         image_type = get_root_data('image_type');
        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('original_plot_grayscale');
                
                set(handles.label_image_original,'String','Original Image');
                
                axes(handles.axes_image_original);
                imshow(image_gray);
            case 'layered'
                
                set(handles.radiobutton_icon_ycbcr_original,'Visible','on');
                set(handles.radiobutton_layer_y_original,'Visible','on');
                set(handles.radiobutton_layer_cb_original,'Visible','on');
                set(handles.radiobutton_layer_cr_original,'Visible','on');

                set(handles.radiobutton_icon_rgb_original,'Visible','on');
                set(handles.radiobutton_layer_red_original,'Visible','on');
                set(handles.radiobutton_layer_green_original,'Visible','on');
                set(handles.radiobutton_layer_blue_original,'Visible','on');

                
                image_rgb = get_root_data('original_plot_rgb');

                axes(handles.axes_image_original);
                imshow(image_rgb);
        
                y = get_root_data('original_plot_y');
                cb = get_root_data('original_plot_cb');
                cr = get_root_data('original_plot_cr');
                
                red = get_root_data('original_plot_red');
                green = get_root_data('original_plot_green');
                blue = get_root_data('original_plot_blue');
                
                axes(handles.axes_layer_y_original);
                imshow(y);
                
                axes(handles.axes_layer_y_original);
                imshow(y);
                axes(handles.axes_layer_cb_original);
                imshow(cb);
                axes(handles.axes_layer_cr_original);
                imshow(cr);
                
                axes(handles.axes_layer_red_original);
                imshow(red);
                axes(handles.axes_layer_green_original);
                imshow(green);
                axes(handles.axes_layer_blue_original);
                imshow(blue);
        
                axes(handles.axes_icon_rgb_original);
                imshow(image_rgb);
                axes(handles.axes_icon_ycbcr_original);
                imshow(image_rgb);        
        end;
        
        