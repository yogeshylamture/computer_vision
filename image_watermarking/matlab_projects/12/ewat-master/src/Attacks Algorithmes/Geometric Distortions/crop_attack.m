%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                               Kevin Heylen                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%crop_attack: applies cropping to an image
%@im: image to crop
%@cropPercent: percent of the image that will be cropped

function im_crop = crop_attack(image, cropPercent)

try
    [H W D] = size(image);                                     %get size of image
    crop_H = floor(cropPercent/100*H);                    %determine new H based on cropPercent
    crop_W = floor(cropPercent/100*W);                  %determine new H based on cropPercent

    new_H = H-crop_H;
    new_W = W-crop_W;

    im_crop = imcrop(image,[0 0 new_H new_W]);          % 0 0 offset
catch
    im_crop = image;
end
    




