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
%set_root_data: In this function you place data in the global memory. In
%the case of some property names axes will be automaticly update. 
%@property_name: the name under wich the data has to be stored
%@property_data: the data that comes with the name

function set_root_data(handles,property_name,property_data )

hroot_data = getappdata(0,'hroot_data');
setappdata(hroot_data, property_name,property_data);

switch property_name

%% Histogram settings
    case 'original_histogram_grayscale'
                [histogram_gray,nvt1,nvt2] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_original);
                
                stem(histogram_gray,'.k','Markersize',1);
                axis off;
    case 'original_histogram_rgb'
                [histogram_r,histogram_g,histogram_b] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_original);
                stem(histogram_r,'.r','Markersize',1);
                hold;
                stem(histogram_g,'.g','Markersize',1);
                stem(histogram_b,'.b','Markersize',1);
                hold off;
                axis off;
    case 'original_histogram_ycbcr'
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_image_original);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
    case 'original_histogram_icon_rgb'            
                [histogram_red,histogram_green,histogram_blue] = histogram(property_data,'rgb');
                
                axes(handles.axes_icon_rgb_original);
                stem(histogram_red,'.r','Markersize',1);
                hold;
                stem(histogram_green,'.g','Markersize',1);
                stem(histogram_blue,'.b','Markersize',1);
                hold off;
                axis off;
    case 'original_histogram_icon_ycbcr'            
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_icon_ycbcr_original);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
    case 'original_histogram_red'
                 [histogram_red,nvt1,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_red_original);
                 stem(histogram_red,'.r','Markersize',1);
                 axis off;
    case 'original_histogram_y'
                 [histogram_y,nvt1,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_y_original);
                 stem(histogram_y,'.k','Markersize',1);
                 axis off;
    case 'original_histogram_green'
                 [nvt1,histogram_green,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_green_original);
                 stem(histogram_green,'.g','Markersize',1);
                 axis off;
    case 'original_histogram_cb'
                 [nvt1,histogram_cb,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cb_original);
                 stem(histogram_cb,'.c','Markersize',1);
                 axis off;
    case 'original_histogram_blue'
                 [nvt1,nvt2,histogram_blue] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_blue_original);
                 stem(histogram_blue,'.b','Markersize',1);
                 axis off;
    case 'original_histogram_cr'
                 [nvt1,nvt2,histogram_cr] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cr_original);
                 stem(histogram_cr,'.m','Markersize',1);
                 axis off;
%% Original settings
    case 'original_plot_rgb'
                axes(handles.axes_image_original);
                imshow(property_data);
                
                axes(handles.axes_icon_rgb_original);
                imshow(property_data);
                
                axes(handles.axes_icon_ycbcr_original);
                imshow(property_data);
    case 'original_plot_grayscale'
                axes(handles.axes_image_original);
                imshow(property_data);
    case 'original_plot_red'
                axes(handles.axes_layer_red_original);
                imshow(property_data);
    case 'original_plot_y'
                axes(handles.axes_layer_y_original);
                imshow(property_data);
    case 'original_plot_green'
                axes(handles.axes_layer_green_original);
                imshow(property_data);
    case 'original_plot_cb'
                axes(handles.axes_layer_cb_original);
                imshow(property_data);
    case 'original_plot_blue'
                axes(handles.axes_layer_blue_original);
                imshow(property_data);
    case 'original_plot_cr'
                axes(handles.axes_layer_cr_original);
                imshow(property_data);
                
                
%% Watermarking Calculations                
                
    case 'watermarked_embed_histogram_grayscale'
                [histogram_gray,nvt1,nvt2] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_watermarked_embed);
                stem(histogram_gray,'.k','Markersize',1);
                axis off;
                                
    case 'watermarked_embed_histogram_rgb'
                [histogram_r,histogram_g,histogram_b] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_watermarked_embed);
                stem(histogram_r,'.r','Markersize',1);
                hold;
                stem(histogram_g,'.g','Markersize',1);
                stem(histogram_b,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_embed_histogram_ycbcr'
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_image_watermarked_embed);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_embed_histogram_icon_rgb'            
                [histogram_red,histogram_green,histogram_blue] = histogram(property_data,'rgb');
                
                axes(handles.axes_icon_rgb_watermarked_embed);
                stem(histogram_red,'.r','Markersize',1);
                hold;
                stem(histogram_green,'.g','Markersize',1);
                stem(histogram_blue,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_embed_histogram_icon_ycbcr'            
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_icon_ycbcr_watermarked_embed);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_embed_histogram_red'
                 [histogram_red,nvt1,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_red_watermarked_embed);
                 stem(histogram_red,'.r','Markersize',1);
                 axis off;
                                  
    case 'watermarked_embed_histogram_y'
                 [histogram_y,nvt1,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_y_watermarked_embed);
                 stem(histogram_y,'.k','Markersize',1);
                 axis off;
                                  
    case 'watermarked_embed_histogram_green'
                 [nvt1,histogram_green,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_green_watermarked_embed);
                 stem(histogram_green,'.g','Markersize',1);
                 axis off;
                                  
    case 'watermarked_embed_histogram_cb'
                 [nvt1,histogram_cb,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cb_watermarked_embed);
                 stem(histogram_cb,'.c','Markersize',1);
                 axis off;
                                  
    case 'watermarked_embed_histogram_blue'
                 [nvt1,nvt2,histogram_blue] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_blue_watermarked_embed);
                 stem(histogram_blue,'.b','Markersize',1);
                 axis off;
                                  
    case 'watermarked_embed_histogram_cr'
                 [nvt1,nvt2,histogram_cr] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cr_watermarked_embed);
                 stem(histogram_cr,'.m','Markersize',1);
                 axis off;
                                  
%% Original settings
    case 'watermarked_embed_plot_rgb'
                axes(handles.axes_image_watermarked_embed);
                imshow(property_data);
                
                axes(handles.axes_icon_rgb_watermarked_embed);
                imshow(property_data);
                
                axes(handles.axes_icon_ycbcr_watermarked_embed);
                imshow(property_data);
                                
    case 'watermarked_embed_plot_grayscale'
                axes(handles.axes_image_watermarked_embed);
                imshow(property_data);
                                
    case 'watermarked_embed_plot_red'
                axes(handles.axes_layer_red_watermarked_embed);
                imshow(property_data);
                                
    case 'watermarked_embed_plot_y'
                axes(handles.axes_layer_y_watermarked_embed);
                imshow(property_data);
    case 'watermarked_embed_plot_green'
                axes(handles.axes_layer_green_watermarked_embed);
                imshow(property_data);
                                
    case 'watermarked_embed_plot_cb'
                axes(handles.axes_layer_cb_watermarked_embed);
                imshow(property_data);
                
    case 'watermarked_embed_plot_blue'
                axes(handles.axes_layer_blue_watermarked_embed);
                imshow(property_data);
                
    case 'watermarked_embed_plot_cr'
                axes(handles.axes_layer_cr_watermarked_embed);
                imshow(property_data);
    case 'watermarked_attacked_histogram_grayscale'
                [histogram_gray,nvt1,nvt2] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_watermarked_attacked);
                stem(histogram_gray,'.k','Markersize',1);
                axis off;
                                
    case 'watermarked_attacked_histogram_rgb'
                [histogram_r,histogram_g,histogram_b] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_watermarked_attacked);
                stem(histogram_r,'.r','Markersize',1);
                hold;
                stem(histogram_g,'.g','Markersize',1);
                stem(histogram_b,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_attacked_histogram_ycbcr'
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_image_watermarked_attacked);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_attacked_histogram_icon_rgb'            
                [histogram_red,histogram_green,histogram_blue] = histogram(property_data,'rgb');
                
                axes(handles.axes_icon_rgb_watermarked_attacked);
                stem(histogram_red,'.r','Markersize',1);
                hold;
                stem(histogram_green,'.g','Markersize',1);
                stem(histogram_blue,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_attacked_histogram_icon_ycbcr'            
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_icon_ycbcr_watermarked_attacked);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'watermarked_attacked_histogram_red'
                 [histogram_red,nvt1,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_red_watermarked_attacked);
                 stem(histogram_red,'.r','Markersize',1);
                 axis off;
                                  
    case 'watermarked_attacked_histogram_y'
                 [histogram_y,nvt1,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_y_watermarked_attacked);
                 stem(histogram_y,'.k','Markersize',1);
                 axis off;
                                  
    case 'watermarked_attacked_histogram_green'
                 [nvt1,histogram_green,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_green_watermarked_attacked);
                 stem(histogram_green,'.g','Markersize',1);
                 axis off;
                                  
    case 'watermarked_attacked_histogram_cb'
                 [nvt1,histogram_cb,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cb_watermarked_attacked);
                 stem(histogram_cb,'.c','Markersize',1);
                 axis off;
                                  
    case 'watermarked_attacked_histogram_blue'
                 [nvt1,nvt2,histogram_blue] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_blue_watermarked_attacked);
                 stem(histogram_blue,'.b','Markersize',1);
                 axis off;
                                  
    case 'watermarked_attacked_histogram_cr'
                 [nvt1,nvt2,histogram_cr] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cr_watermarked_attacked);
                 stem(histogram_cr,'.m','Markersize',1);
                 axis off;
                                  
%% Original settings
    case 'watermarked_attacked_plot_rgb'
                axes(handles.axes_image_watermarked_attacked);
                imshow(property_data);
                
                axes(handles.axes_icon_rgb_watermarked_attacked);
                imshow(property_data);
                
                axes(handles.axes_icon_ycbcr_watermarked_attacked);
                imshow(property_data);
                                
    case 'watermarked_attacked_plot_grayscale'
                axes(handles.axes_image_watermarked_attacked);
                imshow(property_data);
                                
    case 'watermarked_attacked_plot_red'
                axes(handles.axes_layer_red_watermarked_attacked);
                imshow(property_data);
                                
    case 'watermarked_attacked_plot_y'
                axes(handles.axes_layer_y_watermarked_attacked);
                imshow(property_data);
    case 'watermarked_attacked_plot_green'
                axes(handles.axes_layer_green_watermarked_attacked);
                imshow(property_data);
                                
    case 'watermarked_attacked_plot_cb'
                axes(handles.axes_layer_cb_watermarked_attacked);
                imshow(property_data);
                
    case 'watermarked_attacked_plot_blue'
                axes(handles.axes_layer_blue_watermarked_attacked);
                imshow(property_data);
                
    case 'watermarked_attacked_plot_cr'
                axes(handles.axes_layer_cr_watermarked_attacked);
                imshow(property_data);  
                
%% Attacked Attacked

   case 'attacked_attacked_histogram_grayscale'
                [histogram_gray,nvt1,nvt2] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_attacked_attacked);
                stem(histogram_gray,'.k','Markersize',1);
                axis off;
                                
    case 'attacked_attacked_histogram_rgb'
                [histogram_r,histogram_g,histogram_b] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_attacked_attacked);
                stem(histogram_r,'.r','Markersize',1);
                hold;
                stem(histogram_g,'.g','Markersize',1);
                stem(histogram_b,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_attacked_histogram_ycbcr'
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_image_attacked_attacked);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_attacked_histogram_icon_rgb'            
                [histogram_red,histogram_green,histogram_blue] = histogram(property_data,'rgb');
                
                axes(handles.axes_icon_rgb_attacked_attacked);
                stem(histogram_red,'.r','Markersize',1);
                hold;
                stem(histogram_green,'.g','Markersize',1);
                stem(histogram_blue,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_attacked_histogram_icon_ycbcr'            
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_icon_ycbcr_attacked_attacked);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_attacked_histogram_red'
                 [histogram_red,nvt1,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_red_attacked_attacked);
                 stem(histogram_red,'.r','Markersize',1);
                 axis off;
                                  
    case 'attacked_attacked_histogram_y'
                 [histogram_y,nvt1,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_y_attacked_attacked);
                 stem(histogram_y,'.k','Markersize',1);
                 axis off;
                                  
    case 'attacked_attacked_histogram_green'
                 [nvt1,histogram_green,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_green_attacked_attacked);
                 stem(histogram_green,'.g','Markersize',1);
                 axis off;
                                  
    case 'attacked_attacked_histogram_cb'
                 [nvt1,histogram_cb,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cb_attacked_attacked);
                 stem(histogram_cb,'.c','Markersize',1);
                 axis off;
                                  
    case 'attacked_attacked_histogram_blue'
                 [nvt1,nvt2,histogram_blue] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_blue_attacked_attacked);
                 stem(histogram_blue,'.b','Markersize',1);
                 axis off;
                                  
    case 'attacked_attacked_histogram_cr'
                 [nvt1,nvt2,histogram_cr] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cr_attacked_attacked);
                 stem(histogram_cr,'.m','Markersize',1);
                 axis off;
                                  
%% Original settings
    case 'attacked_attacked_plot_rgb'
                axes(handles.axes_image_attacked_attacked);
                imshow(property_data);
                
                axes(handles.axes_icon_rgb_attacked_attacked);
                imshow(property_data);
                
                axes(handles.axes_icon_ycbcr_attacked_attacked);
                imshow(property_data);
                                
    case 'attacked_attacked_plot_grayscale'
                axes(handles.axes_image_attacked_attacked);
                imshow(property_data);
                                
    case 'attacked_attacked_plot_red'
                axes(handles.axes_layer_red_attacked_attacked);
                imshow(property_data);
                                
    case 'attacked_attacked_plot_y'
                axes(handles.axes_layer_y_attacked_attacked);
                imshow(property_data);
    case 'attacked_attacked_plot_green'
                axes(handles.axes_layer_green_attacked_attacked);
                imshow(property_data);
                                
    case 'attacked_attacked_plot_cb'
                axes(handles.axes_layer_cb_attacked_attacked);
                imshow(property_data);
                
    case 'attacked_attacked_plot_blue'
                axes(handles.axes_layer_blue_attacked_attacked);
                imshow(property_data);
                
    case 'attacked_attacked_plot_cr'
                axes(handles.axes_layer_cr_attacked_attacked);
                imshow(property_data);  
                
%% Attacked decode

    case 'attacked_decode_histogram_grayscale'
                [histogram_gray,nvt1,nvt2] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_attacked_decode);
                stem(histogram_gray,'.k','Markersize',1);
                axis off;
                                
    case 'attacked_decode_histogram_rgb'
                [histogram_r,histogram_g,histogram_b] = histogram(property_data,'rgb');
                
                axes(handles.axes_image_attacked_decode);
                stem(histogram_r,'.r','Markersize',1);
                hold;
                stem(histogram_g,'.g','Markersize',1);
                stem(histogram_b,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_decode_histogram_ycbcr'
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_image_attacked_decode);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_decode_histogram_icon_rgb'            
                [histogram_red,histogram_green,histogram_blue] = histogram(property_data,'rgb');
                
                axes(handles.axes_icon_rgb_attacked_decode);
                stem(histogram_red,'.r','Markersize',1);
                hold;
                stem(histogram_green,'.g','Markersize',1);
                stem(histogram_blue,'.b','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_decode_histogram_icon_ycbcr'            
                [histogram_y,histogram_cb,histogram_cr] = histogram(property_data,'ycbcr');
                
                axes(handles.axes_icon_ycbcr_attacked_decode);
                stem(histogram_y,'.k','Markersize',1);
                hold;
                stem(histogram_cb,'.c','Markersize',1);
                stem(histogram_cr,'.m','Markersize',1);
                hold off;
                axis off;
                                
    case 'attacked_decode_histogram_red'
                 [histogram_red,nvt1,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_red_attacked_decode);
                 stem(histogram_red,'.r','Markersize',1);
                 axis off;
                                  
    case 'attacked_decode_histogram_y'
                 [histogram_y,nvt1,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_y_attacked_decode);
                 stem(histogram_y,'.k','Markersize',1);
                 axis off;
                                  
    case 'attacked_decode_histogram_green'
                 [nvt1,histogram_green,nvt2] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_green_attacked_decode);
                 stem(histogram_green,'.g','Markersize',1);
                 axis off;
                                  
    case 'attacked_decode_histogram_cb'
                 [nvt1,histogram_cb,nvt2] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cb_attacked_decode);
                 stem(histogram_cb,'.c','Markersize',1);
                 axis off;
                                  
    case 'attacked_decode_histogram_blue'
                 [nvt1,nvt2,histogram_blue] = histogram(property_data,'rgb');
                 axes(handles.axes_layer_blue_attacked_decode);
                 stem(histogram_blue,'.b','Markersize',1);
                 axis off;
                                  
    case 'attacked_decode_histogram_cr'
                 [nvt1,nvt2,histogram_cr] = histogram(property_data,'ycbcr');
                 axes(handles.axes_layer_cr_attacked_decode);
                 stem(histogram_cr,'.m','Markersize',1);
                 axis off;
                                  
%% Original settings
    case 'attacked_decode_plot_rgb'
                axes(handles.axes_image_attacked_decode);
                imshow(property_data);
                
                axes(handles.axes_icon_rgb_attacked_decode);
                imshow(property_data);
                
                axes(handles.axes_icon_ycbcr_attacked_decode);
                imshow(property_data);
                                
    case 'attacked_decode_plot_grayscale'
                axes(handles.axes_image_attacked_decode);
                imshow(property_data);
                                
    case 'attacked_decode_plot_red'
                axes(handles.axes_layer_red_attacked_decode);
                imshow(property_data);
                                
    case 'attacked_decode_plot_y'
                axes(handles.axes_layer_y_attacked_decode);
                imshow(property_data);
    case 'attacked_decode_plot_green'
                axes(handles.axes_layer_green_attacked_decode);
                imshow(property_data);
                                
    case 'attacked_decode_plot_cb'
                axes(handles.axes_layer_cb_attacked_decode);
                imshow(property_data);
                
    case 'attacked_decode_plot_blue'
                axes(handles.axes_layer_blue_attacked_decode);
                imshow(property_data);
                
    case 'attacked_decode_plot_cr'
                axes(handles.axes_layer_cr_attacked_decode);
                imshow(property_data);
end;


                                
                

        

