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
%fhupdate_axes: important function. When this function is called it will
%update a specified range of components.
%graph: wich group has to be updated

function fhupdate_axes(graph,im)

attack = get_root_data('attack');

switch attack
    case 'yes'
        
      handles = get_root_data('handles_attack');
      
      axes(handles.imagePreview);
      imshow(im);
      
      
      otherwise

        handles = get_root_data('handles_main');
        
        switch graph
%% Watermarked
            case 'watermarked'
                
                calculate_components_watermarked_embed(handles,im);

                type = get_root_data('image_type');

                switch type
                    case 'grayscale'
                        set(handles.togglebutton_layers_watermarked_embed,'Visible','off');
                        set(handles.togglebutton_layers_watermarked_embed,'Enable','off');
                        
                        set(handles.togglebutton_layers_watermarked_attacked,'Visible','off');
                        set(handles.togglebutton_layers_watermarked_attacked,'Enable','off');
                    case'layered'
                        set(handles.togglebutton_layers_watermarked_embed,'Visible','on');
                        set(handles.togglebutton_layers_watermarked_embed,'Enable','on');
                        
                        set(handles.togglebutton_layers_watermarked_attacked,'Visible','on');
                        set(handles.togglebutton_layers_watermarked_attacked,'Enable','on');
                end;
                
                %initialize the togglebuttons
                set(handles.togglebutton_image_watermarked_embed,'Value',1);             
                set(handles.togglebutton_image_watermarked_embed,'Enable','off');
                
                set(handles.togglebutton_fullcolor_watermarked_embed,'Value',1);
                set(handles.togglebutton_fullcolor_watermarked_embed,'Enable','off');
                
                set(handles.togglebutton_layers_watermarked_embed,'Value',0);
                set(handles.togglebutton_layers_watermarked_embed,'Enable','on');
                
                set(handles.togglebutton_histogram_watermarked_embed,'Enable','on');
                set(handles.togglebutton_histogram_watermarked_embed,'Value',0);
                
                set(handles.togglebutton_dct_watermarked_embed,'Enable','on');
                set(handles.togglebutton_dct_watermarked_embed,'Value',0);
                
                set(handles.togglebutton_dwt_watermarked_embed,'Enable','on');
                set(handles.togglebutton_dwt_watermarked_embed,'Value',0);
                
                %initialize the tabs
                set(handles.tab_embed,'Visible','on'); 
                set(handles.tab_attack,'Visible','off'); 
                set(handles.tab_decode,'Visible','off'); 
                
                set(handles.tab_watermarked_embed,'Visible','on');
                set(handles.tab_image_watermarked_embed,'Visible','on');
                set(handles.tab_layers_rgb_watermarked_embed,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_embed,'Visible','off');
                
                set(handles.tab_watermarked_attacked,'Visible','on');
                set(handles.tab_image_watermarked_attacked,'Visible','on');
                set(handles.tab_layers_rgb_watermarked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_watermarked_attacked,'Visible','off');

                set(handles.axes_image_watermarked_embed,'Visible','on');
                axes(handles.axes_image_watermarked_embed);
                axis off;
                
                set(handles.axes_image_watermarked_attacked,'Visible','on');
                axes(handles.axes_image_watermarked_attacked);
                axis off;
                
                set(handles.togglebutton_attack,'Visible','on');
                set(handles.togglebutton_decode,'Visible','off');

%% Attacked
            case 'attacked'
                
                handles = get_root_data('handles_main');
                
                calculate_components_attacked_attacked(handles,im);

                type = get_root_data('image_type');

                switch type
                    case 'grayscale'
                        set(handles.togglebutton_image_attacked_decode,'Enable','off');
                        
                        set(handles.togglebutton_layers_attacked_attacked,'Visible','off');
                        set(handles.togglebutton_layers_attacked_attacked,'Enable','off');
                        
                        set(handles.togglebutton_layers_attacked_decode,'Visible','off');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','off');
                    case'layered'
                        set(handles.togglebutton_layers_attacked_attacked,'Visible','on');
                        set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
                        
                        set(handles.togglebutton_layers_attacked_decode,'Visible','on');
                        set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                end;

                
                
                %initialize the togglebuttons
                set(handles.togglebutton_image_attacked_attacked,'Value',1);             
                set(handles.togglebutton_image_attacked_attacked,'Enable','off');
                
                set(handles.togglebutton_fullcolor_attacked_attacked,'Value',1);
                set(handles.togglebutton_fullcolor_attacked_attacked,'Enable','off');
                
                set(handles.togglebutton_layers_attacked_attacked,'Value',0);
                set(handles.togglebutton_layers_attacked_attacked,'Enable','on');
                
                set(handles.togglebutton_histogram_attacked_attacked,'Enable','on');
                set(handles.togglebutton_histogram_attacked_attacked,'Value',0);
                
                set(handles.togglebutton_dct_attacked_attacked,'Enable','on');
                set(handles.togglebutton_dct_attacked_attacked,'Value',0);
                
                set(handles.togglebutton_dwt_attacked_attacked,'Enable','on');
                set(handles.togglebutton_dwt_attacked_attacked,'Value',0);
                
                set(handles.togglebutton_image_attacked_decode,'Value',1);             
                set(handles.togglebutton_image_attacked_decode,'Enable','off');
                
                set(handles.togglebutton_fullcolor_attacked_decode,'Value',1);
                set(handles.togglebutton_fullcolor_attacked_decode,'Enable','off');
                
                set(handles.togglebutton_layers_attacked_decode,'Value',0);
                set(handles.togglebutton_layers_attacked_decode,'Enable','on');
                
                set(handles.togglebutton_histogram_attacked_decode,'Enable','on');
                set(handles.togglebutton_histogram_attacked_decode,'Value',0);
                
                set(handles.togglebutton_dct_attacked_decode,'Enable','on');
                set(handles.togglebutton_dct_attacked_decode,'Value',0);
                
                set(handles.togglebutton_dwt_attacked_decode,'Enable','on');
                set(handles.togglebutton_dwt_attacked_decode,'Value',0);
                
                
                %initialize the tabs
                set(handles.tab_embed,'Visible','off'); 
                set(handles.tab_attack,'Visible','on'); 
                set(handles.tab_decode,'Visible','off'); 
                set(handles.tab_attacked_attacked,'Visible','on');
                set(handles.tab_attacked_decode,'Visible','on');
                
                set(handles.tab_layers_rgb_attacked_attacked,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_attacked,'Visible','off');
                set(handles.tab_image_attacked_attacked,'Visible','on');
                
                set(handles.tab_layers_rgb_attacked_decode,'Visible','off');
                set(handles.tab_layers_ycbcr_attacked_decode,'Visible','off');
                set(handles.tab_image_attacked_decode,'Visible','on');
                
                set(handles.axes_image_attacked_attacked,'Visible','on');
                axes(handles.axes_image_attacked_attacked);
                axis off;

                set(handles.axes_image_attacked_decode,'Visible','on');
                axes(handles.axes_image_attacked_decode);
                axis off;
                
                set(handles.togglebutton_attack,'Visible','on');
                set(handles.togglebutton_decode,'Visible','on');
                
                 set(handles.tab_attacked_decode,'Visible','on');
                 
                 set(handles.pushbutton_overview,'Visible','off');
            case 'text'
                
                set(handles.tab_decoded_text,'Visible','on');
                set(handles.tab_decoded_image,'Visible','off');
                
                set(handles.edit_decoded_information,'String',im);
                
                set(handles.pushbutton_overview,'Visible','on');
            case 'image'
                set(handles.tab_decoded_text,'Visible','off');
                set(handles.tab_decoded_image,'Visible','on');
                
                axes(handles.axes_decoded_image);
                imshow(im);
                
                set(handles.pushbutton_overview,'Visible','on');
                
        end;
end;

part = get_root_data('part');                           %part is the percentage of pixels of the message that could not be embedded in the cover work. If part is -1, then the whole message was embedded
if (part ~= -1)                                         %This is done to show a warning message, indicating that not the entire message could be embedded in the cover work    
    msgbox(['Message too large for cover work, only ', num2str(part) , '% ',' of it will be embedded.'], 'Warning', 'help');
end
        
