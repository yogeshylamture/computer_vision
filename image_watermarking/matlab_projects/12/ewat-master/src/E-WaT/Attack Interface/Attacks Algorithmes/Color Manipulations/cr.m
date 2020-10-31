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


%cr: changes the chrominance (cr) of the image
%@im: image of which chrominance will be changed
%@cr: amount of change
%@setting: type of image (grayscale or layered)

function im_cr = cr(im, cr_, setting)

[H W D] = size(im);                                                 %determine siz of image
switch setting
    case 'grayscale'
        msgbox('Selected image is grayscale, so no chrominance attack can be perfomed...', 'Warning', 'info');
        pause
    case 'layered'
        im_cr = rgb2ycbcr(im);                                         %convert to ycbcr
        im_cr(:,:,3) = im_cr(:,:,3).*cr_;                               %apply cr change
        im_cr = ycbcr2rgb(im_cr);                                      %reconvert to rgb
        %rescale to range 0..255
        for i=1:H
            for j=1:W
                for k = 1:D
                    if(im_cr(i,j,k) > 255)
                        im_cr(i,j,k) = 255;
                    elseif(im_cr(i,j,k) <= 0)
                        im_cr(i,j,k) = 1;
                    end
                end
            end
        end
    otherwise
        msbgox('Unsupported file format', 'Error', 'error');
        pause
end
