%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%no_attack: excecute this when there is no attack

function no_attack(handles)

    type = get_root_data('image_type');
    
    switch type
        case 'grayscale'
            watermarked_attacked_working_grayscale = get_root_data('watermarked_attacked_working_grayscale');
            watermarked_attacked_dct_grayscale = get_root_data('watermarked_attacked_dct_grayscale');
            watermarked_attacked_dwt_grayscale = get_root_data('watermarked_attacked_dwt_grayscale');
            watermarked_attacked_plot_grayscale = get_root_data('watermarked_attacked_plot_grayscale');
            
            %set_root_data(handles,'attacked_attacked_histogram_grayscale',watermarked_attacked_plot_grayscale);
            set_root_data(handles,'attacked_attacked_plot_grayscale',watermarked_attacked_plot_grayscale);
            set_root_data(handles,'attacked_attacked_dct_grayscale',watermarked_attacked_dct_grayscale);
            set_root_data(handles,'attacked_attacked_dwt_grayscale',watermarked_attacked_dwt_grayscale);
            set_root_data(handles,'attacked_attacked_working_grayscale',watermarked_attacked_working_grayscale);
            
            set_root_data(handles,'attacked_decode_plot_grayscale',watermarked_attacked_plot_grayscale);
            set_root_data(handles,'attacked_decode_dct_grayscale',watermarked_attacked_dct_grayscale);
            set_root_data(handles,'attacked_decode_dwt_grayscale',watermarked_attacked_dwt_grayscale);
            set_root_data(handles,'attacked_decode_working_grayscale',watermarked_attacked_working_grayscale);
            
            set(handles.togglebutton_layers_attacked_attacked,'Visible','off');
            set(handles.togglebutton_image_attacked_attacked,'Value',1);
            
            
        case 'layered'
            
            watermarked_attacked_working_rgb = get_root_data('watermarked_attacked_working_rgb');
            watermarked_attacked_working_red = get_root_data('watermarked_attacked_working_red');
            watermarked_attacked_working_green = get_root_data('watermarked_attacked_working_green');
            watermarked_attacked_working_blue = get_root_data('watermarked_attacked_working_blue');
            
            watermarked_attacked_dct_red = get_root_data('watermarked_attacked_dct_red');
            watermarked_attacked_dct_green = get_root_data('watermarked_attacked_dct_green');
            watermarked_attacked_dct_blue = get_root_data('watermarked_attacked_dct_blue');
            
            watermarked_attacked_dwt_red = get_root_data('watermarked_attacked_dwt_red');
            watermarked_attacked_dwt_green = get_root_data('watermarked_attacked_dwt_green');
            watermarked_attacked_dwt_blue = get_root_data('watermarked_attacked_dwt_blue');
            
            watermarked_attacked_plot_rgb = get_root_data('watermarked_attacked_plot_rgb');
            watermarked_attacked_plot_red = get_root_data('watermarked_attacked_plot_red');
            watermarked_attacked_plot_green = get_root_data('watermarked_attacked_plot_green');
            watermarked_attacked_plot_blue = get_root_data('watermarked_attacked_plot_blue');
            
            
            watermarked_attacked_working_ycbcr = get_root_data('watermarked_attacked_working_ycbcr');
            watermarked_attacked_working_y = get_root_data('watermarked_attacked_working_y');
            watermarked_attacked_working_cb = get_root_data('watermarked_attacked_working_cb');
            watermarked_attacked_working_cr = get_root_data('watermarked_attacked_working_cr');
            
            watermarked_attacked_dct_y = get_root_data('watermarked_attacked_dct_y');
            watermarked_attacked_dct_cb = get_root_data('watermarked_attacked_dct_cb');
            watermarked_attacked_dct_cr = get_root_data('watermarked_attacked_dct_cr');
            
            watermarked_attacked_dwt_y = get_root_data('watermarked_attacked_dwt_y');
            watermarked_attacked_dwt_cb = get_root_data('watermarked_attacked_dwt_cb');
            watermarked_attacked_dwt_cr = get_root_data('watermarked_attacked_dwt_cr');
            
            watermarked_attacked_plot_ycbcr = get_root_data('watermarked_attacked_plot_ycbcr');
            watermarked_attacked_plot_y = get_root_data('watermarked_attacked_plot_y');
            watermarked_attacked_plot_cb = get_root_data('watermarked_attacked_plot_cb');
            watermarked_attacked_plot_cr = get_root_data('watermarked_attacked_plot_cr');
            
            set_root_data(handles,'attacked_attacked_working_rgb',watermarked_attacked_working_rgb);
            set_root_data(handles,'attacked_attacked_working_red',watermarked_attacked_working_red);
            set_root_data(handles,'attacked_attacked_working_green',watermarked_attacked_working_green);
            set_root_data(handles,'attacked_attacked_working_blue',watermarked_attacked_working_blue);

            set_root_data(handles,'attacked_decode_working_rgb',watermarked_attacked_working_rgb);
            set_root_data(handles,'attacked_decode_working_red',watermarked_attacked_working_red);
            set_root_data(handles,'attacked_decode_working_green',watermarked_attacked_working_green);
            set_root_data(handles,'attacked_decode_working_blue',watermarked_attacked_working_blue);
            
            set_root_data(handles,'attacked_attacked_dct_red',watermarked_attacked_dct_red);
            set_root_data(handles,'attacked_attacked_dct_green',watermarked_attacked_dct_green);
            set_root_data(handles,'attacked_attacked_dct_blue',watermarked_attacked_dct_blue);

            set_root_data(handles,'attacked_decode_dct_red',watermarked_attacked_dct_red);
            set_root_data(handles,'attacked_decode_dct_green',watermarked_attacked_dct_green);
            set_root_data(handles,'attacked_decode_dct_blue',watermarked_attacked_dct_blue);
            
            set_root_data(handles,'attacked_attacked_dwt_red',watermarked_attacked_dwt_red);
            set_root_data(handles,'attacked_attacked_dwt_green',watermarked_attacked_dwt_green);
            set_root_data(handles,'attacked_attacked_dwt_blue',watermarked_attacked_dwt_blue);

            set_root_data(handles,'attacked_decode_dwt_red',watermarked_attacked_dwt_red);
            set_root_data(handles,'attacked_decode_dwt_green',watermarked_attacked_dwt_green);
            set_root_data(handles,'attacked_decode_dwt_blue',watermarked_attacked_dwt_blue);
            
            set_root_data(handles,'attacked_attacked_plot_rgb',watermarked_attacked_working_rgb);
            set_root_data(handles,'attacked_attacked_plot_red',watermarked_attacked_plot_red);
            set_root_data(handles,'attacked_attacked_plot_green',watermarked_attacked_plot_green);
            set_root_data(handles,'attacked_attacked_plot_blue',watermarked_attacked_plot_blue);

            set_root_data(handles,'attacked_decode_plot_rgb',watermarked_attacked_working_rgb);
            set_root_data(handles,'attacked_decode_plot_red',watermarked_attacked_plot_red);
            set_root_data(handles,'attacked_decode_plot_green',watermarked_attacked_plot_green);
            set_root_data(handles,'attacked_decode_plot_blue',watermarked_attacked_plot_blue);
            
            set_root_data(handles,'attacked_decode_working_ycbcr',watermarked_attacked_working_ycbcr);
            set_root_data(handles,'attacked_decode_working_y',watermarked_attacked_working_y);
            set_root_data(handles,'attacked_decode_working_cb',watermarked_attacked_working_cb);
            set_root_data(handles,'attacked_decode_working_cr',watermarked_attacked_working_cr);
            
            set_root_data(handles,'attacked_attacked_dct_y',watermarked_attacked_dct_y);
            set_root_data(handles,'attacked_attacked_dct_cb',watermarked_attacked_dct_cb);
            set_root_data(handles,'attacked_attacked_dct_cr',watermarked_attacked_dct_cr);

            set_root_data(handles,'attacked_decode_dct_y',watermarked_attacked_dct_y);
            set_root_data(handles,'attacked_decode_dct_cb',watermarked_attacked_dct_cb);
            set_root_data(handles,'attacked_decode_dct_cr',watermarked_attacked_dct_cr);
            
            set_root_data(handles,'attacked_attacked_dwt_y',watermarked_attacked_dwt_y);
            set_root_data(handles,'attacked_attacked_dwt_cb',watermarked_attacked_dwt_cb);
            set_root_data(handles,'attacked_attacked_dwt_cr',watermarked_attacked_dwt_cr);

            set_root_data(handles,'attacked_decode_dwt_y',watermarked_attacked_dwt_y);
            set_root_data(handles,'attacked_decode_dwt_cb',watermarked_attacked_dwt_cb);
            set_root_data(handles,'attacked_decode_dwt_cr',watermarked_attacked_dwt_cr);
            
            set_root_data(handles,'attacked_attacked_plot_ycbcr',watermarked_attacked_plot_ycbcr);
            set_root_data(handles,'attacked_attacked_plot_y',watermarked_attacked_plot_y);
            set_root_data(handles,'attacked_attacked_plot_cb',watermarked_attacked_plot_cb);
            set_root_data(handles,'attacked_attacked_plot_cr',watermarked_attacked_plot_cr);

            set_root_data(handles,'attacked_decode_plot_y',watermarked_attacked_plot_y);
            set_root_data(handles,'attacked_decode_plot_cb',watermarked_attacked_plot_cb);
            set_root_data(handles,'attacked_decode_plot_cr',watermarked_attacked_plot_cr);
            
            set(handles.togglebutton_layers_attacked_attacked,'Visible','on');
            set(handles.togglebutton_layers_attacked_attacked,'Enable','on');  
            set(handles.togglebutton_layers_attacked_attacked,'Value',0); 
            set(handles.togglebutton_image_attacked_attacked,'Value',1); 
            
    end;
            
          set(handles.tab_attacked_attacked,'Visible','on');  
          set(handles.tab_image_attacked_attacked,'Visible','on'); 
          set(handles.tab_layers_rgb_attacked_decode,'Visible','off');  
          set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');  
          
          set(handles.togglebutton_decode,'Visible','on');  
          
          set(handles.tab_attacked_decode,'Visible','on');
          
          set(handles.tab_decoded_image,'Visible','off');
          set(handles.tab_decoded_text,'Visible','off');
          
          set(handles.pushbutton_overview,'Visible','off');
  
            