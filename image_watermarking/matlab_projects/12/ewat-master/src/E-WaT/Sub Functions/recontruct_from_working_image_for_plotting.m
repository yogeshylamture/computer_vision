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
%recontruct_from_working_image_for_plotting: this function reconstructs an image
% so that calculations can be done on single layer en that the other layers
% are used the reconstruct them so that the layer is mayed plotteble
%@watermarked_image: single layer image
%@rgb_image: rgb image

function plot_watermarked = recontruct_from_working_image_for_plotting(watermarked_image)

used_component = get_root_data('used_component');
[width height temp1] = size(watermarked_image);
empty = zeros(width, height);

switch used_component
    case 'grayscale'
        plot_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
    case 'ycbcr'
        plot_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
    case 'y'
        plot_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
    case 'cb'
        plot_watermarked_ycbcr = cat(3,empty,watermarked_image,empty);
        plot_watermarked = ycbcr2rgb(plot_watermarked_ycbcr);
    case 'cr'
        plot_watermarked_ycbcr = cat(3,empty,empty,watermarked_image);
        plot_watermarked = ycbcr2rgb(plot_watermarked_ycbcr);
    case 'rgb'
        plot_watermarked = cat(3,watermarked_image,watermarked_image,watermarked_image);
    case 'red'
        plot_watermarked = cat(3,watermarked_image,empty,empty);
    case 'green'
        plot_watermarked = cat(3,empty,watermarked_image,empty);
    case 'blue'
        plot_watermarked = cat(3,empty,empty,watermarked_image);
end;