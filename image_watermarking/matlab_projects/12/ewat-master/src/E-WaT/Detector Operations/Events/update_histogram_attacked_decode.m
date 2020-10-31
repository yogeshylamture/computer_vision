function update_histogram_attacked_decode(handles)

        set(handles.togglebutton_image_attacked_decode,'Enable','on');
                
        set(handles.togglebutton_histogram_attacked_decode,'Enable','off');
        
        set(handles.togglebutton_fullcolor_attacked_decode,'Enable','on');
        set(handles.togglebutton_fullcolor_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dct_attacked_decode,'Enable','on');
        set(handles.togglebutton_dct_attacked_decode,'Value',0);
        
        set(handles.togglebutton_dwt_attacked_decode,'Enable','on');    
        set(handles.togglebutton_dwt_attacked_decode,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_y_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_cb_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_cr_attacked_decode,'Visible','off');
        
        set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_red_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_green_attacked_decode,'Visible','off');
        set(handles.radiobutton_layer_blue_attacked_decode,'Visible','off');
        
        selected_image = check_selected_component_attacked_decode(handles);
        
        image_type = get_root_data('image_type');
        
        image_rgb = get_root_data('attacked_decode_plot_rgb');
        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('attacked_decode_plot_grayscale');
                
                set(handles.label_image_attacked_decode,'String','Histogram');
                
                set_root_data(handles,'attacked_decode_histogram_grayscale', image_gray);
            case 'layered'
                switch selected_image
                    case 'ycbcr'
                         set(handles.label_image_attacked_decode,'String','YCbCr Histogram ');
                         
                         set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                         set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                                                  
                         set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                         set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                         set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                         set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                         set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                         set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram ');
                         
                         set_root_data(handles,'attacked_decode_histogram_ycbcr', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                         set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                         
                    case 'rgb'
                        set(handles.label_image_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        set_root_data(handles,'attacked_decode_histogram_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                    case 'y'
                        set(handles.label_image_attacked_decode,'String','Y Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.label_image_attacked_decode,'String','Y Histogram ');
                         
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        [histogram_y,nvt1,nvt2] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_y,'.k','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                        
                    case 'cb'
                        set(handles.label_image_attacked_decode,'String','Cb Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.label_image_attacked_decode,'String','Cb Histogram ');
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        [nvt1,histogram_cb,nvt2] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_cb,'.c','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                    case 'cr'
                        set(handles.label_image_attacked_decode,'String','Cr Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                        
                        [nvt1,nvt2,histogram_cr] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_cr,'.m','Markersize',1);
                        axis off;  
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                    case 'red'
                        set(handles.label_image_attacked_decode,'String','Red Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                       
                        [histogram_red,nvt1,nvt2] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_red,'.r','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                    case 'green'
                        set(handles.label_image_attacked_decode,'String','Green Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                                               
                        [nvt1,histogram_green,nvt2] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_green,'.g','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                    case 'blue'
                        set(handles.label_image_attacked_decode,'String','Blue Histogram ');
                        
                        set(handles.label_icon_ycbcr_attacked_decode,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_attacked_decode,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_attacked_decode,'String','Y Histogram ');
                        set(handles.label_layer_cb_attacked_decode,'String','Cb Histogram ');
                        set(handles.label_layer_cr_attacked_decode,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_attacked_decode,'String','Red Histogram ');
                        set(handles.label_layer_green_attacked_decode,'String','Green Histogram ');
                        set(handles.label_layer_blue_attacked_decode,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                        set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                        set(handles.tab_image_attacked_decode,'Visible','on');
                        
                        set(handles.togglebutton_image_attacked_decode,'Value',1);
                        set(handles.togglebutton_layers_attacked_decode,'Value',0);
                        
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                                               
                        [nvt1,nvt2,histogram_blue] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_attacked_decode);
                        stem(histogram_blue,'.b','Markersize',1);
                        axis off;  
                        
                        set_root_data(handles,'attacked_decode_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_y', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_cr',image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_red', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_green', image_rgb);
                        set_root_data(handles,'attacked_decode_histogram_blue', image_rgb);
                end;
        end
                        

                 
