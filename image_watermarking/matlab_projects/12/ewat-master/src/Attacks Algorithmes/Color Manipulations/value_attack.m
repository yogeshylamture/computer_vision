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


%value_attack: changes the value component of the image
%@image: image of which chrominance will be changed
%@setting: amount of change

function im_adjusted = value_attack(image, setting)
try
    [H W D] = size(image);                                                 %determine siz of image
    if D==3.0
            image = (rgb2hsv(image));
            new_layer = zeros(H,W);
            for i = 1:H
                for j = 1:W
                        new_layer(i,j) = image(i,j,3) + setting/100;                        ;
                    
                end
            end
            im_adjusted_hsv = cat(3,image(:,:,1),image(:,:,2),new_layer);                                    %apply change
            im_adjusted = hsv2rgb(im_adjusted_hsv);
    else
            im_adjusted = image+2.55*setting;
    end               
catch
    im_adjusted = image;
end