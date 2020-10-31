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

%rotate: rotates image im for a number of degrees
%@im: image to rotate
%@nrOfDegrees: nr of degrees to rotate

function im_rot = rotation_attack(im, nrOfDegrees)

try
    im_rot = imrotate(im, nrOfDegrees);                %rotate image clockwise (therefore -1)
catch
    im_rot = im;
end
    
