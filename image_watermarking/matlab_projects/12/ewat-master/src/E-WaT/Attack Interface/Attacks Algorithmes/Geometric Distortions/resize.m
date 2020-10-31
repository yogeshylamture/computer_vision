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

%resize: resizes the image
%@im: image to resize
%@percent: image will be resized to this percent of the original
%@dir: direction of resize ('H' or 'W' for height or width)

function im_resized = resize(im, percent, dir)

[H W D] = size(im);                                                 %determine size of image
if (dir == 'W')
    newW = round(percent*W );                                       %compute new width based on slider value
    if(percent ~= 0 && newW > 2)
        im_resized = imresize(im, [H, newW]);                               %resize image
    else
        im_resized = im;
        msgbox('This action will result in an empty image or an image that can''t be displayed properly', 'Error', 'error');
        pause
    end
else
    newH = round(percent*H );                                     %compute new width based on slider value
    if(percent ~= 0 && newH > 2)
        im_resized = imresize(im, [newH, W]);                               %resize image
    else
        msgbox('This action will result in an empty image or an image that can''t be displayed properly', 'Error', 'error');
        pause
    end
end
