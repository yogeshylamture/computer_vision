function update_dwt_original(handles)

        set(handles.radiobutton_icon_ycbcr_original,'Visible','off');
        set(handles.radiobutton_layer_y_original,'Visible','off');
        set(handles.radiobutton_layer_cb_original,'Visible','off');
        set(handles.radiobutton_layer_cr_original,'Visible','off');
        
        set(handles.radiobutton_icon_rgb_original,'Visible','off');
        set(handles.radiobutton_layer_red_original,'Visible','off');
        set(handles.radiobutton_layer_green_original,'Visible','off');
        set(handles.radiobutton_layer_blue_original,'Visible','off');
        
        set(handles.togglebutton_dwt_original,'Enable','off');
        set(handles.togglebutton_dwt_original,'Value',1);
       
         set(handles.togglebutton_histogram_original,'Enable','on');
         set(handles.togglebutton_histogram_original,'Value',0);

         set(handles.togglebutton_fullcolor_original,'Enable','on');
         set(handles.togglebutton_fullcolor_original,'Value',0);

         set(handles.togglebutton_dct_original,'Enable','on');
         set(handles.togglebutton_dct_original,'Value',0);
         
         image_type = get_root_data('image_type');
         selected_image = check_selected_component_original(handles);
         
         plot = get_root_data('original_plot_rgb');
                        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('original_dwt_grayscale');
                
                set(handles.label_image_original,'String','DWT');
                
                axes(handles.axes_image_original);
                colormap pink;
                image(image_gray);
                axis off;
            case 'layered'
                switch selected_image
                    case 'ycbcr' 
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.togglebutton_image_original,'Value',0);
                        set(handles.togglebutton_image_original,'Enable','off');
                
                        set(handles.togglebutton_layers_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Enable','off');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','on');
                        set(handles.tab_image_original,'Visible','off');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                        
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                    case 'rgb'
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.togglebutton_image_original,'Value',0);
                        set(handles.togglebutton_image_original,'Enable','off');
                
                        set(handles.togglebutton_layers_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Enable','off');
                        
                        set(handles.tab_layers_rgb_original,'Visible','on');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','off');
                        
                        plot = get_root_data('original_plot_rgb');
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'y'
                        set(handles.label_image_original,'String','Y DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        y = get_root_data('original_dwt_y');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'cb'
                        set(handles.label_image_original,'String','Cb DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        cb = get_root_data('original_dwt_cb');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'cr'
                        set(handles.label_image_original,'String','Cr DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        cr = get_root_data('original_dwt_cr');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    
                    case 'red'
                        set(handles.label_image_original,'String','Red DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        red = get_root_data('original_dwt_red');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'green'
                        set(handles.label_image_original,'String','Green DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        green = get_root_data('original_dwt_green');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        image(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'blue'
                        set(handles.label_image_original,'String','Blue DWT ');
                        
                        set(handles.label_icon_ycbcr_original,'String','Icon Image');
                        set(handles.label_icon_rgb_original,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_original,'String','Y DWT ');
                        set(handles.label_layer_cb_original,'String','Cb DWT ');
                        set(handles.label_layer_cr_original,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_original,'String','Red DWT ');
                        set(handles.label_layer_green_original,'String','Green DWT ');
                        set(handles.label_layer_blue_original,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        blue = get_root_data('original_dwt_blue');
                        
                        axes(handles.axes_image_original);
                        colormap pink;
                        image(blue);
                        axis off;
                        
                        red = get_root_data('original_dwt_red');
                        green = get_root_data('original_dwt_green');
                        blue = get_root_data('original_dwt_blue');
                        
                        y = get_root_data('original_dwt_y');
                        cb = get_root_data('original_dwt_cb');
                        cr = get_root_data('original_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_original);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_original);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_original);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_original);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_original);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_original);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_original);
                        colormap pink;
                        image(blue);
                        axis off;
                end
         end;
        
        