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
%%
%make_compatible: this function get an image that normaly isn't compatible
%with dwt or dct calculations. Here we rezise the image so we can use every
%image used.
%@image: image of all formats
%§new_image: compatible image

%% Make Compatible
function new_image = make_compatible(image)

        [widht height temp1 temp2] = size(image);

        mod_widht = mod(widht,32);
        mod_height =  mod(height,32);

        if widht < 256 || height < 256
            msgbox('The image was to small too use: to little information could be embedded. Please select an other image','Error','error');
        else

            if (mod_widht == 0) && (mod_height == 0)
                new_image = image;
            else
                if (mod_widht == 0) && (mod_height ~= 0)
                    if (mod_height <= 16)
                        new_image = imresize(image,[widht (height-(mod_height))]);
                    else
                        new_image = imresize(image,[widht (height+(32-mod_height))]);
                    end;
                elseif (mod_widht ~= 0) && (mod_height == 0)
                    if (mod_widht <= 16)
                        new_image = imresize(image,[(widht-(mod_widht)) height]);
                    else
                        new_image = imresize(image,[(widht+(32-mod_height)) height]);
                    end;
                elseif (mod_widht ~= 0) && (mod_height ~= 0)
                    if (mod_widht <= 16) && (mod_height <= 16)
                        new_image = imresize(image,[(widht-(mod_widht)) (height-(mod_height))]);
                    elseif (mod_widht > 16) && (mod_height > 16)
                        new_image = imresize(image,[(widht+(32-mod_widht)) (height+(32-mod_height))]);
                    elseif (mod_widht <= 16) && (mod_height > 16)
                        new_image = imresize(image,[(widht-(mod_widht)) (height+(32-mod_height))]);
                    elseif (mod_widht > 16) && (mod_height <= 16)
                        new_image = imresize(image,[(widht+(32-mod_widht)) (height-(mod_height))]);
                    end

                end;

            end;
        end;
%%