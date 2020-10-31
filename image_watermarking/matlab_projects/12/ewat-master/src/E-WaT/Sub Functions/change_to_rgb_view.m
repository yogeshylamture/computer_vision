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
%change_to_rgb_view: changes the entire color represantion to RGB spectrum
%handles: parameter


function change_to_rgb_view(handles)
%% original
                fullcolor = get(handles.togglebutton_fullcolor_original,'Value');
                presentation = get(handles.togglebutton_layers_original,'Value');
                
                set(handles.radiobutton_rgb,'Enable','off')
                set(handles.radiobutton_ycbcr,'Enable','on')
                
                set(handles.radiobutton_icon_ycbcr_original,'Value',0);
                set(handles.radiobutton_icon_rgb_original,'Value',1);
                
                image_rgb = get_root_data('original_plot_rgb');

                switch fullcolor
                    case 0.0        %Full color is not selected
                       set(handles.label_image_original,'String','RGB Histogram ');
                        switch presentation
                             case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_original,'Visible','on');
                                set(handles.tab_layers_ycbcr_original,'Visible','off');
                                set(handles.tab_image_original,'Visible','off');
                                
                                set(handles.radiobutton_icon_rgb_original,'Visible','off');
                                set(handles.radiobutton_icon_ycbcr_original,'Visible','off');
                                
                                set(handles.radiobutton_layer_red_original,'Visible','off');
                                set(handles.radiobutton_layer_red_original,'Value',0);
                                
                                set(handles.radiobutton_layer_y_original,'Visible','off');
                                set(handles.radiobutton_layer_y_original,'Value',0);
                               
                                set(handles.radiobutton_layer_green_original,'Visible','off');
                                set(handles.radiobutton_layer_green_original,'Value',0);
                                
                                set(handles.radiobutton_layer_cb_original,'Visible','off');
                                set(handles.radiobutton_layer_cb_original,'Value',0);
                                
                                set(handles.radiobutton_layer_blue_original,'Visible','off');
                                set(handles.radiobutton_layer_blue_original,'Value',0);
                                
                                set(handles.radiobutton_layer_cr_original,'Visible','off');
                                set(handles.radiobutton_layer_cr_original,'Value',0);
                                
                                set_root_data(handles,'original_histogram_rgb', image_rgb);
                                
                            case 0.0        %image is visible
                                set_root_data(handles,'original_histogram_rgb', image_rgb);
                        end;
                    case 1.0        %Fullcolor is selected
                       switch presentation
                            case 1.0        %layers are visible
                                set(handles.tab_layers_ycbcr_original,'Visible','off');
                                set(handles.tab_image_original,'Visible','off');
                                set(handles.tab_layers_rgb_original,'Visible','on');

                                set(handles.radiobutton_icon_rgb_original,'Value',1);
                                set(handles.radiobutton_icon_rgb_original,'Enable','off');
                                set(handles.radiobutton_icon_rgb_original,'Visible','on')
                                
                                set(handles.radiobutton_layer_red_original,'Enable','on');
                                set(handles.radiobutton_layer_red_original,'Value',0);
                                set(handles.radiobutton_layer_red_original,'Visible','on')
                                
                                set(handles.radiobutton_layer_green_original,'Enable','on');
                                set(handles.radiobutton_layer_green_original,'Value',0);
                                set(handles.radiobutton_layer_green_original,'Visible','on');
                                
                                set(handles.radiobutton_layer_blue_original,'Enable','on');
                                set(handles.radiobutton_layer_blue_original,'Value',0);
                                set(handles.radiobutton_layer_blue_original,'Visible','on');
                                
                             case 0.0
                        end;
                end;
                
%% Watermarked embed
                fullcolor = get(handles.togglebutton_fullcolor_watermarked_embed,'Value');
                presentation = get(handles.togglebutton_layers_watermarked_embed,'Value');
                
                set(handles.radiobutton_icon_ycbcr_watermarked_embed,'Value',0);
                set(handles.radiobutton_icon_rgb_watermarked_embed,'Value',1);
                
                image_rgb = get_root_data('watermarked_embed_plot_rgb');

                switch fullcolor
                    case 0.0        %Full color is not selected
                       set(handles.label_image_watermarked_embed,'String','RGB Histogram ');
                        switch presentation
                             case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_watermarked_embed,'Visible','on');
                                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');
                                set(handles.tab_image_watermarked_embed,'Visible','off');
                                
                                set(handles.radiobutton_icon_rgb_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_icon_ycbcr_watermarked_embed,'Visible','off');
                                
                                set(handles.radiobutton_layer_red_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_red_watermarked_embed,'Value',0);
                                
                                set(handles.radiobutton_layer_y_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_y_watermarked_embed,'Value',0);
                               
                                set(handles.radiobutton_layer_green_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_green_watermarked_embed,'Value',0);
                                
                                set(handles.radiobutton_layer_cb_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_cb_watermarked_embed,'Value',0);
                                
                                set(handles.radiobutton_layer_blue_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_blue_watermarked_embed,'Value',0);
                                
                                set(handles.radiobutton_layer_cr_watermarked_embed,'Visible','off');
                                set(handles.radiobutton_layer_cr_watermarked_embed,'Value',0);
                                
                                set_root_data(handles,'watermarked_embed_histogram_rgb', image_rgb);
                                
                            case 0.0        %image is visible
                                set_root_data(handles,'watermarked_embed_histogram_rgb', image_rgb);
                        end;
                    case 1.0        %Fullcolor is selected
                       switch presentation
                            case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_watermarked_embed,'Visible','on');
                                set(handles.tab_image_watermarked_embed,'Visible','off');
                                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');

                                set(handles.radiobutton_icon_rgb_watermarked_embed,'Value',1);
                                set(handles.radiobutton_icon_rgb_watermarked_embed,'Enable','off');
                                set(handles.radiobutton_icon_rgb_watermarked_embed,'Visible','on')
                                
                                set(handles.radiobutton_layer_red_watermarked_embed,'Enable','on');
                                set(handles.radiobutton_layer_red_watermarked_embed,'Value',0);
                                set(handles.radiobutton_layer_red_watermarked_embed,'Visible','on')
                                
                                set(handles.radiobutton_layer_green_watermarked_embed,'Enable','on');
                                set(handles.radiobutton_layer_green_watermarked_embed,'Value',0);
                                set(handles.radiobutton_layer_green_watermarked_embed,'Visible','on');
                                
                                set(handles.radiobutton_layer_blue_watermarked_embed,'Enable','on');
                                set(handles.radiobutton_layer_blue_watermarked_embed,'Value',0);
                                set(handles.radiobutton_layer_blue_watermarked_embed,'Visible','on');
                                
                             case 0.0
                        end;
                end;
%% Watermarked attacked
                fullcolor = get(handles.togglebutton_fullcolor_watermarked_attacked,'Value');
                presentation = get(handles.togglebutton_layers_watermarked_attacked,'Value');
                
                set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Value',0);
                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',1);
                
                image_rgb = get_root_data('watermarked_attacked_plot_rgb');

                switch fullcolor
                    case 0.0        %Full color is not selected
                       set(handles.label_image_watermarked_attacked,'String','RGB Histogram ');
                        switch presentation
                             case 1.0        %layers are visible
                                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');
                                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','on');
                                set(handles.tab_image_watermarked_attacked,'Visible','off');
                                
                                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_icon_ycbcr_watermarked_attacked,'Visible','off');
                                
                                set(handles.radiobutton_layer_red_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_y_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_y_watermarked_attacked,'Value',0);
                               
                                set(handles.radiobutton_layer_green_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_cb_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_cb_watermarked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_blue_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_cr_watermarked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_cr_watermarked_attacked,'Value',0);
                                
                                set_root_data(handles,'watermarked_attacked_histogram_rgb', image_rgb);
                                
                            case 0.0        %image is visible
                                set_root_data(handles,'watermarked_attacked_histogram_rgb', image_rgb);
                        end;
                    case 1.0        %Fullcolor is selected
                       switch presentation
                            case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','on');
                                set(handles.tab_image_watermarked_attacked,'Visible','off');
                                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');

                                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Value',1);
                                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Enable','off');
                                set(handles.radiobutton_icon_rgb_watermarked_attacked,'Visible','on')
                                
                                set(handles.radiobutton_layer_red_watermarked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_red_watermarked_attacked,'Value',0);
                                set(handles.radiobutton_layer_red_watermarked_attacked,'Visible','on')
                                
                                set(handles.radiobutton_layer_green_watermarked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_green_watermarked_attacked,'Value',0);
                                set(handles.radiobutton_layer_green_watermarked_attacked,'Visible','on');
                                
                                set(handles.radiobutton_layer_blue_watermarked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_blue_watermarked_attacked,'Value',0);
                                set(handles.radiobutton_layer_blue_watermarked_attacked,'Visible','on');
                                
                             case 0.0
                        end;
                end;
%% Attacked attacked
                fullcolor = get(handles.togglebutton_fullcolor_attacked_attacked,'Value');
                presentation = get(handles.togglebutton_layers_attacked_attacked,'Value');
                
                set(handles.radiobutton_icon_ycbcr_attacked_attacked,'Value',0);
                set(handles.radiobutton_icon_rgb_attacked_attacked,'Value',1);
                
                image_rgb = get_root_data('attacked_attacked_plot_rgb');

                switch fullcolor
                    case 0.0        %Full color is not selected
                       set(handles.label_image_attacked_attacked,'String','RGB Histogram ');
                        switch presentation
                             case 1.0        %layers are visible
                                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
                                set(handles.tab_layers_rgb_attacked_attacked,'Visible','on');
                                set(handles.tab_image_attacked_attacked,'Visible','off');
                                
                                set(handles.radiobutton_icon_rgb_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_icon_ycbcr_attacked_attacked,'Visible','off');
                                
                                set(handles.radiobutton_layer_red_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_red_attacked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_y_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_y_attacked_attacked,'Value',0);
                               
                                set(handles.radiobutton_layer_green_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_green_attacked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_cb_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_cb_attacked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_blue_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_blue_attacked_attacked,'Value',0);
                                
                                set(handles.radiobutton_layer_cr_attacked_attacked,'Visible','off');
                                set(handles.radiobutton_layer_cr_attacked_attacked,'Value',0);
                                
                                set_root_data(handles,'attacked_attacked_histogram_rgb', image_rgb);
                                
                            case 0.0        %image is visible
                                set_root_data(handles,'attacked_attacked_histogram_rgb', image_rgb);
                        end;
                    case 1.0        %Fullcolor is selected
                       switch presentation
                            case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_attacked_attacked,'Visible','on');
                                set(handles.tab_image_attacked_attacked,'Visible','off');
                                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');

                                set(handles.radiobutton_icon_rgb_attacked_attacked,'Value',1);
                                set(handles.radiobutton_icon_rgb_attacked_attacked,'Enable','off');
                                set(handles.radiobutton_icon_rgb_attacked_attacked,'Visible','on')
                                
                                set(handles.radiobutton_layer_red_attacked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_red_attacked_attacked,'Value',0);
                                set(handles.radiobutton_layer_red_attacked_attacked,'Visible','on')
                                
                                set(handles.radiobutton_layer_green_attacked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_green_attacked_attacked,'Value',0);
                                set(handles.radiobutton_layer_green_attacked_attacked,'Visible','on');
                                
                                set(handles.radiobutton_layer_blue_attacked_attacked,'Enable','on');
                                set(handles.radiobutton_layer_blue_attacked_attacked,'Value',0);
                                set(handles.radiobutton_layer_blue_attacked_attacked,'Visible','on');
                                
                             case 0.0
                        end;
                end;
                
                fullcolor = get(handles.togglebutton_fullcolor_attacked_decode,'Value');
                presentation = get(handles.togglebutton_layers_attacked_decode,'Value');
                
                set(handles.radiobutton_icon_ycbcr_attacked_decode,'Value',0);
                set(handles.radiobutton_icon_rgb_attacked_decode,'Value',1);
                
                image_rgb = get_root_data('attacked_decode_plot_rgb');

                switch fullcolor
                    case 0.0        %Full color is not selected
                       set(handles.label_image_attacked_decode,'String','RGB Histogram ');
                        switch presentation
                             case 1.0        %layers are visible
                                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                                set(handles.tab_layers_rgb_attacked_decode,'Visible','on');
                                set(handles.tab_image_attacked_decode,'Visible','off');
                                
                                set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','off');
                                set(handles.radiobutton_icon_ycbcr_attacked_decode,'Visible','off');
                                
                                set(handles.radiobutton_layer_red_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_red_attacked_decode,'Value',0);
                                
                                set(handles.radiobutton_layer_y_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_y_attacked_decode,'Value',0);
                               
                                set(handles.radiobutton_layer_green_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_green_attacked_decode,'Value',0);
                                
                                set(handles.radiobutton_layer_cb_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_cb_attacked_decode,'Value',0);
                                
                                set(handles.radiobutton_layer_blue_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_blue_attacked_decode,'Value',0);
                                
                                set(handles.radiobutton_layer_cr_attacked_decode,'Visible','off');
                                set(handles.radiobutton_layer_cr_attacked_decode,'Value',0);
                                
                                set_root_data(handles,'attacked_decode_histogram_rgb', image_rgb);
                                
                            case 0.0        %image is visible
                                set_root_data(handles,'attacked_decode_histogram_rgb', image_rgb);
                        end;
                    case 1.0        %Fullcolor is selected
                       switch presentation
                            case 1.0        %layers are visible
                                set(handles.tab_layers_rgb_attacked_decode,'Visible','on');
                                set(handles.tab_image_attacked_decode,'Visible','off');
                                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');

                                set(handles.radiobutton_icon_rgb_attacked_decode,'Value',1);
                                set(handles.radiobutton_icon_rgb_attacked_decode,'Enable','off');
                                set(handles.radiobutton_icon_rgb_attacked_decode,'Visible','on')
                                
                                set(handles.radiobutton_layer_red_attacked_decode,'Enable','on');
                                set(handles.radiobutton_layer_red_attacked_decode,'Value',0);
                                set(handles.radiobutton_layer_red_attacked_decode,'Visible','on')
                                
                                set(handles.radiobutton_layer_green_attacked_decode,'Enable','on');
                                set(handles.radiobutton_layer_green_attacked_decode,'Value',0);
                                set(handles.radiobutton_layer_green_attacked_decode,'Visible','on');
                                
                                set(handles.radiobutton_layer_blue_attacked_decode,'Enable','on');
                                set(handles.radiobutton_layer_blue_attacked_decode,'Value',0);
                                set(handles.radiobutton_layer_blue_attacked_decode,'Visible','on');
                                
                             case 0.0
                        end;
                end;