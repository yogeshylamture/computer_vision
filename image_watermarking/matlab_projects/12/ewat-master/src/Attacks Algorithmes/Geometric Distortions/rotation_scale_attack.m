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

function im_rot_rescale = rotation_scale_attack(im, nrOfDegrees)

try
    [H W D] = size(im);
    im_rot = imrotate(im, nrOfDegrees);                %rotate image clockwise (therefore -1)
    im_rot_rescale = imresize(im_rot,[H W]);
catch
    im_rot_rescale = im;
end
