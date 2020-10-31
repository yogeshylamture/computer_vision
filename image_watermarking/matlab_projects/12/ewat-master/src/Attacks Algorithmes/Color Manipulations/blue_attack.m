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


%blue_attack: changes the blue component of the image
%@image: image of which chrominance will be changed
%@setting: amount of change

function im_adjusted = blue_attack(image, setting)
try
    [H W D] = size(image);                                                 %determine siz of image
    if D==3.0
            im_adjusted = cat(3,image(:,:,1),image(:,:,2),image(:,:,3)+2.55.*setting);                                    %apply change
    else
            im_adjusted = image+2.55*setting;
    end               
catch
    im_adjusted = image;
end