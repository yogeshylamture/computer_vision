function update_dwt_attacked_decode(handles)

        set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_y_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_cb_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_cr_attacked_decode,'Visible','off');
        
        set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_red_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_green_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_blue_attacked_decode,'Visible','off');
        
        set(handles.togglebutton_dwt_attacked_decode,'Enable','off');
       
         set(handles.togglebutton_histogram_attacked_decode,'Enable','on');
         set(handles.togglebutton_histogram_attacked_decode,'Value',0);

         set(handles.togglebutton_fullcolor_attacked_decode,'Enable','on');
         set(handles.togglebutton_fullcolor_attacked_decode,'Value',0);

         set(handles.togglebutton_dct_attacked_decode,'Enable','on');
         set(handles.togglebutton_dct_attacked_decode,'Value',0);
         
         image_type = get_root_data('image_type');
         selected_image = check_selected_component_attacked_decode(handles);
         
         plot = get_root_data('attacked_decode_plot_rgb');
                        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('attacked_decode_dwt_grayscale');
                
                set(handles.label_image_attacked_decode,'String','DWT');
                
                axes(handles.axes_image_attacked_decode);
                colormap pink;
                image(image_gray);
                axis off;
            case 'layered'
                switch selected_image
                    case 'ycbcr' 
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',0);
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                
                        set(handles.togglebutton_layers_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Enable','off');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','on');
                        set(handles.tab_image_attacked_decode,'Visible','off');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                        
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                    case 'rgb'
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',0);
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                
                        set(handles.togglebutton_layers_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Enable','off');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','on');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','off');
                        
                        plot = get_root_data('attacked_decode_plot_rgb');
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'y'
                        set(handles.label_image_attacked_decode,'String','Y DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'cb'
                        set(handles.label_image_attacked_decode,'String','Cb DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        cb = get_root_data('attacked_decode_dwt_cb');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'cr'
                        set(handles.label_image_attacked_decode,'String','Cr DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        cr = get_root_data('attacked_decode_dwt_cr');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    
                    case 'red'
                        set(handles.label_image_attacked_decode,'String','Red DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'green'
                        set(handles.label_image_attacked_decode,'String','Green DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        green = get_root_data('attacked_decode_dwt_green');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        image(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                    case 'blue'
                        set(handles.label_image_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','Icon Image');
                        set(handles.label_icon_rgb_attacked_decode,'String','Icon Image');
                                                  
                        set(handles.label_layer_y_attacked_decode,'String','Y DWT ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb DWT ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr DWT ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red DWT ');
                        set(handles.label_layer_green_attacked_decode,'String','Green DWT ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue DWT ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        axes(handles.axes_image_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                        
                        red = get_root_data('attacked_decode_dwt_red');
                        green = get_root_data('attacked_decode_dwt_green');
                        blue = get_root_data('attacked_decode_dwt_blue');
                        
                        y = get_root_data('attacked_decode_dwt_y');
                        cb = get_root_data('attacked_decode_dwt_cb');
                        cr = get_root_data('attacked_decode_dwt_cr');
                                                
                        axes(handles.axes_icon_ycbcr_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_y_attacked_decode);
                        colormap pink;
                        image(y);
                        axis off;
                        
                        axes(handles.axes_layer_cb_attacked_decode);
                        colormap pink;
                        image(cb);
                        axis off;
                        
                        axes(handles.axes_layer_cr_attacked_decode);
                        colormap pink;
                        image(cr);
                        axis off;
                        
                        axes(handles.axes_icon_rgb_attacked_decode);
                        imshow(plot);
                        axis off;
                        
                        axes(handles.axes_layer_red_attacked_decode);
                        colormap pink;
                        image(red);
                        axis off;
                        
                        axes(handles.axes_layer_green_attacked_decode);
                        colormap pink;
                        image(green);
                        axis off;
                        
                        axes(handles.axes_layer_blue_attacked_decode);
                        colormap pink;
                        image(blue);
                        axis off;
                end
         end;
        
        