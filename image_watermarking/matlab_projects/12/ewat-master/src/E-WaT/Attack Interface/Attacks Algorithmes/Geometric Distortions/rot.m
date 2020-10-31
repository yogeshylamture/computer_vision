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

%rotate: rotates image im for a number of degrees
%@im: image to rotate
%@nrOfDegrees: nr of degrees to rotate
%@CW: boolean which defines wether or not to rotate clockwise

function im_rot_rescale = rot(im, nrOfDegrees, CW)

if (CW == 1)
    im_rot = imrotate(im, nrOfDegrees*(-1));                %rotate image clockwise (therefore -1)
else
    im_rot = imrotate(im, nrOfDegrees);
end
im_rot_rescale = removeEmptyBorders(im_rot);            %call this function to remove empty (black) borders
