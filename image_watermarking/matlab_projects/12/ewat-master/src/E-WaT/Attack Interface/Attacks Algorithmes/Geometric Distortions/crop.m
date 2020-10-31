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


%im_crop: applies cropping to an image
%@im: image to crop
%@cropPercent: percent of the image that wille be cropped
%@dir: direction to crop ('Top', 'Bottom', 'Left', 'Right')

function im_crop = crop(im, cropPercent, dir)

[H W D] = size(im);                                     %get size of image
newH = floor((1-(cropPercent/100))*H);                    %determine new H based on cropPercent
newW = floor((1-(cropPercent/100))*W);                  %determine new H based on cropPercent

switch(dir)
    case 'Top'
        im_crop = uint8(zeros(newH, W, D));      %create empty cropped image

        for i=1:newH
            for j=1:W
                im_crop(i,j,:) = im(i+(H-newH),j,:);
            end
        end
    case 'Bottom'
        im_crop = uint8(zeros(newH, W, D));      %create empty cropped image

        for i=1:newH
            for j=1:W
                im_crop(i,j,:) = im(i,j,:);
            end
        end
    case 'Left'
        im_crop = uint8(zeros(H, newW, D));                     %create empty cropped image
        for i=1:H
            for j=1:newW
                im_crop(i,j,:) = im(i,j+(W-newW),:);
            end
        end
    case 'Right'
        im_crop = uint8(zeros(H, newW, D));                     %create empty cropped image
        for i=1:H
            for j=1:newW
                im_crop(i,j,:) = im(i,j,:);
            end
        end
end