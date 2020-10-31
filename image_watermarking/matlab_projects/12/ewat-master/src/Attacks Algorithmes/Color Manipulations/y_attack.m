%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                                Kevin Heylen                             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%y_attack: changes the y component of the image
%@image: image of which luminance will be changed
%@setting: amount of change

function im_adjusted = y_attack(image, setting)
try
    [H W D] = size(image);                                                 %determine siz of image
    if D==3.0
            image = rgb2ycbcr(image);
            im_adjusted_ycbcr = cat(3,image(:,:,1)+2.55.*setting,image(:,:,2),image(:,:,3));                                    %apply change
            im_adjusted = ycbcr2rgb(im_adjusted_ycbcr);
    else
            im_adjusted = image+2.55*setting;
    end               
catch
    im_adjusted = image;
end