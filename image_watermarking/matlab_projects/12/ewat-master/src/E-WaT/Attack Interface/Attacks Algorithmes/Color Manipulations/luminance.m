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

%luminance: changes the luminance of the image
%@im: image of whihc luminance will be changed
%@lum: amount of change in luminance
%@setting: tuype of image (grayscale or layered)

function im_lum = luminance(im, lum, setting)

[H W D] = size(im);                                                 %determine siz of image
switch setting
    case 'grayscale'
       im_lum = im.*lum;
    case 'layered'
        im_lum = rgb2ycbcr(im);                                         %convert to ycbcr
        im_lum(:,:,1) = im_lum(:,:,1).*lum;                             %apply luminance change
        im_lum = ycbcr2rgb(im_lum); 
    otherwise
        msgbox('Unsupported file format', 'Error', 'error');
        pause
end                                                                     %reconvert to rgb

%rescale to range 0..255
for i=1:H
    for j=1:W
        for k = 1:D
            if(im_lum(i,j,k) > 255)
                im_lum(i,j,k) = 255;
            elseif(im_lum(i,j,k) <= 0)
                im_lum(i,j,k) = 1;
            end
        end
    end
end