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
%recontruct_from_working_image_for_gui: this function reconstructs an image
% so that calculations can be done on single layer en that the other layers
% are used the reconstruct them so that you get a full RGB image
%@watermarked_image: single layer image
%@rgb_image: rgb image

function rgb_watermarked = recontruct_from_working_image_for_gui(watermarked_image)

used_component = get_root_data('used_component');

attack = get_root_data('attack');

switch attack
    case 'yes'
        switch used_component
            case 'grayscale'
                rgb_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
            case 'ycbcr'
                cb = get_root_data('watermarked_embed_working_cb');
                cr = get_root_data('watermarked_embed_working_cr');

                rgb_watermarked_temp = cat(3,watermarked_image,cb,cr);
                rgb_watermarked = ycbcr2rgb(rgb_watermarked_temp);
            case 'y'
                cb = get_root_data('watermarked_embed_working_cb');
                cr = get_root_data('watermarked_embed_working_cr');

                rgb_watermarked_temp = cat(3,watermarked_image,cb,cr);
                rgb_watermarked = ycbcr2rgb(rgb_watermarked_temp);
            case 'cb'
                y = get_root_data('watermarked_embed_working_y');
                cr = get_root_data('watermarked_embed_working_cr');

                plot_watermarked_cb = cat(3,y,watermarked_image,cr);
                rgb_watermarked = ycbcr2rgb(plot_watermarked_cb);
            case 'cr'
                y = get_root_data('watermarked_embed_working_y');
                cb = get_root_data('watermarked_embed_working_cb');

                plot_watermarked_cr = cat(3,y,cb,watermarked_image);
                rgb_watermarked = ycbcr2rgb(plot_watermarked_cr);
            case 'rgb'
                cb = get_root_data('watermarked_embed_working_cb');
                cr = get_root_data('watermarked_embed_working_cr');

                rgb_watermarked = cat(3,watermarked_image,cb,cr);
            case 'red'
                green = get_root_data('watermarked_embed_working_green');
                blue = get_root_data('watermarked_embed_working_blue');

                rgb_watermarked = cat(3,watermarked_image,green,blue);
            case 'green'
                red = get_root_data('watermarked_embed_working_red');
                blue = get_root_data('watermarked_embed_working_blue');

                rgb_watermarked = cat(3,red,watermarked_image,blue);
            case 'blue'
                red = get_root_data('watermarked_embed_working_red');
                green = get_root_data('watermarked_embed_working_green');

                rgb_watermarked = cat(3,red,green,watermarked_image);
        end;
            otherwise

            switch used_component
                case 'grayscale'
                    rgb_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
                case 'ycbcr'
                    cb = get_root_data('original_working_cb');
                    cr = get_root_data('original_working_cr');

                    rgb_watermarked_temp = cat(3,watermarked_image,cb,cr);
                    rgb_watermarked = ycbcr2rgb(rgb_watermarked_temp);
                case 'y'
                    cb = get_root_data('original_working_cb');
                    cr = get_root_data('original_working_cr');

                    rgb_watermarked_temp = cat(3,watermarked_image,cb,cr);
                    rgb_watermarked = ycbcr2rgb(rgb_watermarked_temp);
                case 'cb'
                    y = get_root_data('original_working_y');
                    cr = get_root_data('original_working_cr');

                    plot_watermarked_cb = cat(3,y,watermarked_image,cr);
                    rgb_watermarked = ycbcr2rgb(plot_watermarked_cb);
                case 'cr'
                    y = get_root_data('original_working_y');
                    cb = get_root_data('original_working_cb');

                    plot_watermarked_cr = cat(3,y,cb,watermarked_image);
                    rgb_watermarked = ycbcr2rgb(plot_watermarked_cr);
                case 'rgb'
                    cb = get_root_data('original_working_cb');
                    cr = get_root_data('original_working_cr');

                    rgb_watermarked = cat(3,watermarked_image,cb,cr);
                case 'red'
                    green = get_root_data('original_working_green');
                    blue = get_root_data('original_working_blue');

                    rgb_watermarked = cat(3,watermarked_image,green,blue);
                case 'green'
                    red = get_root_data('original_working_red');
                    blue = get_root_data('original_working_blue');

                    rgb_watermarked = cat(3,red,watermarked_image,blue);
                case 'blue'
                    red = get_root_data('original_working_red');
                    green = get_root_data('original_working_green');

                    rgb_watermarked = cat(3,red,green,watermarked_image);
            end;
end;