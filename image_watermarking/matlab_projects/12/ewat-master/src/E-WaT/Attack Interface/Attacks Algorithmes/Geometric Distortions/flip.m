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

%flip: flips image im 
%@im: image to flip
%@dir: 'H' = flip horizontal,  'V' = flip vertical

function im_flip = flip(im, dir)

[H W D] = size(im);                                     %determine size of image
im_flip = uint8(zeros(H,W,3));                          %create empty flipped image
for i=1:3
    if (dir == 'H')
        im_flip(:,:,i) = fliplr(im(:,:,i));                 %flip every layer of image horizontally
    elseif (dir == 'V')
        im_flip(:,:,i) = flipud(im(:,:,i));

    end
end