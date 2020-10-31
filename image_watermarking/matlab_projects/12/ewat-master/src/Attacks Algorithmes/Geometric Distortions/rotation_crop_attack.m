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

%rotate: rotates image im for a number of degrees
%@im: image to rotate
%@nrOfDegrees: nr of degrees to rotate

function im_rot_crop = rotation_crop_attack(image, nrOfDegrees)

try
    [original_H original_W original_D] = size(image);
    image_rotated = imrotate(image, nrOfDegrees);                %rotate image clockwise (therefore -1)
    
    [rotated_H rotated_W,rotated_D] = size(image_rotated);
    diff_h = rotated_H-original_H;
    diff_w = rotated_W-original_W;
    a = round(diff_h/2);
    b = round(diff_w/2);
    crop_step1 = imcrop(image_rotated,[a b rotated_H-1 rotated_W-1]);
    im_rot_crop = imcrop(crop_step1,[1 1 original_H-1 original_W-1]);
catch
    im_rot_crop = image;
end
