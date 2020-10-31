function update_fullcolor_watermarked_attacked(handles)

         set(handles.togglebutton_image_watermarked_attacked,'Enable','on');
                
         set(handles.togglebutton_fullcolor_watermarked_attacked,'Enable','off');
         set(handles.togglebutton_fullcolor_watermarked_attacked,'Value',1);
       
         set(handles.togglebutton_histogram_watermarked_attacked,'Enable','on');
         set(handles.togglebutton_histogram_watermarked_attacked,'Value',0);

         set(handles.togglebutton_dct_watermarked_attacked,'Enable','on');
         set(handles.togglebutton_dct_watermarked_attacked,'Value',0);

         set(handles.togglebutton_dwt_watermarked_attacked,'Enable','on');
         set(handles.togglebutton_dwt_watermarked_attacked,'Value',0);
         
         set(handles.label_image_watermarked_attacked,'String','Image Watermarked ');
                         
         set(handles.label_icon_ycbcr_watermarked_attacked,'String','Icon Image');
         set(handles.label_icon_rgb_watermarked_attacked,'String','Icon Image');

         set(handles.label_layer_y_watermarked_attacked,'String','Y layer');
         set(handles.label_layer_cb_watermarked_attacked,'String','Cb Layer');
         set(handles.label_layer_cr_watermarked_attacked,'String','Cr Layer ');

         set(handles.label_layer_red_watermarked_attacked,'String','Red Layer ');
         set(handles.label_layer_green_watermarked_attacked,'String','Green Layer ');
         set(handles.label_layer_blue_watermarked_attacked,'String','Blue Layer ');
         
     
         image_type = get_root_data('image_type');
        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('watermarked_embed_plot_grayscale');
                
                set(handles.label_image_watermarked_attacked,'String','Image Watermarked');
                
                axes(handles.axes_image_watermarked_attacked);
                imshow(image_gray);
            case 'layered'
                
                set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_y_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_cb_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_cr_watermarked_attacked,'Visible','on');

                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_red_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_green_watermarked_attacked,'Visible','on');
                set(handles.radiobutton_layer_blue_watermarked_attacked,'Visible','on');

                
                image_rgb = get_root_data('watermarked_embed_plot_rgb');

                axes(handles.axes_image_watermarked_attacked);
                imshow(image_rgb);
        
                y = get_root_data('watermarked_embed_plot_y');
                cb = get_root_data('watermarked_embed_plot_cb');
                cr = get_root_data('watermarked_embed_plot_cr');
                
                red = get_root_data('watermarked_embed_plot_red');
                green = get_root_data('watermarked_embed_plot_green');
                blue = get_root_data('watermarked_embed_plot_blue');
                
                axes(handles.axes_layer_y_watermarked_attacked);
                imshow(y);
                
                axes(handles.axes_layer_y_watermarked_attacked);
                imshow(y);
                axes(handles.axes_layer_cb_watermarked_attacked);
                imshow(cb);
                axes(handles.axes_layer_cr_watermarked_attacked);
                imshow(cr);
                
                axes(handles.axes_layer_red_watermarked_attacked);
                imshow(red);
                axes(handles.axes_layer_green_watermarked_attacked);
                imshow(green);
                axes(handles.axes_layer_blue_watermarked_attacked);
                imshow(blue);
        
                axes(handles.axes_icon_rgb_watermarked_attacked);
                imshow(image_rgb);
                axes(handles.axes_icon_ycbcr_watermarked_attacked);
                imshow(image_rgb);        
        end;
        
        