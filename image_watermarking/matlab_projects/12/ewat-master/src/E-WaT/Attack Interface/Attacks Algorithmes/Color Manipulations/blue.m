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


%blue: changes the blue component of the image
%@im: image of which chrominance will be changed
%@b: amount of change
%@setting: type of image (grayscale or layer)

function im_b = blue(im_b, b, setting)

[H W D] = size(im_b);                                                 %determine siz of image
switch setting
    case 'grayscale'
        msgbox('Selected image is grayscale, so no chrominance attack can be perfomed...', 'Warning', 'info');
        pause
    case 'layered'
        im_b(:,:,3) = im_b(:,:,3).*b;                                    %apply cr change
        %rescale to range 0..255
        for i=1:H
            for j=1:W
                for k = 1:D
                    if(im_b(i,j,k) > 255)
                        im_b(i,j,k) = 255;
                    elseif(im_b(i,j,k) <= 0)
                        im_b(i,j,k) = 1;
                    end
                end
            end
        end
        im_b = uint8(im_b);
    otherwise
        msbox('Unsupported file format', 'Error', 'error');
        pause
end
