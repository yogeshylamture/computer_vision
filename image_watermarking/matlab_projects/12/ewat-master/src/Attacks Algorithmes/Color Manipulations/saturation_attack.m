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


%saturation_attack: changes the saturation component of the image
%@image: image of which saturation will be changed
%@setting: amount of change

function im_adjusted = saturation_attack(image, setting)
try
    [H W D] = size(image);                                                 %determine size of image
    if D==3.0
            image = (rgb2hsv(image));
            new_layer = zeros(H,W);
            for i = 1:H
                for j = 1:W
                    value = image(i,j,2);
                    if value == 0; 
                        new_layer(i,j) = image(i,j,2);
                    else
                            new_layer(i,j) = image(i,j,2)+setting/100;
                    end
                end
            end
            im_adjusted_hsv = cat(3,image(:,:,1),new_layer,image(:,:,3));                                    %apply change
            im_adjusted = im2uint8(hsv2rgb(im_adjusted_hsv));
    else
            im_adjusted = image+2.55*setting;
    end               
catch
    im_adjusted = image;
end
