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


%red: changes the red component of the image
%@im: image of which chrominance will be changed
%@r: amount of change
%@setting: type of image (grayscale or layer)

function im_r = red(im_r, r, setting)

[H W D] = size(im_r);                                                 %determine siz of image
switch setting
    case 'grayscale'
        msgbox('Selected image is grayscale, so no chrominance attack can be perfomed...', 'Warning', 'info');
        pause
    case 'layered'
        im_r(:,:,1) = im_r(:,:,1).*r;                                    %apply cr change
        %rescale to range 0..255
        for i=1:H
            for j=1:W
                for k = 1:D
                    if(im_r(i,j,k) > 255)
                        im_r(i,j,k) = 255;
                    elseif(im_r(i,j,k) <= 0)
                        im_r(i,j,k) = 1;
                    end
                end
            end
        end
        im_r = uint8(im_r);
    otherwise
        msgbox('Unsupported file format', 'Error', 'error');
        pause
end               