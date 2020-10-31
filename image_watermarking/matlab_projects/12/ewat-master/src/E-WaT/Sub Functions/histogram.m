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

%histogram: display the histogram of a color image
%@image: the image to work with
%@type: rgb or ycbcr
function [hist_layer1,hist_layer2,hist_layer3] = histogram(im,type)  %,show, normalize
switch type
    case 'rgb'
        red = im(:,:,1);
        green = im(:,:,2);
        blue = im(:,:,3);

        hist_layer1 = imhist(red);
        hist_layer2 = imhist(green);
        hist_layer3 = imhist(blue);
    case 'ycbcr'
        image_ycbcr = rgb2ycbcr(im);
        
        y = image_ycbcr(:,:,1);
        cb = image_ycbcr(:,:,2);
        cr = image_ycbcr(:,:,3);

        hist_layer1 = imhist(y);
        hist_layer2 = imhist(cb);
        hist_layer3 = imhist(cr);
    
end