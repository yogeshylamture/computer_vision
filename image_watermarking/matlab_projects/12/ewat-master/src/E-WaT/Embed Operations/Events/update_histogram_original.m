function update_histogram_original(handles)

        set(handles.togglebutton_image_original,'Enable','on');
                
        set(handles.togglebutton_histogram_original,'Enable','off');
        set(handles.togglebutton_histogram_original,'Value',1);
        
        set(handles.togglebutton_fullcolor_original,'Enable','on');
        set(handles.togglebutton_fullcolor_original,'Value',0);
        
        set(handles.togglebutton_dct_original,'Enable','on');
        set(handles.togglebutton_dct_original,'Value',0);
        
        set(handles.togglebutton_dwt_original,'Enable','on');    
        set(handles.togglebutton_dwt_original,'Value',0);
        
        set(handles.radiobutton_icon_ycbcr_original,'Visible','off');
        set(handles.radiobutton_layer_y_original,'Visible','off');
        set(handles.radiobutton_layer_cb_original,'Visible','off');
        set(handles.radiobutton_layer_cr_original,'Visible','off');
        
        set(handles.radiobutton_icon_rgb_original,'Visible','off');
        set(handles.radiobutton_layer_red_original,'Visible','off');
        set(handles.radiobutton_layer_green_original,'Visible','off');
        set(handles.radiobutton_layer_blue_original,'Visible','off');
        
        selected_image = check_selected_component_original(handles);
        
        image_type = get_root_data('image_type');
        
        image_rgb = get_root_data('original_plot_rgb');
        
        switch image_type
            case 'grayscale'
                image_gray = get_root_data('original_plot_grayscale');
                
                set(handles.label_image_original,'String','Histogram');
                
                set_root_data(handles,'original_histogram_grayscale', image_gray);
            case 'layered'
                switch selected_image
                    case 'ycbcr'
                         set(handles.label_image_original,'String','YCbCr Histogram ');
                         
                         set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                         set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                                                  
                         set(handles.label_layer_y_original,'String','Y Histogram ');
                         set(handles.label_layer_cb_original,'String','Cb Histogram ');
                         set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                         set(handles.label_layer_red_original,'String','Red Histogram ');
                         set(handles.label_layer_green_original,'String','Green Histogram ');
                         set(handles.label_layer_blue_original,'String','Blue Histogram ');
                         
                         set_root_data(handles,'original_histogram_ycbcr', image_rgb);
                         set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                         set_root_data(handles,'original_histogram_y', image_rgb);
                         set_root_data(handles,'original_histogram_cb', image_rgb);
                         set_root_data(handles,'original_histogram_cr',image_rgb);
                         set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                         set_root_data(handles,'original_histogram_red', image_rgb);
                         set_root_data(handles,'original_histogram_green', image_rgb);
                         set_root_data(handles,'original_histogram_blue', image_rgb);
                         
                    case 'rgb'
                        set(handles.label_image_original,'String','RGB Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        set_root_data(handles,'original_histogram_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                    case 'y'
                        set(handles.label_image_original,'String','Y Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.label_image_original,'String','Y Histogram ');
                         
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        [histogram_y,nvt1,nvt2] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_original);
                        stem(histogram_y,'.k','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                        
                    case 'cb'
                        set(handles.label_image_original,'String','Cb Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.label_image_original,'String','Cb Histogram ');
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        [nvt1,histogram_cb,nvt2] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_original);
                        stem(histogram_cb,'.c','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                    case 'cr'
                        set(handles.label_image_original,'String','Cr Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                        
                        [nvt1,nvt2,histogram_cr] = histogram(image_rgb,'ycbcr');
                        axes(handles.axes_image_original);
                        stem(histogram_cr,'.m','Markersize',1);
                        axis off;  
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                    case 'red'
                        set(handles.label_image_original,'String','Red Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                       
                        [histogram_red,nvt1,nvt2] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_original);
                        stem(histogram_red,'.r','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                    case 'green'
                        set(handles.label_image_original,'String','Green Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                                               
                        [nvt1,histogram_green,nvt2] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_original);
                        stem(histogram_green,'.g','Markersize',1);
                        axis off;
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                    case 'blue'
                        set(handles.label_image_original,'String','Blue Histogram ');
                        
                        set(handles.label_icon_ycbcr_original,'String','YCbCr Histogram ');
                        set(handles.label_icon_rgb_original,'String','RGB Histogram ');
                        
                        set(handles.label_layer_y_original,'String','Y Histogram ');
                        set(handles.label_layer_cb_original,'String','Cb Histogram ');
                        set(handles.label_layer_cr_original,'String','Cr Histogram ');
                         
                        set(handles.label_layer_red_original,'String','Red Histogram ');
                        set(handles.label_layer_green_original,'String','Green Histogram ');
                        set(handles.label_layer_blue_original,'String','Blue Histogram '); 
                        
                        
                        set(handles.tab_layers_rgb_original,'Visible','off');
                        set(handles.tab_layers_ycbcr_original,'Visible','off');
                        set(handles.tab_image_original,'Visible','on');
                        
                        set(handles.togglebutton_image_original,'Value',1);
                        set(handles.togglebutton_layers_original,'Value',0);
                        
                        set(handles.togglebutton_image_original,'Enable','off');
                        set(handles.togglebutton_layers_original,'Enable','on');
                                               
                        [nvt1,nvt2,histogram_blue] = histogram(image_rgb,'rgb');
                        axes(handles.axes_image_original);
                        stem(histogram_blue,'.b','Markersize',1);
                        axis off;  
                        
                        set_root_data(handles,'original_histogram_icon_ycbcr', image_rgb);
                        set_root_data(handles,'original_histogram_y', image_rgb);
                        set_root_data(handles,'original_histogram_cb', image_rgb);
                        set_root_data(handles,'original_histogram_cr',image_rgb);
                        set_root_data(handles,'original_histogram_icon_rgb', image_rgb);
                        set_root_data(handles,'original_histogram_red', image_rgb);
                        set_root_data(handles,'original_histogram_green', image_rgb);
                        set_root_data(handles,'original_histogram_blue', image_rgb);
                end;
        end
                        

                 
