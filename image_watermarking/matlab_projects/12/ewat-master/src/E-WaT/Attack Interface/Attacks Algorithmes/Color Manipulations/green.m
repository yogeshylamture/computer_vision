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


%green: changes the green component of the image
%@im: image of which chrominance will be changed
%@g: amount of change
%@setting: type of image (grayscale or layer)


function im_g = green(im_g, g, setting)

[H W D] = size(im_g);                                                 %determine siz of image
switch setting
    case 'grayscale'
        msgbox('Selected image is grayscale, so no chrominance attack can be perfomed...', 'Warning', 'info');
        pause
    case 'layered'
        im_g(:,:,2) = im_g(:,:,2).*g;                                    %apply cr change
        %rescale to range 0..255
        for i=1:H
            for j=1:W
                for k = 1:D
                    if(im_g(i,j,k) > 255)
                        im_g(i,j,k) = 255;
                    elseif(im_g(i,j,k) <= 0)
                        im_g(i,j,k) = 1;
                    end
                end
            end
        end
        im_g = uint8(im_g);
    otherwise
        msbox('Unsupported file format', 'Error', 'error');
        pause
end