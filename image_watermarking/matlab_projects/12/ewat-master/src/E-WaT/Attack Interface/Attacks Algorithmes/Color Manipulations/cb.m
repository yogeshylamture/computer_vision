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


%: changes the chrominance (Cb) of the image
%@im: image of which chrominance will be changed
%@chrom: amount of change
%@setting: type of image (grayscale or layered)

function im_chrom = cb(im, chrom, setting)

[H W D] = size(im); 
switch setting
    case 'grayscale'
       msgbox('Selected image is grayscale, so no chrominance attack can be perfomed...', 'Warning', 'info');
       pause
    case 'layered'
        im_chrom = rgb2ycbcr(im);                                         %convert to ycbcr
        im_chrom(:,:,2) = im_chrom(:,:,2).*chrom;                     %apply luminance change
        im_chrom = ycbcr2rgb(im_chrom);                                   %reconvert to rgb
        %rescale to range 0..255
        for i=1:H
            for j=1:W
                for k = 1:D
                    if(im_chrom(i,j,k) > 255)
                        im_chrom(i,j,k) = 255;
                    elseif(im_chrom(i,j,k) <= 0)
                        im_chrom(i,j,k) = 1;
                    end
                end
            end
        end
    otherwise
        msgbox('Unsupported file format', 'Error', 'error');
        pause
end       