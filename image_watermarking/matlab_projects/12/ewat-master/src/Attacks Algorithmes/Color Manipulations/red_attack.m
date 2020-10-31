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


%red_attack: changes the red component of the image
%@image: image of which chrominance will be changed
%@setting: amount of change

function im_adjusted = red_attack(image, setting)
try
    [H W D] = size(image);                                                 %determine siz of image
    if D==3.0
            im_adjusted = cat(3,image(:,:,1)+2.55.*setting,image(:,:,2),image(:,:,3));                                    %apply change
    else
            im_adjusted = image+2.55*setting;
    end               
catch
    im_adjusted = image;
end