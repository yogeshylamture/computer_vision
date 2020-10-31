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

%get_layer: here you get back the layer you specify
%@image: give the image for extracting the layer
%@type_layer: rgb or YCbCr
%@nr_layer: wich of the three layers: layer1,layer2,Layer3
%§image_layer: return the image in the right representation for displaying

function [image_layer] = get_layer(im,type_layer,nr_layer)

[width height temp1 temp2] = size(im);
empty_layer = zeros(width,height);

switch type_layer
    case 'ycbcr'
        ycbcr = rgb2ycbcr(im);
        switch nr_layer
            case 'layer1'
                Y_layer = ycbcr(:,:,1);
                image_layer = cat(3,Y_layer,Y_layer,Y_layer);
                
            case 'layer2'
                Cb_layer = ycbcr(:,:,2);
                YCbCr = cat(3,empty_layer,Cb_layer,empty_layer);
                image_layer = ycbcr2rgb(YCbCr);
            case 'layer3'
                Cr_layer = ycbcr(:,:,3);
                YCbCr = cat(3,empty_layer,empty_layer,Cr_layer);
                image_layer = ycbcr2rgb(YCbCr);
        end
    case 'rgb'
        switch nr_layer
            case 'layer1'
                red_layer = im(:,:,1);
                image_layer = cat(3,red_layer, empty_layer,empty_layer);
            case 'layer2'
                green_layer = im(:,:,2);
                image_layer = cat(3,empty_layer,green_layer,empty_layer);
            case 'layer3'
                blue_layer = im(:,:,3);
                image_layer = cat(3,empty_layer,empty_layer,blue_layer);
        end
end
%------------------------------------------------------