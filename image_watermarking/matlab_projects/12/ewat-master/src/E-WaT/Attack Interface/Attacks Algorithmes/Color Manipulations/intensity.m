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

%im_int: changes the intensity of the image
%@im: image to change
%@intensityFactor: amount of change in intensity

function im_int = intensity(im, intensityFactor)

[H W D] = size(im);                                         %get size of image
im_int = im*intensityFactor;                                %change intensity 
for i=1:H
    for j=1:W
        for k = 1:D
            if(im_int(i,j,k) > 255)
                im_int(i,j,k) = 255;
            elseif(im_int(i,j,k) <= 0)
                im_int(i,j,k) = 1;
            end
        end
    end
end
